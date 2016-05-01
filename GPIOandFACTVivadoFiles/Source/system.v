`timescale 1ns / 1ps
module system(input rst, clk, input [31:0] gpI1, input [31:0] gpI2, output [31:0] gpO1, output [31:0] gpO2);

 wire   [31:0] pc, 
               instr, 
               dataadr, 
               writedata, 
               readdata, 
               dispDat;

//=======================================================================================================================
//=======================================================================================================================
//wires for new parts of lab 8 Address Decoder, GPIO, Factorial
 
 wire          WE1,WE2,WEM;            //three signals out of top decoder 
 input  [31:0] gpI1,gpI2;              //this isn't final at all, these are used for input to the system
 wire   [1:0]  RdSel;                  //this is for top decoder mux selection
 output [31:0] gpO1, gpO2;             //one of these is for 7 seg, another is looping back into the system
 wire   [31:0] FactData, GPIOData;     //outputs of the GPIO and Fact modules 
 wire   [31:0] DMemData;               //output for the DMemData 
 
//=======================================================================================================================
//=======================================================================================================================
 //Here is the system with all of its modules 
 
     mips   mips  (
       .clk(clksec), 
       .reset(reset), 
       .pc(pc), 
       .instr(instr), 
       .memwrite(memwrite), 
       .aluout(dataadr), 
       .writedata(writedata), 
       .readdata(readdata), 
       .dispSel(switches[4:0]), //needs to  be editted for lab 8
       .dispDat(dispDat)
       );
                  
     imem   imem  (
       .a(pc[7:2]), 
       .dOut(instr)
       );
                  
     dmem  dmem  (
       .clk(clk), 
       .we(WEM),            //this is now WEM from memwrite since top decoder added
       .addr(dataadr),      //32 bit?????
       .dIn(writedata), 
       .dOut(DMemData)      //THIS HAS BEEN CHANGED IN LAB 8 TO DMemData
       );

//Here is where the GPIO and Factorial Accelerator are added
      TopAddressDecoder TopAddressDecoder(dataaddr,memwrite,WE1,WE2,WEM,RdSel);  //dataddr all 32 bits?
      TopGPIO TopGPIO(dataaddr[3:2],WE2,gpI1,gpI2,wriedata,rst,clk,RD,gpO1,gpO2);  //this needs to be edited
      TopFactorial TopFactorial(clk,rst,writedata[3:0],WE1,dataaddr[3:2],FactData);
      TopDesignMux TopDesignMux(RdSel,readdata,FactData,DMemData,readdata);    
//=======================================================================================================================
//===================================================================================================================

endmodule
