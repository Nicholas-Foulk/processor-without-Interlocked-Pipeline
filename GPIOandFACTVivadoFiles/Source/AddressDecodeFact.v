`timescale 1ns / 1ps
module AddressDecodeFact(A1,WE,WE1,WE2,RdSel);
input [1:0] A1;
input WE;
output WE1,WE2;
output [1:0] RdSel;
reg [3:0] cw;
assign {WE1,WE2,RdSel} = cw;
always@(*)
begin
 if(WE)
    case(A1)
        2'b00:cw = 4'b1000;
        2'b01:cw = 4'b0101;
        2'b10:cw = 4'b0010;
        2'b11:cw = 4'b0011;
     endcase 
  end
endmodule
