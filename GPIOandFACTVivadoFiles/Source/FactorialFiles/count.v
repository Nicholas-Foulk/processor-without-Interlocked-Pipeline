`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2016 03:15:37 PM
// Design Name: 
// Module Name: count
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


module count(input clk, ld_count, EN ,input[3:0]D, output reg[3:0]Q  );

always@(posedge clk)
begin
    if(ld_count)
        Q=D;
        else if(EN)
        Q=Q-4'b0001;
end        
        
endmodule
