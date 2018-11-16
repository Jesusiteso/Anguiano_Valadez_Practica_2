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
	//input [13:0] IN_ControlValues,
	input [2:0] IN_ALUOP,
	input IN_Branch_EQ,
	input IN_Branch_NE,
	input IN_MemWrite,
	input IN_MemRead,
	input IN_RegWrite,
	input IN_MemToReg,
	input IN_ALUSrc,
	input IN_RegDst,
	input IN_Jump_r,
	input IN_Jump,
	input IN_Jump_l,
	//PC_wire
	input [31:0] IN_PC_Conter_Plus_4,
	//Read Datas
	input [31:0] IN_Read_Data_1,
	input [31:0] IN_Read_Data_2,
	//Instruction wires
	input [31:0] IN_SignExtended_Instruction,
	input [20:16] IN_RT_To_RegDst,
	input [15:11] IN_RD_To_RegDst,
	input [5:0] IN_ALUControl_Values,

	//	OUTPUTS
	//output [13:0] OUT_ControlValues,
	output [2:0] OUT_ALUOP,
	output OUT_Branch_EQ,
	output OUT_Branch_NE,
	output OUT_MemWrite,
	output OUT_MemRead,
	output OUT_RegWrite,
	output OUT_MemToReg,
	output OUT_ALUSrc,
	output OUT_RegDst,
	output OUT_Jump_r,
	output OUT_Jump,
	output OUT_Jump_l,
	
	output [31:0] OUT_PC_Conter_Plus_4,
	output [31:0] OUT_Read_Data_1,
	output [31:0] OUT_Read_Data_2,
	output [31:0] OUT_SignExtended_Instruction,
	output [20:16] OUT_RT_To_RegDst,
	output [15:11] OUT_RD_To_RegDst,
	output [5:0] OUT_ALUControl_Values

	
);

wire [13:0] IN_controlvalues_wire;
wire [13:0] OUT_controlvalues_wire;


assign IN_controlvalues_wire[2:0] = IN_ALUOP;
assign IN_controlvalues_wire[3] = IN_Branch_EQ;
assign IN_controlvalues_wire[4] = IN_Branch_NE;
assign IN_controlvalues_wire[5] = IN_MemWrite;
assign IN_controlvalues_wire[6] = IN_MemRead;
assign IN_controlvalues_wire[7] = IN_RegWrite;
assign IN_controlvalues_wire[8] = IN_MemToReg;
assign IN_controlvalues_wire[9] = IN_ALUSrc;
assign IN_controlvalues_wire[10] = IN_RegDst;
assign IN_controlvalues_wire[11] = IN_Jump_r;
assign IN_controlvalues_wire[12] = IN_Jump;
assign IN_controlvalues_wire[13] = IN_Jump_l;



//All control Values
Register_Pipe
ControlValues
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_controlvalues_wire),
	.DataOutput(OUT_controlvalues_wire)
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

assign OUT_ALUOP     = OUT_controlvalues_wire[2:0];
assign OUT_Branch_EQ = OUT_controlvalues_wire[3];
assign OUT_Branch_NE = OUT_controlvalues_wire[4];
assign OUT_MemWrite  = OUT_controlvalues_wire[5];
assign OUT_MemRead   = OUT_controlvalues_wire[6];
assign OUT_RegWrite  = OUT_controlvalues_wire[7];
assign OUT_MemToReg  = OUT_controlvalues_wire[8];
assign OUT_ALUSrc    = OUT_controlvalues_wire[9];
assign OUT_RegDst    = OUT_controlvalues_wire[10];
assign OUT_Jump_r    = OUT_controlvalues_wire[11];
assign OUT_Jump      = OUT_controlvalues_wire[12];
assign OUT_Jump_l    = OUT_controlvalues_wire[13];



endmodule 