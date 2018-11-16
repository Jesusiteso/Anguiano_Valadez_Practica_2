module EX_MEM
#(
	parameter N=32
)
(
	input clk,
	input reset,
	
	input[31:0] IN_ALUResult,//
	input IN_ALU_Zero,//
	input[4:0] IN_RegDest,//
	input[31:0] IN_ReadData,//
	input IN_BEQ_Wire,
	input IN_BNE_Wire,
	input[31:0] IN_ADD_Result,
	
	output[31:0] OUT_ALUResult, //ALU
	output OUT_ALU_Zero,//
	output[4:0] OUT_RegDest,//
	output[31:0] OUT_ReadData,//
	output OUT_BEQ_Wire,
	output OUT_BNE_Wire,
	output[31:0] OUT_ADD_Result
	
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
ALU_Zero
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ALU_Zero),
	.DataOutput(OUT_ALU_Zero)
);
Register_Pipe
RegDest
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_RegDest),
	.DataOutput(OUT_RegDest)
);
Register_Pipe
ReadData
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ReadData),
	.DataOutput(OUT_ReadData)
);
Register_Pipe
BEQ_Wire
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_BEQ_Wire),
	.DataOutput(OUT_BEQ_Wire)
);
Register_Pipe
BNE_Wire
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_BNE_Wire),
	.DataOutput(OUT_BNE_Wire)
);
Register_Pipe
ADD_Result
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ADD_Result),
	.DataOutput(OUT_ADD_Result)
);

endmodule 