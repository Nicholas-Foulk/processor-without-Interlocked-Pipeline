`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2016 04:13:50 PM
// Design Name: 
// Module Name: DP
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


module DP(input clk, sel1, sel2, buffer, ld_reg, ld_count, en_count, 
          input [3:0] factorial, 
          output smaller_than, 
          output [31:0] result);

wire[3:0] count, mux1_out;
wire[31:0] register_out, multiplier_out,mux2_out;

count samp1(clk,ld_count,en_count,factorial, count);
comparator samp2(count,4'b0001, smaller_than);
mux samp3(sel1, 4'b0001, count,mux1_out);
multi samp4(mux1_out,register_out,multiplier_out);
mux23 samp5(sel2,multiplier_out,mux2_out);
register samp6(clk, ld_reg,mux2_out,register_out);
buffer samp7(register_out,result,buffer);


endmodule
