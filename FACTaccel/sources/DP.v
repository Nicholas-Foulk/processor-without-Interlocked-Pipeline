`timescale 1ns / 1ps
module DP(input [3:0] A, input LD, input UD, input CE, input CNTRST, 
          output smaller,
          input BUFEN,
          input MUXSEL1,MUXSEL2,
          input clk,REGLD,
          output [31:0] bufout
    );
wire [3:0] OUTCNT;
wire [3:0] OUTMUX1;
wire [31:0] OUTMUX2;
wire [31:0] multiresult;
wire [31:0] Outa;
wire [31:0] OUTMULTI;


UD_CNT_4 INST3(A, LD, UD, CE, clk, CNTRST, OUTCNT);   //this may have problems 
comparator INST4(OUTCNT, 4'b0001, smaller); //equal, greater, smaller);
multiplexer1 INST5(4'b0001, OUTCNT, MUXSEL1, OUTMUX1);
multiply INST6(multiresult, OUTMUX1, Outa);
multiplexer2 INST7(32'b0000000000_0000000000_0000000000_01, multiresult, MUXSEL2, OUTMUX2);
Register_File INST8(OUTMUX2, Outa, clk, REGLD); 
filter INST9(BUFEN, Outa, bufout);

endmodule

