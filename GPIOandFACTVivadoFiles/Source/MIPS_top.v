`timescale 1ns / 1ps
// MIPS Top-level Module (including the memories, clock,
// and the display module for prototyping)
 module mips_top(
  input         clk, 
  input         reset, 
  input  [7:0]  switches,
  output        memwrite,
  //output        sinkBit, 
  output [7:0]  LEDSEL, 
  output [7:0]  LEDOUT
  );

  wire          clksec,
                clk_5KHz;
  wire   [31:0] gpO1,gpO2;
  clk_gen top_clk(.clk100MHz(clk),
                  .rst(reset),
                  .clk_sec(clksec),
                  .clk_5KHz(clk_5KHz)
                  );
  
    system system(reset,clksec,{27'b0,switches[4:0]},gpO1,gpO1,gpO2);
      
    wire [7:0] digit0;
    wire [7:0] digit1;
    wire [7:0] digit2;
    wire [7:0] digit3;
    wire [7:0] digit4;
    wire [7:0] digit5;
    wire [7:0] digit6;
    wire [7:0] digit7;
   
    wire [3:0] dig0;
    wire [3:0] dig1;
    wire [3:0] dig2;
    wire [3:0] dig3;
    wire [3:0] dig4;
    wire [3:0] dig5;
    wire [3:0] dig6;
    wire [3:0] dig7;
    
      bcd_to_7seg bcd0 (gpO2[3:0], digit0);
      bcd_to_7seg bcd1 (gpO2[7:4], digit1);
      bcd_to_7seg bcd2 (gpO2[11:8], digit2);
      bcd_to_7seg bcd3 (gpO2[15:12], digit3);
      
      bcd_to_7seg bcd4 (gpO2[19:16], digit4);
      bcd_to_7seg bcd5 (gpO2[23:20], digit5);
      bcd_to_7seg bcd6 (gpO2[27:24], digit6);
      bcd_to_7seg bcd7 (gpO2[31:28], digit7);
   // bin2bcd32 bin2bcd32(gpO2,dig0,dig1,dig2,dig3,dig4,dig5,dig6,dig7);
//    bcd_to_7seg bcd0(dig0, digit0);
//    bcd_to_7seg bcd1(dig1, digit1);
//    bcd_to_7seg bcd2(dig2, digit2);
//    bcd_to_7seg bcd3(dig3, digit3);
    
//    bcd_to_7seg bcd4(dig4, digit4);
//    bcd_to_7seg bcd5(dig5, digit5);
//    bcd_to_7seg bcd6(dig6, digit6);
//    bcd_to_7seg bcd7(dig7, digit7);
   
    LED_MUX disp_unit (
        clk_5KHz,
        reset,
        digit7,
        digit6,
        digit5,
        digit4,
        digit3,
        digit2,
        digit1,
        digit0,
        LEDOUT,
        LEDSEL        
        );
  
/*
    7:5 = 000 : Display LSW of register selected by DSW 4:0
    7:5 = 001 : Display MSW of register selected by DSW 4:0
    7:5 = 010 : Display LSW of instr
    7:5 = 011 : Display MSW of instr
    7:5 = 100 : DIsplay LSW of dataaddr
    7:5 = 101 : Display MSW of dataaddr
    7:5 = 110 : Display LSW of writedata
    7:5 = 111 : Display MSW of writedata
*/  
  //this isn't going to work in lab 8
//  always @ (posedge clk) 
//  begin
//    case ({switches[7],switches[6], switches[5]})
//      3'b000:  reg_hex = dispDat[15:0];
//      3'b001:  reg_hex = dispDat[31:16];
//      3'b010:  reg_hex = instr[15:0];
//      3'b011:  reg_hex = instr[31:16];
//      3'b100:  reg_hex = dataadr[15:0];
//      3'b101:  reg_hex = dataadr[31:16];
//      3'b110:  reg_hex = writedata[15:0];
//      3'b111:  reg_hex = writedata[31:16];
//    endcase
//  end    

  //sink unused bit(s) to knock down the number of warning messages
//  assign sinkBit = (pc > 0) ^ (instr > 0) ^ (dataadr > 0) ^ (writedata > 0) ^ 
//           (readdata > 0) ^ (dispDat > 0);
endmodule
