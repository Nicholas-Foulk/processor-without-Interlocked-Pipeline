`timescale 1ns / 1ps


module filter_tb();

input                 clk;
input                 en;
input [31:0]          rawdata;
output reg [31:0]     filtered_data;
integer i;
filter INST6(clk,en,rawdata,filtered_data);

initial
begin
rawdata = 32'b1;
 for(i=0; i < 5'b10000; i=i+1)
    begin
        en =i[3];
    end
 
end
endmodule
