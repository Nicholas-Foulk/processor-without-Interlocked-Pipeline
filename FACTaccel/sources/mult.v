`timescale 1ns / 1ps
module mult();

wire [31:0] result;
reg [31:0] B;
reg [3:0] A;
multiply sump(result,A,B);
initial
begin
A = 4'b0100;
B = 32'b0000100000000000_0000000000000000;
end 
endmodule
