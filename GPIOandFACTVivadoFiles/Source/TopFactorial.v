`timescale 1ns / 1ps
module TopFactorial(clk,rst,WD,WE,A,RD);
input clk,rst;
input [3:0] WD;
input [1:0] A;
input WE;
output [31:0] RD;


wire [2:0]  cs;
wire [31:0] Result;
wire        done,WE1,WE2,DoneRes;
wire [1:0]  RdSel;
wire [3:0]  RegQ1;
wire [31:0] ResultReg;
wire        outputWD,andOutput,andOutputReg;

AddressDecodeFact FACT0(A,WE,WE1,WE2,RdSel);                    //address decoder
ParaRegFile #(4)  FACT1(clk,WE1,rst,WD[3:0],RegQ1);
ParaRegFile #(1)  FACT2(clk,WE2,rst,WD[0],outputWD);           //2nd register for Go bit that goes to the multiplexer
andmodule         FACT3(WE2,WD[0],andOutput);                   //and module that goes to 3rd register
TopFact           FACT5(rst,clk,andOutput,RegQ1,Result,cs,done);      //factorial module

ParaRegFile #(1)  FACT6(clk,1'b1,rst,done,DoneRes);             //1 bit reg file for Done signal
ParaRegFile #(32) FACT7(clk,done,rst,Result,ResultReg);        //32 bit reg for result output 

mux3              FACT8(RdSel,{28'b0,RegQ1},{31'b0,outputWD},{31'b0,DoneRes},ResultReg,RD); //chooses between 4 outputs

endmodule
