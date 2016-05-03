`timescale 1ns / 1ps
module TopFactorial_tb();
reg clk,rst;
reg [3:0] WD;
reg WE;
reg [1:0] A;
wire [31:0] RD;

integer b;

TopFactorial TEST1(clk, rst, WD,WE,A,RD);

initial
    begin
    clk = 0;
    rst = 0; #5;
    rst = 1; #5;
    rst = 0; #5;
    
    WE = 1'b1; #5;
    WD = 4'b0100;
  
    A = 2'b00;
    #50;
    
    WD = 4'b0001;
    A = 2'b01;
    #50;
    
    A =2'b11;
    
    end  
    always #5 clk=~clk; 
endmodule
