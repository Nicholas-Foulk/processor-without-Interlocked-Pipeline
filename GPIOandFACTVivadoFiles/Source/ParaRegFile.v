`timescale 1ns / 1ps
module ParaRegFile #(parameter WIDTH = 32) (
  input       clk, 
  input       en,
  input       reset,
  input       [WIDTH-1:0]  d, 
  output reg  [WIDTH-1:0]  q
  );
  always @(posedge clk, posedge reset)
    if      (reset) q <= 0;
    else if (en)    q <= d;
endmodule
