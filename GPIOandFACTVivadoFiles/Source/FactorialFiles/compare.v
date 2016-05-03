`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2016 02:33:11 PM
// Design Name: 
// Module Name: compare
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


module comparator(input [3:0]A, input [3:0] B ,output reg smaller);

always@(A,B)
begin
    if(A[3:0] <= B[3:0])
        smaller = 1'b1;
    else
        smaller = 1'b0;
end
endmodule
