`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2016 02:23:49 PM
// Design Name: 
// Module Name: RegFile4bit
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


module RegFile4bit(D, Q, CLK, EN); //im using RST as LOAD for now
parameter Data_width = 4; //DATA SIZE
input CLK, EN;
input [Data_width-1:0] D;
output reg [Data_width-1:0] Q;
always @(posedge CLK)
begin
    if (EN)
    Q = D;
    else 
    Q = Q;
end
endmodule

