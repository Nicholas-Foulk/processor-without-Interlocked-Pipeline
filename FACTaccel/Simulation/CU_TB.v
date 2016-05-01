`timescale 1ns / 1ps

module CU_TB( );

// input go,
//input clk, rst,
//output CNTLD,UD,CE,CNTRST,
////input equal, greater, smaller,
//input greater,
//output BUFEN, //buff enable
//output MUXSEL1,MUXSEL2,
//output REGLD,
//output done,
//output reg [2:0] cs
reg go, clk, rst;
wire CNTLD,UD,CE,CNTRST;
reg greater;
wire BUFEN, MUXSEL1, MUXSEL2, REGLD, done;
wire [2:0] cs;
integer i;
CU INST3(go,clk,rst,CNTLD,UD,CE,CNTRST1,greater,BUFEN,MUXSEL1,MUXSEL2,REGLD,done,cs);

initial
begin
    rst = 0; #5;
    rst = 1; #5;
    rst = 0; #5;
    
    go = 1;
    
    for(i=0; i < 7'b1111100; i = i+1)
    begin
        clk = i[0]; greater = i[5]; #5; 
    end

end
endmodule
