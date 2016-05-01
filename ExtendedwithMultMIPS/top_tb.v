`timescale 1ns / 1ps
module top_tb( );

reg clk, reset;
wire[31:0] writedata, dataadr;
wire memwrite;
wire [31:0] pc, instr, readdata;
reg [7:0] switches;
wire [31:0] dispDat;

top DUT(clk, reset, writedata, dataadr, memwrite, pc, instr, readdata, switches, dispDat);

initial
	begin
		clk = 0;
		reset = 1;
		switches = 8'b0;
		#20;
		reset = 0;
		switches = 8'b0001_0000;
	end
	
	always #5 clk = ~clk;
	
	always@(negedge clk)
	begin
		if (pc[7:0] ==8'h10)
			begin
			 if (dispDat == 32'd24 && switches[7:0]==5'd16) 
				begin
					$display("Display: 24 , PC: %h\n SIMULATION SUCCESS", pc);
					$stop;
				end
			else				
				begin
					$display("Simulation failed\n");
				$stop;
				end
				end
				end
endmodule
