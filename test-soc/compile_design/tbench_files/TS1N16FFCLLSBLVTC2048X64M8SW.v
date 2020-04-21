//*#*********************************************************************************************************************/
//*
//*# Technology     : TSMC 16nm CMOS Logic FinFet Compact (FFC) Low Leakage HKMG  						*/
//*# Memory Type    : TSMC 16nm FFC High Density Single Port Single-Bank SRAM Compiler with d0734 bit cell	 				*/
//*# Library Name   : ts1n16ffcllsblvtc2048x64m8sw (user specify : ts1n16ffcllsblvtc2048x64m8sw)			*/
//*# Library Version: 130a												*/
//*# Generated Time : 2019/04/22, 15:17:48										*/
//*#*********************************************************************************************************************/
//*#															*/
//*# STATEMENT OF USE													*/
//*#															*/
//*# This information contains confidential and proprietary information of TSMC.					*/
//*# No part of this information may be reproduced, transmitted, transcribed,						*/
//*# stored in a retrieval system, or translated into any human or computer						*/
//*# language, in any form or by any means, electronic, mechanical, magnetic,						*/
//*# optical, chemical, manual, or otherwise, without the prior written permission					*/
//*# of TSMC. This information was prepared for informational purpose and is for					*/
//*# use by TSMC's customers only. TSMC reserves the right to make changes in the					*/
//*# information at any time and without notice.									*/
//*#															*/
//*#*********************************************************************************************************************/
//*******************************************************************************
//* Memory Name: TS1N16FFCLLSBLVTC2048X64M8SW
//* Model Type: Synthesizable Verilog Model
//*                                                                              
//*******************************************************************************
//*                                                                              
//*      Usage Limitation: PLEASE READ CAREFULLY FOR CORRECT USAGE               
//*
//* This is a synthesizable model. This model only support simple functionality
//*       a. read and write operations
//*       b. power mode switch behavior
//*       c. BIST function
//*       d. AWT function
//*       e. column redundancy function
//*                                                                              
//* Please be careful when using non 2^n  memory.                                
//* In a non-fully decoded array, a write cycle to a nonexistent address location
//* does not change the memory array contents and output remains the same.       
//* In a non-fully decoded array, a read cycle to a nonexistent address location 
//* does not change the memory array contents but the output becomes unknown.    
//*
//* The model doesn't identify physical column and row address
//*
//* Template Version : S_02_42002                                       
//*******************************************************************************
`timescale 1ns/1ps

module TS1N16FFCLLSBLVTC2048X64M8SW (
            CLK, CEB, WEB,
            A, D,
            BWEB,
            RTSEL,
            WTSEL,
            Q);

parameter numWord = 2048;
parameter numIOBit = 64;
parameter numWordAddr = 11;

//=== IO Ports ===//

// Normal Mode Input
input CLK;
input CEB;
input WEB;
input [numWordAddr-1:0] A;
input [numIOBit-1:0] D;
input [numIOBit-1:0] BWEB;


// Data Output
output [numIOBit-1:0] Q;


input [1:0] RTSEL;
input [1:0] WTSEL;

//=== Data Structure ===//
reg [numIOBit-1:0] mem[numWord-1:0];
reg [numIOBit-1:0] dout_tmp;
wire [numIOBit-1:0] Q_int;


wire iCEB = CEB;
wire iWEB = WEB;
wire [numWordAddr-1:0] iA = A;
wire [numIOBit-1:0] iD = D;
wire [numIOBit-1:0] iBWEB = BWEB;

wire pwr_mode = 1'b0;







assign Q_int = dout_tmp;

assign Q = pwr_mode? {numIOBit{1'b0}} : Q_int;



always @(posedge CLK) begin
    if (pwr_mode == 1'b0) begin
        if (iCEB == 1'b0) begin
            if (iWEB == 1'b1) begin // read
                dout_tmp <= mem[iA];
            end
        end
    end
end

genvar i;
 
generate
for (i=0; i<numIOBit; i=i+1) begin: BIT_WISE
always @(posedge CLK) begin
    if (pwr_mode == 1'b0) begin
        if (iCEB == 1'b0) begin // write
            if (iWEB == 1'b0) begin // write
                if (~iBWEB[i]) begin              // write
                    mem[iA][i] <= iD[i]; 
                end
            end
        end
    end
end
end // BIT_WISE
endgenerate


endmodule

