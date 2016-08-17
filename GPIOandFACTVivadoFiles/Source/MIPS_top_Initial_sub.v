
//------------------------------------------------
// Source Code for a Single-cycle MIPS Processor (supports partial instruction)
// Developed by D. Hung, D. Herda and G. Gerken,
// based on the following source code provided by
// David_Harris@hmc.edu (9 November 2005):
//    mipstop.v
//    mipsmem.v
//    mips.v
//    mipsparts.v
// Modified by Nelson Wong for CMPE 140, Sp'2016
//------------------------------------------------

// Control Unit
module controller(
  input          zero,
  input  [ 5:0]  funct,
  input  [ 5:0]  op, 
  output         alusrc, 
  output         jump,
  output         memtoreg, 
  output         memwrite, 
  output         pcsrc, 
  output         regdst, 
  output         regwrite, 
  output         multu, 
  output         mfhi,  
  output         mflo,  
  output         jr,    
  output         jal,   
  output         sll,   
  output         srl,   
  output [ 2:0]  alucontrol 
  );

  wire   [ 1:0]  aluop;
  wire           branch;

  maindec  md( 
    .op(op), 
    .memtoreg(memtoreg), 
    .memwrite(memwrite), 
    .branch(branch), 
    .alusrc(alusrc), 
    .regdst(regdst), 
    .regwrite(regwrite), 
    .jump(jump), 
    .jal(jal),     
    .aluop(aluop)
    );
              
  aludec  ad( 
    .funct(funct), 
    .aluop(aluop), 
    .multu(multu), 
    .mfhi(mfhi),   
    .mflo(mflo),   
    .jr(jr),       
    .sll(sll),     
    .srl(srl),     
    .alucontrol(alucontrol)
    );

  assign pcsrc = branch & zero;
endmodule

// Data Path (excluding the instruction and data memories)
module datapath(
  input          alusrc,
  input           clk, 
  input          jump,
  input          memtoreg, 
  input          pcsrc, 
  input          regdst, 
  input          regwrite,
  input          reset, 
  input          multu, 
  input          mfhi,  
  input          mflo,  
  input          jr,    
  input          jal,   
  input          sll,   
  input          srl,   
  input  [ 2:0]  alucontrol,
  input  [ 4:0]  dispSel,
  input  [31:0]  instr,
  input  [31:0]  readdata,
  output         zero,
  output [31:0]  aluout, 
  output [31:0]  dispDat, 
  output [31:0]  pc,
  output [31:0]  writedata
  );

  wire   [ 4:0]  writereg;
  wire   [31:0]  pcnext, 
                 pcnextbr, 
                 pcplus4, 
                 pcbranch, 
                 signimm, 
                 signimmsh, 
                 srca, 
                 srcb, 
                 result;
  wire   [ 4:0]  wrmux_out; 
  wire   [31:0]  pcplus8;
  wire   [31:0]  pcnextjr;   
  wire   [31:0]  product_hi; 
  wire   [31:0]  product_lo; 
  wire   [31:0]  hireg_out; 
  wire   [31:0]  loreg_out; 
  wire   [31:0]  resmux_out;
  wire   [31:0]  hiresmux_out; 
  wire   [31:0]  loresmux_out; 
  wire   [31:0]  jalresmux_out;
  wire   [31:0]  sllresmux_out;
  wire   [31:0]  rightshifter_out;
  wire   [31:0]  leftshifter_out;

  // next PC logic
  mux2 #(32)  pcjrmux( 
    .d0(pcplus4),
    .d1(srca), 
    .s(jr), 
    .y(pcnextjr) 
    );
  
  mux2 #(32)  pcbrmux(
    .d0(pcnextjr), 
    .d1(pcbranch), 
    .s(pcsrc), 
    .y(pcnextbr)
    );
  
  mux2 #(32)  pcmux(
    .d0(pcnextbr), 
    .d1({pcplus4[31:28], instr[25:0], 2'b00}), 
    .s(jump), 
    .y(pcnext)
    );
  
  flopr #(32) pcreg(
    .clk(clk), 
    .reset(reset), 
    .d(pcnext), 
    .q(pc)
    );
                    
  adder pcadd1( 
    .a(pc), 
    .b(32'b100), 
    .y(pcplus4)
    );
  
  adder pcadd2(
    .a(pc),
    .b(32'b1000),
    .y(pcplus8)
  );
  
  sl2 immsh(
    .a(signimm), 
    .y(signimmsh)
    );
  
  adder pcadd3( 
    .a(pcplus4), 
    .b(signimmsh), 
    .y(pcbranch)
    );
                      
  // register file logic
  regfile rf( 
    .clk(clk), 
    .we3(regwrite), 
    .ra1(instr[25:21]), 
    .ra2(instr[20:16]), 
    .wa3(writereg), 
    .wd3(result), 
    .rd1(srca), 
    .rd2(writedata), 
    .ra4(dispSel), 
    .rd4(dispDat)
    );
                
  mux2 #(5) wrmux(
    .d0(instr[20:16]), 
    .d1(instr[15:11]), 
    .s(regdst), 
    .y(wrmux_out)
    );

  mux2 #(5) wrjalmux(
    .d0(wrmux_out),
    .d1(5'b11111),
    .s(jal),
    .y(writereg)
  );
    
  signext se( 
    .a(instr[15:0]), 
    .y(signimm)
    );
                  
  mux2 #(32) srcbmux(
    .d0(writedata), 
    .d1(signimm), 
    .s(alusrc), 
    .y(srcb)
    );

  // Execute logic
  alu alu(
    .a(srca), 
    .b(srcb), 
    .alucont(alucontrol), 
    .result(aluout), 
    .zero(zero)
    );
  
  multiplier multiplier( 
    .a(srca),
    .b(srcb),
    .product_hi(product_hi), 
    .product_lo(product_lo)  
  );
    
  leftshifter leftshifter(
    .a(srcb),
    .b(instr[10:6]),
    .y(leftshifter_out)
  );
  
  rightshifter rightshifter(
    .a(srcb),
    .b(instr[10:6]),
    .y(rightshifter_out)
  );
  
  flopenr #(32) hireg( 
    .clk(clk), 
    .reset(reset), 
    .en(multu), 
    .d(product_hi), 
    .q(hireg_out) 
    );
    
  flopenr #(32) loreg( 
    .clk(clk), 
    .reset(reset), 
    .en(multu), 
    .d(product_lo), 
    .q(loreg_out) 
    );
    
  // Result multiplexers
  mux2 #(32) resmux( 
    .d0(aluout), 
    .d1(readdata), 
    .s(memtoreg), 
    .y(resmux_out)
    );
  mux2 #(32) hiresmux( 
    .d0(resmux_out),        
    .d1(hireg_out),     
    .s(mfhi),           
    .y(hiresmux_out)    
    );
    
  mux2 #(32) loresmux( 
    .d0(hiresmux_out),  
    .d1(loreg_out),     
    .s(mflo),           
    .y(loresmux_out)    
    );
    
  mux2 #(32)  jalresmux(
    .d0(loresmux_out),
    .d1(pcplus8),
    .s(jal),
    .y(jalresmux_out)
  );
    
  mux2 #(32) sllresmux(
    .d0(jalresmux_out),
    .d1(leftshifter_out),
    .s(sll),
    .y(sllresmux_out)
  );
  
  mux2 #(32) srlresmux(
    .d0(sllresmux_out),
    .d1(rightshifter_out),
    .s(srl),
    .y(result)
  );
    
endmodule
