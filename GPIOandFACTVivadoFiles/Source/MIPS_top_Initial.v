
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

// The MIPS (excluding the instruction and data memories)
module mips(
  input         clk, 
  input         reset,
  input  [ 4:0] dispSel,
  input  [31:0] instr,
  input  [31:0] readdata,
  output        memwrite,
  output [31:0] aluout, 
  output [31:0] dispDat,
  output [31:0] pc,
  output [31:0] writedata
  );

  // deleted wire "branch" - not used
  wire          memtoreg, 
                pcsrc, 
                zero, 
                alusrc, 
                regdst, 
                regwrite, 
                jump;
  wire  [2:0]   alucontrol;

  controller c(
    .op(instr[31:26]), 
    .funct(instr[5:0]), 
    .zero(zero),
    .memtoreg(memtoreg), 
    .memwrite(memwrite), 
    .pcsrc(pcsrc),
    .alusrc(alusrc), 
    .regdst(regdst), 
    .regwrite(regwrite), 
    .jump(jump),
    .multu(multu), 
    .mfhi(mfhi),  
    .mflo(mflo),  
    .jr(jr),    
    .jal(jal),   
    .sll(sll),   
    .srl(srl),   
    .alucontrol(alucontrol)
    );
               
  datapath dp(
    .clk(clk), 
    .reset(reset), 
    .memtoreg(memtoreg), 
    .pcsrc(pcsrc),
    .alusrc(alusrc), 
    .regdst(regdst), 
    .regwrite(regwrite), 
    .jump(jump),
    .multu(multu), 
    .mfhi(mfhi),  
    .mflo(mflo),  
    .jr(jr),    
    .jal(jal),   
    .sll(sll),   
    .srl(srl),   
    .alucontrol(alucontrol), 
    .zero(zero), 
    .pc(pc), 
    .instr(instr), 
    .aluout(aluout), 
    .writedata(writedata), 
    .readdata(readdata), 
    .dispSel(dispSel), 
    .dispDat(dispDat));
endmodule

// Instruction Memory
module imem (
  input  [ 5:0]  a,
  output [31:0]  dOut );
  
  reg    [31:0]  rom[0:63];
  
  //initialize rom from memfile_s.dat
  initial 
    $readmemh("memfile_s.dat", rom);
  
  //simple rom
    assign dOut = rom[a];
endmodule

// Data Memory
module dmem (
  input         clk,
  input         we,
  input  [31:0] addr,
  input  [31:0] dIn,
  output [31:0] dOut );
  
  reg    [31:0]  ram[63:0];
  integer        n;
  
  //initialize ram to all FFs
  initial 
    for (n=0; n<64; n=n+1)
      ram[n] = 8'hFF;
    
  assign dOut = ram[addr[31:2]];
        
  always @(posedge clk)
    if (we) 
      ram[addr[31:2]] = dIn; 
endmodule
