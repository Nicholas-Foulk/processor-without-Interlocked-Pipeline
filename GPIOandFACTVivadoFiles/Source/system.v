`timescale 1ns / 1ps
module system(input reset, clk, 
              input [31:0] gpI1, gpI2, 
              output [31:0] gpO1, gpO2);
              
  wire     [31:0] pc; 
  wire     [31:0] instr; 
  wire     [31:0] dataaddr; 
  wire     [31:0] writedata; 
  wire     [31:0] readdata; 
  wire     [31:0] dispDat;

//=======================================================================================================================
//=======================================================================================================================
//wires for new parts of lab 8 Address Decoder, GPIO, Factorial
 
 wire          WE1,WE2,WEM;            //three signals out of top decoder 
 wire   [1:0]  RdSel;                  //this is for top decoder mux selection
 wire   [31:0] FactData;
 wire   [31:0] GPIOData;     //outputs of the GPIO and Fact modules 
 wire   [31:0] DMemData;               //output for the DMemData 
 wire   [7:0]  switches;
 wire          memwrite;              //forgot this signal
 
//=======================================================================================================================
//=======================================================================================================================
//Here is the system with all of its modules 
     imem   imem  (
          .a(pc[7:2]), 
          .dOut(instr)
          );
     mips   mips  (
       .clk(clk), 
       .reset(reset), 
       .pc(pc), 
       .instr(instr), 
       .memwrite(memwrite), 
       .aluout(dataaddr), 
       .writedata(writedata), 
       .readdata(readdata), 
       .dispSel(switches[4:0]), 
       .dispDat(dispDat)
       );                
                  
     dmem  dmem  (
       .clk(clk), 
       .we(WEM),            //this is now WEM from memwrite since top decoder added
       .addr(dataaddr[7:2]),      //32 bit????? Guess so, the schematic shows [7:2] 
       .dIn(writedata), 
       .dOut(DMemData)      //THIS HAS BEEN CHANGED IN LAB 8 to DMemData
       );
      //module TopAddressDecoder(A1,WE,WE1,WE2,WEM,RdSel); 
      TopAddressDecoder TopAddressDecoderTEST(memwrite,dataaddr,WE1,WE2,WEM,RdSel);  //dataddr all 32 bits? not sure if always statament is working
      //module TopFactorial(clk,rst,WD,WE,A,RD);
      TopFactorial TopFactorialTEST(clk,reset,writedata[3:0],WE1,dataaddr[3:2],FactData);
      //module TopGPIO(A,WE,gpI1,gpI2,WD,rst,clk,RD,gpO1,gpO2);
      TopGPIO TopGPIOTEST(clk,reset,dataaddr[3:2],WE2,gpI1,gpI2,writedata,GPIOData,gpO1,gpO2); 
      //module TopDesignMux #(parameter WIDTH = 32) (s, d0,d1,d2, d3,y);
      TopDesignMux #(32) TopDesignMuxTEST(RdSel,DMemData,DMemData,FactData,GPIOData,readdata);
          
//=======================================================================================================================
//===================================================================================================================

endmodule
