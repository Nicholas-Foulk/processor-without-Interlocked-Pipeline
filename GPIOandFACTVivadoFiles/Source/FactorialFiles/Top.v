`timescale 1ns / 1ps

module TopFact(input reset,clock,go,input [3:0]factorial,output [31:0]result,output [2:0]cs, output done);

wire smaller_than;
wire sel1,buffer,ld_reg,ld_count,en_count,sel2;

CU samp1(go, clock, reset, smaller_than, sel1,buffer,ld_reg,ld_count,en_count,sel2, done,cs);
DP samp2(clock,sel1,sel2,buffer,ld_reg,ld_count,en_count,factorial,smaller_than,result);
endmodule
