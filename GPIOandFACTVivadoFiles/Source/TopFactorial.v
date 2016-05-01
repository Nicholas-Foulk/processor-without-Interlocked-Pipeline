`timescale 1ns / 1ps
module TopFactorial(clk,rst,WD,WE,A,RD);

input clk,rst;
input [3:0] WD;
input [1:0] A;
input WE;
output [31:0] RD;
output reg go = 1'b1;
wire [2:0] cs;
wire [31:0] Result;
wire done;
wire WE1,WE2;
wire [1:0] RdSel;
input reg [3:0] RegD1,RegD2;
wire [3:0] RegQ1, RegQ2;
wire [31:0] ResultReg;
wire DoneRes;
wire [31:0] FinalOutput;
wire outputWD;
wire andOutput;
wire andOutputReg;

AddressDecodeFact FACT0(A,WE,WE1,WE2,RdSel);                    //address decoder
RegFile4bit       FACT1(RegD1,RegQ1,clk,WE1);                   //first register for storing WD
ParaRegFile #(1)  FACT2(clk,WE2,1'b0,WD[0],outputWD);           //2nd register for Go bit that goes to the multiplexer
andmodule         FACT3(WE2,WD[0],andOutput);                   //and module that goes to 3rd register
ParaRegFile #(1)  FACT4(clk,1'b1,1'b0,andOutput,andOutputReg);  //3rd register before the factorial module
FactorialModule   FACT5(WE2,clk,rst,RegQ1,Result,done,cs);      //factorial module

ParaRegFile #(1)  FACT6(clk,1'b1,rst,done,DoneRes);             //1 bit reg file for Done signal
ParaRegFile #(32) FACT7(clk,done,1'b0,Result,ResultReg);        //32 bit reg for result output 

mux3              FACT8(RdSel,{28'b0,RegQ1},{31'b0,outputWD},{31'b0,DoneRes},ResultReg,FinalOutput); //chooses between 4 outputs

endmodule
