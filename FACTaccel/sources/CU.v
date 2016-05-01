`timescale 1ns / 1ps
module CU(
    input go,
    input clk, rst,
    output CNTLD,UD,CE,CNTRST,
    input greater,
    output BUFEN, //buff enable
    output MUXSEL1,MUXSEL2,
    output REGLD,
    output done,
    output reg [2:0] cs
);
reg [2:0] ns;
reg [8:0] CW;
assign {CNTLD,UD,CE,CNTRST,BUFEN,MUXSEL1,MUXSEL2,REGLD,done} = CW; //REGLD is load for register file
always@(posedge rst, posedge clk)
begin
	if(rst)
		cs <= 0;
	else cs <= ns;
end
always@(go,cs)  //i may need to add greater
begin
	case(cs)
		0: 
		begin 
		    CW = 9'b00000_0000;      
		end
		1:
		begin 
			CW = 9'b10100_0010;  //10100_0010;
		end
		2:
		begin 
		    CW = 9'b00000_1000;	  
		end
		3:
		begin 
			CW = 9'b00000_1000;	       			
		end
		4:	
		begin
			CW = 9'b00000_1110;
		end
		5:	
		begin
			CW = 9'b01100_1000;
		end
		6:	
		begin
			CW = 9'b00001_0001;
		end
	endcase
end 
always@(cs, go, greater)//ns logic
begin
	case(cs)
		0: 
		begin
            if(go) 
              ns = 1;
            else
              ns = 0;
		end
		1: ns = 2;
		2: 
		begin
		  if (greater == 1'b1)
		    ns = 6; 
		  else 
		    ns = 3;
		end
		3:
		begin
		    ns = 4;
		end
		4: 
		begin 
		    ns = 5;
		end
		5:
		begin 
			ns = 2; 
		end
		6:  ns = 0;
	endcase
end
endmodule
