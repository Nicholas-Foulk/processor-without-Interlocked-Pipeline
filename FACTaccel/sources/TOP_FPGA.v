`timescale 1ns / 1ps

module TOP_FPGA(input [3:0] A, input go, rst, clk100MHz, output done, output [7:0] LEDOUT, output [7:0] LEDSEL);

wire [2:0] cs;
wire DONT_USE, clk_5KHz;
wire pb_debounced;

supply1[7:0] vcc;
wire [31:0] Result;
wire [3:0] SEG0,SEG1,SEG2,SEG3,SEG4,SEG5,SEG6,SEG6,SEG7;
wire a0, a1, a2, a3, a4, a5, a6, a7;
wire b0, b1, b2, b3, b4, b5, b6, b7;
wire c0, c1, c2, c3, c4, c5, c6, c7;
wire d0, d1, d2, d3, d4, d5, d6, d7;
wire e0, e1, e2, e3, e4, e5, e6, e7;
wire f0, f1, f2, f3, f4, f5, f6, f7;
wire g0, g1, g2, g3, g4, g5, g6, g7;
wire h0, h1, h2, h3, h4, h5, h6, h7;

assign a7 =1'b1;
assign b7 =1'b1;
assign c7 =1'b1;
assign d7 =1'b1;
assign e7 =1'b1;
assign f7 =1'b1;
assign g7 =1'b1;
assign h7 =1'b1;

clk_gen DUT10(.clk100MHz(clk100MHz), .rst(rst), .clk_4sec(DONT_USE), .clk_5KHz(clk_5KHz));
debounce DUT5(pb_debounced,pb,clk_5KHz);

TOPFACT DUT7(go,clk100MHz,rst,A,Result,done,cs);
bin2bcd32 DUT9(Result,SEG0,SEG1,SEG2,SEG3,SEG4,SEG5,SEG6,SEG6,SEG7);
bcd_to_7seg DUT4(SEG0,a0, a1, a2, a3, a4, a5, a6);
bcd_to_7seg DUT3(SEG1,b0, b1, b2, b3, b4, b5, b6);
bcd_to_7seg DUT4(SEG2,c0, c1, c2, c3, c4, c5, c6);
bcd_to_7seg DUT3(SEG3,d0, d1, d2, d3, d4, d5, d6);
bcd_to_7seg DUT4(SEG4,e0, e1, e2, e3, e4, e5, e6);
bcd_to_7seg DUT3(SEG5,f0, f1, f2, f3, f4, f5, f6);
bcd_to_7seg DUT3(SEG6,g0, g1, g2, g3, g4, g5, g6);
bcd_to_7seg DUT3(SEG7,h0, h1, h2, h3, h4, h5, h6);

led_mux DUT8(clk_5kHz, rst,{h7, h6, h5, h4, h3, h2, h1, h0},{g7, g6, g5, g4, g3, g2, g1, g0},{f7, f6, f5, f4, f3, f2, f1, f0}, {e7, e6, e5, e4, e3, e2, e1, e0},{d7, d6, d5, d4, d3, d2, d1, d0}, {c7, c6, c5, c4, c3, c2, c1, c0},{b7, b6, b5, b4, b3, b2, b1, b0},{a7, a6, a5, a4, a3, a2, a1, a0}, LEDOUT, LEDSEL); 
endmodule
