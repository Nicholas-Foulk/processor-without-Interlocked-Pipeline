`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2016 02:41:20 PM
// Design Name: 
// Module Name: global_mux
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


module global_mux #(parameter WIDTH = 8) (
  input                 s, 
  input   [WIDTH-1:0]  d0, 
  input   [WIDTH-1:0]  d1, 
  output  [WIDTH-1:0]  y 
  );
 always@(*)
     begin
         case(s)
             1'b0: begin
                    assign y = d0;
                    end
             1'b1: 
                    begin
                    assign y = d1;
                    end
         endcase
     end
 endmodule
