`timescale 1ns / 1ps
module TopGPIO(clk,rst,A,WE,gpI1,gpI2,WD,RD,gpO1,gpO2);

input [1:0] A;
input WE;
input [31:0] gpI1,gpI2,WD;
input rst,clk;
output [31:0] RD,gpO1,gpO2;



wire WE1,WE2;
wire [1:0] RdSel;

//I need to edit the address decoder to output the correct signals
AddressDecodeGPIO GPIO0(A,WE,WE1,WE2,RdSel);

ParaRegFile #(32) GPIO1(clk,WE1,1'b0,WD,gpO1);
ParaRegFile #(32) GPIO2(clk,WE2,1'b0,WD,gpO2);
mux3        #(32) GPIO3(RdSel,gpI1,gpI2,gpO1,gpO2,RD);
endmodule
