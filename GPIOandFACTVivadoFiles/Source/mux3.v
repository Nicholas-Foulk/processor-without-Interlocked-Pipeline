`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2016 03:12:59 PM
// Design Name: 
// Module Name: mux3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux3 #(parameter WIDTH = 8) (
  input   [1:0]         s, 
  input   [WIDTH-1:0]  d0, 
  input   [WIDTH-1:0]  d1, 
  input   [WIDTH-1:0]  d2, 
  input   [WIDTH-1:0]  d3, 
  output  [WIDTH-1:0]  y 
  );
 always@(*)
 begin
     case(s)
         2'b00: begin
                assign y = d0;
                end
         2'b01: 
                begin
                assign y = d1;
                end
         2'b10: 
                begin
                assign y = d2;
                end
         2'b11: 
                begin
                assign y = d3;
                end
     endcase
 end
 endmodule
