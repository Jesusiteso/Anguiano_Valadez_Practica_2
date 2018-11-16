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

module ID_EX
#(
	parameter N=32
)
(
	input clk,
	input reset,
	//All control Values
	input [13:0] IN_ControlValues,
	//PC_wire
	input [31:0] IN_PC_Conter_Plus_4,
	//Read Datas
	input [31:0] IN_Read_Data_1,
	input [31:0] IN_Read_Data_2,
	//Instruction wires
	input [15:0] IN_SignExtended_Instruction,
	input [20:16] IN_RT_To_RegDst,
	input [15:11] IN_RD_To_RegDst,
	input [5:0] IN_ALUControl_Values,

	//	OUTPUTS
	output [13:0] OUT_ControlValues,
	output [31:0] OUT_PC_Conter_Plus_4,
	output [31:0] OUT_Read_Data_1,
	output [31:0] OUT_Read_Data_2,
	output [15:0] OUT_SignExtended_Instruction,
	output [20:16] OUT_RT_To_RegDst,
	output [15:11] OUT_RD_To_RegDst,
	output [5:0] OUT_ALUControl_Values

	
);


//All control Values
Register_Pipe
ControlValues
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ControlValues),
	.DataOutput(OUT_ControlValues)
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
Read_Data_1
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Read_Data_1),
	.DataOutput(OUT_Read_Data_1)
);

Register_Pipe
Read_Data_2
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Read_Data_2),
	.DataOutput(OUT_Read_Data_2)
);

Register_Pipe
SignExtended_Instruction
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_SignExtended_Instruction),
	.DataOutput(OUT_SignExtended_Instruction)
);

Register_Pipe
RT_To_RegDst
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_RT_To_RegDst),
	.DataOutput(OUT_RT_To_RegDst)
);

Register_Pipe
RD_To_RegDst
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_RD_To_RegDst),
	.DataOutput(OUT_RD_To_RegDst)
);

Register_Pipe
ALUControl_Values
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ALUControl_Values),
	.DataOutput(OUT_ALUControl_Values)
);


endmodule 