/******************************************************************
* Description
*   This module represent a pipeline stage between Instruction 
*   Fetch and Instruction Decode 
* Version:
*	1.0
* Author:
*	Jesus Antonio Valadez Flores
* email:
*	is703557@iteso.mx
* Date:
*	15/11/2018
******************************************************************/

module IF_ID
#(
	parameter N=32
)
(
	input clk,
	input reset,

	input [31:0] IN_PC_Conter_Plus_4,
	input [31:0] IN_Instruction_Wire,

	output [31:0] OUT_PC_Conter_Plus_4,
	output [31:0] OUT_Instruction_Wire

);

Register_Pipe
PC_Conter_Plus_4
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_PC_Conter_Plus_4),
	.DataOutput(OUT_PC_Conter_Plus_4)
);

Register_Pipe
Instruction_Wire
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Instruction_Wire),
	.DataOutput(OUT_Instruction_Wire)
);

endmodule 