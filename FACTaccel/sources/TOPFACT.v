`timescale 1ns / 1ps
module FactorialModule(go,clk,rst,A,Result,done,cs);

wire CNTLD,UD,CE,CNTRST,greater,BUFEN,MUXSEL1,MUXSEL2,REGLD;
input go,clk,rst;
input [3:0] A;
output done;
output [31:0] Result;
output [2:0] cs;



CU INST1(go,clk,rst,CNTLD,UD,CE,CNTRST,greater,BUFEN,MUXSEL1,MUXSEL2,REGLD,done,cs);
DP INST2(A,CNTLD,UD,CE,CNTRST,greater,BUFEN,MUXSEL1,MUXSEL2,clk,REGLD,Result);

endmodule
