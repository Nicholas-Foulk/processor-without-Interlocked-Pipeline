`timescale 1ns / 1ps
module filter
  (
    input                 en,
    input [31:0]          rawdata,
    output reg [31:0]     filtered_data
  );     
always@(en)
if(en == 1)
    begin
       filtered_data = rawdata;
    end
 else 
    begin
       filtered_data = 32'bz;
    end
endmodule
