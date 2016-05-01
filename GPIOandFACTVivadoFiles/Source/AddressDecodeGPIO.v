`timescale 1ns / 1ps
module AddressDecodeGPIO(A1,WE,WE1,WE2,RdSel);
input [1:0] A1;
input WE;
output WE1,WE2;
output [1:0] RdSel;
reg [3:0] cw;
assign {WE1,WE2,RdSel} = cw;
always@(*)
begin
    case(A1)
    2'b00:
        begin
           cw = 4'b0000;
         end
    2'b01:
        begin
           cw = 4'b0001;
         end
    2'b10:
         begin
           cw = 4'b1010;
         end
    2'b11:
          begin
           cw = 4'b0111;
          end 
     endcase 
  end
endmodule

