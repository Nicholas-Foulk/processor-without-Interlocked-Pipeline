
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

// Main Decoder
module maindec(
  input  [ 5:0] op,
  output        memtoreg, 
  output        memwrite, 
  output        branch, 
  output        alusrc, 
  output        regdst, 
  output        regwrite, 
  output        jump,
  output        jal, 
  output [ 1:0] aluop 
  );

  reg    [ 9:0] controls;

  assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, jal, aluop} = controls;

  always @(*)
    case(op)
    //                           regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, jal, aluop
      6'b000000: controls <= 10'b_______1_______1_______0_______0_________0_________0_____0____0_____10; //Rtype
      6'b100011: controls <= 10'b_______1_______0_______1_______0_________0_________1_____0____0_____00; //LW
      6'b101011: controls <= 10'b_______0_______0_______1_______0_________1_________0_____0____0_____00; //SW
      6'b000100: controls <= 10'b_______0_______0_______0_______1_________0_________0_____0____0_____01; //BEQ
      6'b001000: controls <= 10'b_______1_______0_______1_______0_________0_________0_____0____0_____00; //ADDI
      6'b000010: controls <= 10'b_______0_______0_______0_______0_________0_________0_____1____0_____00; //J
      6'b000011: controls <= 10'b_______0_______0_______0_______0_________0_________0_____1____1_____00; //JAL, 03h 
      default:   controls <= 10'b_______x_______x_______x_______x_________x_________x_____x____x_____xx; //???
    endcase
endmodule

// ALU Decoder, also handles R-type instructions
module aludec(
  input      [ 1:0] aluop,
  input      [ 5:0] funct,
  output            multu, 
  output            mfhi,  
  output            mflo,  
  output            jr,    
  output            sll,   
  output            srl,   
  output [ 2:0] alucontrol 
  );
  
  reg        [ 8:0] controls;
  
  assign {multu, mfhi, mflo, jr, sll, srl, alucontrol} = controls;

  always @(*)
    case(aluop)
      2'b00: controls <= {multu, mfhi, mflo, jr, sll, srl,3'b010};  // add
      2'b01: controls <= {multu, mfhi, mflo, jr, sll, srl,3'b110};  // sub
      default: case(funct)          // RTYPE
      //                          multu, mfhi, mflo, jr, sll, srl, alucontrol
        6'b100000: controls <= 9'b____0_____0_____0___0____0____0_________010; // ADD
        6'b100010: controls <= 9'b____0_____0_____0___0____0____0_________110; // SUB
        6'b100100: controls <= 9'b____0_____0_____0___0____0____0_________000; // AND
        6'b100101: controls <= 9'b____0_____0_____0___0____0____0_________001; // OR
        6'b101010: controls <= 9'b____0_____0_____0___0____0____0_________111; // SLT
        6'b011001: controls <= 9'b____1_____0_____0___0____0____0_________xxx; // MULTU, 19h 
        6'b010000: controls <= 9'b____0_____1_____0___0____0____0_________xxx; //  MFHI, 10h 
        6'b010010: controls <= 9'b____0_____0_____1___0____0____0_________xxx; //  MFLO, 12h 
        6'b001000: controls <= 9'b____0_____0_____0___1____0____0_________xxx; //    JR, 08h 
        6'b000000: controls <= 9'b____0_____0_____0___0____1____0_________xxx; //   SLL, 00h 
        6'b000010: controls <= 9'b____0_____0_____0___0____0____1_________xxx; //   SRL, 02h 
        default:   controls <= 9'b____0_____0_____0___0____0____0_________xxx; // ?????
      endcase
    endcase
endmodule

// ALU
module alu(
  input       [ 2:0]  alucont, 
  input       [31:0]  a, 
  input       [31:0]  b, 
  output              zero,
  output reg  [31:0]  result
);

  wire  [31:0]  b2, 
                sum, 
                slt;

  assign b2 = alucont[2] ? ~b:b; 
  assign sum = a + b2 + alucont[2];
  assign slt = sum[31];

  always@(*)
    case(alucont[1:0])
      2'b00: result <= a & b;
      2'b01: result <= a | b;
      2'b10: result <= sum;
      2'b11: result <= slt;
    endcase

  assign zero = (result == 32'b0);
endmodule

// multiplier
module multiplier(
  input  [31:0] a,
  input  [31:0] b,
  output [31:0] product_hi,
  output [31:0] product_lo
  );
  
  assign {product_hi, product_lo} = a*b;
endmodule

// left shifter
module leftshifter(
  input  [31:0] a,
  input  [ 4:0] b,
  output [31:0] y
  );
  
  assign y = a << b;
endmodule

// right shifter
module rightshifter(
  input  [31:0] a,
  input  [ 4:0] b,
  output [31:0] y
);

  assign y = a >> b;
endmodule

// Adder
module adder(
  input   [31:0]  a, 
  input   [31:0]  b,
  output  [31:0]  y 
  );

  assign y = a + b;
endmodule

// Two-bit left shifter
module sl2(
  input   [31:0]  a,
  output  [31:0]  y 
  );

  // shift left by 2
  assign y = {a[29:0], 2'b00};
endmodule

// Sign Extension Unit
module signext(
  input   [15:0]  a,
  output  [31:0]  y 
  );

  assign y = {{16{a[15]}}, a};
endmodule

// Parameterized Register
module flopr #(parameter WIDTH = 8) (
  input                    clk,
  input                    reset,
  input       [WIDTH-1:0]  d, 
  output reg  [WIDTH-1:0]  q);

  always @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;
endmodule

module flopenr #(parameter WIDTH = 8) (
  input       clk, 
  input       reset,
  input       en,
  input       [WIDTH-1:0]  d, 
  output reg  [WIDTH-1:0]  q
  );

  always @(posedge clk, posedge reset)
    if      (reset) q <= 0;
    else if (en)    q <= d;
endmodule

// Parameterized 2-to-1 MUX
module mux2 #(parameter WIDTH = 8) (
  input                s, 
  input   [WIDTH-1:0]  d0, 
  input   [WIDTH-1:0]  d1, 
  output  [WIDTH-1:0]  y 
  );

  assign y = s ? d1 : d0; 
endmodule

// register file with one write port and three read ports
// the 3rd read port is for prototyping dianosis
module regfile(  
  input           clk, 
  input           we3, 
  input   [ 4:0]  ra1, 
  input   [ 4:0]  ra2, 
  input   [ 4:0]  wa3, 
  input   [31:0]  wd3, 
  input   [ 4:0]  ra4,
  output  [31:0]  rd1, 
  output  [31:0]  rd2,
  output  [31:0]  rd4
  );

  reg     [31:0]  rf[31:0];
  integer         n;
  
  //initialize registers to all 0s
  initial 
    for (n=0; n<32; n=n+1) 
      rf[n] = 32'h00;
      
  //write first order, include logic to handle special case of $0
    always @(posedge clk)
        if (we3)
      if (~ wa3[4])
        rf[{0,wa3[3:0]}] <= wd3;
      else
        rf[{1,wa3[3:0]}] <= wd3;
    
      // this leads to 72 warnings
      //rf[wa3] <= wd3;
      
      // this leads to 8 warnings
      //if (~ wa3[4])
      //  rf[{0,wa3[3:0]}] <= wd3;
      //else
      //  rf[{1,wa3[3:0]}] <= wd3;
    
  assign rd1 = (ra1 != 0) ? rf[ra1[4:0]] : 0;
  assign rd2 = (ra2 != 0) ? rf[ra2[4:0]] : 0;
  assign rd4 = (ra4 != 0) ? rf[ra4[4:0]] : 0;
endmodule
