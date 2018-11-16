module EX_MEM
#(
	parameter N=32
)
(
	input clk,
	input reset,
	//ControlValues
//M	
	input IN_BEQ,
	input IN_BNE,
	input IN_MemRead,
	input IN_MemWrite,
//WB
	input IN_MemToReg,
	input IN_RegWrite,
	
	//ALU
	input [31:0] IN_ALUResult,
	input IN_ALUZero,
	input IN_Added_Address,
	//datas
	input [31:0] IN_ReadData2,
	input [4:0] IN_WriteRegisterData,

	//outputs
	output OUT_BEQ,
	output OUT_BNE,
	output OUT_MemRead,
	output OUT_MemWrite,
	output OUT_MemToReg,
	output OUT_RegWrite,
	output [31:0] OUT_ALUResult,
	output OUT_ALUZero,
	output OUT_Added_Address,
	output [31:0] OUT_ReadData2,
	output [4:0] OUT_WriteRegisterData
	
);



Register_Pipe
BEQ
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_BEQ),
	.DataOutput(OUT_BEQ)
);

Register_Pipe
BNE
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_BNE),
	.DataOutput(OUT_BNE)
);

Register_Pipe
MemRead
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_MemRead),
	.DataOutput(OUT_MemRead)
);

Register_Pipe
MemWrite
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_MemWrite),
	.DataOutput(OUT_MemWrite)
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
ALUResult
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ALUResult),
	.DataOutput(OUT_ALUResult)
);

Register_Pipe
ALUZero
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ALUZero),
	.DataOutput(OUT_ALUZero)
);

Register_Pipe
Added_Address
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Added_Address),
	.DataOutput(OUT_Added_Address)
);

Register_Pipe
ReadData2
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ReadData2),
	.DataOutput(OUT_ReadData2)
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