`timescale 1ns / 1ps
module system_tb();
reg clk,rst;
reg [31:0] gpI1;
wire [31:0] gpO1;
wire [31:0] gpO2;
system TEST1(rst,clk,gpI1,gpO1,gpO1,gpO2);
initial
    begin
        clk = 0;
        rst=1;
        #10;
        rst =0;
        gpI1 = 32'b0;
        #20;
        gpI1 = {27'b0,5'b00100};
        #20;
    end 
    always #5 clk =~clk;  
endmodule
