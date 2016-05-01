`timescale 1ns / 1ps
module Register_File(D, Q, CLK, RST); //im using RST as LOAD for now
parameter Data_width = 32; //DATA SIZE
input CLK, RST;
input [Data_width-1:0] D;
output reg [Data_width-1:0] Q;
always @(posedge CLK)
begin
    if (RST)
    Q = D;
    else 
    Q = Q;
end
endmodule
