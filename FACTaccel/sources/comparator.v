`timescale 1ns / 1ps
module comparator(input [3:0] A, input [3:0] B, output reg smaller);
//parameter datain_width = 4;
//input [datain_width-1:0] A;
//input [datain_width-1:0] B;
//output reg smaller;
always @ (A,B)
begin 
    if (A[3:0] < B[3:0])
        smaller = 1'b1;
    else
        smaller = 1'b0;
end 
endmodule
