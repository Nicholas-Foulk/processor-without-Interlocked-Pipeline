`timescale 1ns / 1ps
module updown_tb( );
reg CLK_tb, RST_tb_, LD_tb, UD_tb, CE_tb;
reg [3:0] D_tb;
wire [3:0] Q_tb;
    
UD_CNT_4 U0 ( .D(D_tb),
    .LD(LD_tb),
    .UD(UD_tb),
    .CE(CE_tb),
    .CLK(CLK_tb),
    .RST_(RST_tb_),
    .Q(Q_tb));
initial
    begin
        CLK_tb <= 0;
        RST_tb_ <= 0;
        LD_tb <= 0;
        UD_tb <= 0;
        CE_tb <= 0;
        D_tb <= 4'b0000;
        #50 RST_tb_ <= 1;
        CE_tb <= 1;
        #50 D_tb <= 4'b1010;
        #30 LD_tb <= 1;
        #40 LD_tb <= 0;
        #200 UD_tb <= 1;
        #200 $stop;
        #20 $finish;
    end
always #20 CLK_tb <= ~CLK_tb;
endmodule
