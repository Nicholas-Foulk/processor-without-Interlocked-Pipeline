`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2016 05:02:56 PM
// Design Name: 
// Module Name: CU
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


module CU(input go, clk, rst,smaller_than, output  sel1,buffer,ld_reg,ld_count,en_count,sel2, done, output reg [2:0]cs);

reg[2:0] ns;
reg[6:0] cw;
assign {sel1,sel2,buffer,ld_reg,ld_count, en_count,done} =cw;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100, s5=3'b101, s6=3'b110;
always@(posedge clk, posedge rst)
    begin
        if(rst)
        cs<=s0;
        else
        cs<=ns;
        end
always@(cs,go)
    begin
    case(cs)
    s0:begin cw=7'b1100000; end
    s1:begin cw=7'b1101100; end
    s2:begin cw=7'b0100000; end
    s3:begin cw=7'b0100000; end
    s4:begin cw=7'b0001000; end
    s5:begin cw=7'b0100010; end
    s6:begin cw=7'b1110001; end
    endcase
    end
always@(cs,go,smaller_than)
    begin
    case(cs)
    s0:begin 
        if(go)
        ns<=s1;
        else
        ns<=s0;
        end
    s1:begin
        ns<=s2;
      end
    s2:begin
        if(smaller_than)
            ns<=s6;
        else
            ns<=s3;
      end
    s3:begin
        ns<=s4;
      end
    s4:begin
        ns<=s5;
      end
    s5:begin
        ns<=s2;
      end
    s6:begin
        ns<=s0;
      end
    endcase
end
endmodule
