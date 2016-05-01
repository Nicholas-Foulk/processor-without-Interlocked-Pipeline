`timescale 1ns / 1ps
module multiplexer2(d0, d1, sel, y);
input [31:0] d0, d1; 
input sel;
output reg [31:0] y;
always @(sel)
	begin
		if(sel == 1)
		begin
			y = d1; 
		end
		else 
		begin
			y = d0; 
		end
	end	
endmodule
