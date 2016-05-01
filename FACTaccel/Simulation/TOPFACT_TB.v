`timescale 1ns / 1ps
module TOPFACT_TB( );
reg go,clk,rst;
reg [3:0] A;
wire done;  //done output
wire [2:0] cs;   //current state
integer b;
wire [31:0] Result;
//39 mandatory loops for a 10 factorial case
TOPFACT SAMP1(go, clk, rst, A, Result, done, cs);

initial
    begin
    rst = 0; #5;
    rst = 1; #5;
    rst = 0; #5;
    go = 1; #5;
    A = 4'b0010;
    
    for(b = 0; b<9'b100000000; b = b+1)
        begin
            clk = b[0]; #5;
        end
    end   
endmodule
