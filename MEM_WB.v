/******************************************************************
* Description
*   This module represent a pipeline stage between Instruction
*   Decode and Execution
* Version:
*	1.0
* Author:
*	Jesus Antonio Valadez Flores
* email:
*	is703557@iteso.mx
* Date:
*	15/11/2018
******************************************************************/

module MEM_WB
#(
	parameter N=32
)
(
	input clk,
	input reset,
	//WB_ControlValues
	input IN_MemToReg,
	input IN_RegWrite,
	//Data memory
	input [31:0] IN_DataMemory_Data,
	//Output of ALU
	input [31:0] IN_ALUResult,
	input [4:0] IN_WriteRegisterData,

	//Outputs
	output OUT_MemToReg,
	output OUT_RegWrite,
	output [31:0] OUT_DataMemory_Data,
	output [31:0] OUT_ALUResult,
	output [4:0] OUT_WriteRegisterData
);


Register_Pipe
MemToReg
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_MemToReg),
	.DataOutput(OUT_MemToReg)
);

Register_Pipe
RegWrite
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_RegWrite),
	.DataOutput(OUT_RegWrite)
);

Register_Pipe
DataMemory_Data
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_DataMemory_Data),
	.DataOutput(OUT_DataMemory_Data)
);

Register_Pipe
ALUResult
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ALUResult),
	.DataOutput(OUT_ALUResult)
);

Register_Pipe
WriteRegisterData
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_WriteRegisterData),
	.DataOutput(OUT_WriteRegisterData)
);


endmodule 