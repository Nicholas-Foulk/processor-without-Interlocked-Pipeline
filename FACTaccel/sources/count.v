`timescale 1ns / 1ps
module UD_CNT_4 (D, LD, UD, CE, CLK, RST_, Q);
input [3:0] D;
input LD, UD, CE, CLK, RST_;
output reg [3:0] Q;
always @ (posedge CLK, negedge RST_)
    begin
    if (!RST_) Q = 4'b0;
    else if (CE)
        begin
            if (LD) Q = D;
            else if (UD) Q = Q + 4'b0001;
            else Q = Q - 4'b0001;
        end
    else Q = Q;
    end
endmodule
