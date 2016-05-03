`timescale 1ns / 1ps
module TopAddressDecoder(WE,A1,WE1,WE2,WEM,RdSel);
input [31:0] A1;
input WE;
output WE1,WE2,WEM;
output [1:0] RdSel;
reg [4:0] cw;
assign {WE1,WE2,WEM,RdSel} = cw;
always@(*)
    begin
     if(WE)
        if(A1>=32'h0000_00000 && A1<=32'h0000_00FC)
            begin
               cw = 5'b00100;
             end
        else if(A1>=32'h0000_00800 && A1<=32'h0000_080C)
            begin
               cw = 5'b10010;
             end
        else if (A1>=32'h0000_00900 && A1<=32'h0000_090C)
             begin
               cw = 5'b01011;
             end
      end
endmodule

