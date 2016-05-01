`timescale 1ns / 1ps
module multiply(
        output reg [31:0] result,
        input [3:0] a,
        input [31:0] b
      );
always@(a,b)
    assign result = a * b;
endmodule
