`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2016 03:11:03 PM
// Design Name: 
// Module Name: mux
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


module mux(input sel, input[3:0]A, input[3:0]B, output reg [3:0]out);
always@(sel,A,B)
begin
if(sel==1'b1)
    out=A;
    else 
    out=B;
end    
endmodule
