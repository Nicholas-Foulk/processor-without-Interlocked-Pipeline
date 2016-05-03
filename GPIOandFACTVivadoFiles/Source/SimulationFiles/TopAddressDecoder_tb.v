`timescale 1ns / 1ps

module TopAddressDecoder_tb();
reg [31:0] A;
reg WE;

wire WE1,WE2,WEM;
wire [1:0] RdSel;
reg clk;
TopAddressDecoder TEST1(A,WE,WE1,WE2,WEM,RdSel);

initial
    begin
    clk = 0;
    WE = 0; #5;
    WE = 1; #5;
    A=32'h0000_0000F; #25;
    A=32'h0000_00803; #25;
    A=32'h0000_00903; #25;
    end
    always #5 clk =~ clk;
endmodule
