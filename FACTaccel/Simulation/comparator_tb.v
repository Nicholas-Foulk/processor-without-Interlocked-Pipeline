`timescale 1ns / 1ps
module comparator_tb();

wire  result;
reg [3:0] A,B;

comparator DUT1(A,B,result);

initial
    begin
    A = 4'b1111;
    B = 4'b0001;
    end
endmodule
