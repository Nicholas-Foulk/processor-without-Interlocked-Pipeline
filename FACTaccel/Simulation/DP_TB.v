`timescale 1ns / 1ps
module DP_TB();
reg [3:0] A;
reg LD,UD,CE,CNTRST;
wire greater;
reg BUFEN,MUXSEL1,MUXSEL2;
reg clk, REGLD;
wire [31:0] bufout;
reg [2:0] cs;
reg [2:0] ns;
integer i;
DP INST5(A,LD,UD,CE,CNTRST,greater,BUFEN,MUXSEL1,MUXSEL2,clk,REGLD,bufout);
//input [3:0] A, input LD, input UD, input CE, input CNTRST, 
//output greater,
//input BUFEN,
//input MUXSEL1,MUXSEL2,
//input clk,REGLD,
//output reg [31:0] bufout  
initial 
    begin 
    cs = 0; 
    A = 4'b0011;
    for(i=0;i<6'b100000;i=1+1)
    begin
        clk = i[0]; #5;
        case(cs)
            0:begin 
                {REGLD,MUXSEL1,MUXSEL2} = 3'b101;{LD,UD,CE}=3'b101; BUFEN=1'b0; cs=cs+1;
              end
            1:begin
                {REGLD,MUXSEL1,MUXSEL2} = 3'b010; {LD,UD,CE}=3'b000; BUFEN=1'b0; cs=cs+1;
              end
            2:begin
                {REGLD,MUXSEL1,MUXSEL2} = 3'b001; {LD,UD,CE}=3'b000; BUFEN=1'b0; cs=cs+1;      
              end
            3:begin 
                 {REGLD,MUXSEL1,MUXSEL2} = 3'b101; {LD,UD,CE}=3'b011; BUFEN=1'b0; cs=cs+1;
              end
            4:begin
                 {REGLD,MUXSEL1,MUXSEL2} = 3'b000; {LD,UD,CE}=3'b011; BUFEN=1'b0; cs=cs+1;
              end
            5:begin
                 {REGLD,MUXSEL1,MUXSEL2} = 3'b000; {LD,UD,CE}=3'b000; BUFEN=1'b1; cs=cs+1;
              end
         endcase
     #1;
         if(clk) begin cs=ns; end
     end
    end
endmodule
