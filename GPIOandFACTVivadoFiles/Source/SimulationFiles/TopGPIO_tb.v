`timescale 1ns / 1ps
module TopGPIO_tb();

reg [1:0] A;
reg WE,rst,clk;
reg [31:0] gpI1,gpI2,WD;
wire [31:0] RD,gpO1,gpO2;

TopGPIO dut(A,WE,gpI1,gpI2,WD,rst,clk,RD,gpO1,gpO2);
initial
    begin
    clk = 0;
    WE  = 0;
    rst = 1;#5;
    rst = 0;
    gpI1 = 32'b0;
    WE = 1'b1;
    #5;
    
    WD = 32'h6666_6666;
    A = 2'b00; #5;
    
    gpI1 = 32'h0000_000F; #25;
    gpI2 = 32'h0000_00CC; #25;
    
    A = 2'b01; #25;
    A = 2'b10; #25;
    A = 2'b11; #25;
    
    end
    always #5 clk =~clk;
endmodule
