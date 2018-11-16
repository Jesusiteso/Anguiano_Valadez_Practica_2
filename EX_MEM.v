
module EX_MEM
#(
	parameter N=32
)
(
	input clk,
	input reset,
	
	input[31:0] IN_Alu_RESULT,//
	input IN_ALU_zERO//
	input[4:0] IN_REG_dEST,//
	input[31:0] IN_READ_dATA,//
	input IN_BEQ_wIRE,
	input IN_BNE_wIRE,
	input[31:0] IN_ADD_rESULT,
	
	output[31:0] OUT_DM_aDRESS, //ALU
	output[31:0] OUT_DM_wRITE_DATA,//READ_DATA
	output OUT_BRANCH_sELECTOR, // ZERO
	output[4:0] OUT_REG_dEST,
	output OUT_BEQ_wIRE,
	output OUT_BNE_wIRE,
	output[31:0] OUT_ADD_rESULT

	
);

Register_Pipe
Alu_Result
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Alu_RESULT),
	.DataOutput(OUT_DM_aDRESS)
);

Register_Pipe
Zero_Flag
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ALU_zERO),
	.DataOutput(OUT_BRANCH_sELECTOR)
);

Register_Pipe
Reg_Dest
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_REG_dEST),
	.DataOutput(OUT_REG_dEST)
);

Register_Pipe
Read_Data
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_READ_dATA),
	.DataOutput(OUT_DM_wRITE_DATA)
);

Register_Pipe
Beq
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_BEQ_wIRE),
	.DataOutput(OUT_BEQ_wIRE)
);

Register_Pipe
Bne
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_BNE_wIRE),
	.DataOutput(OUT_BNE_wIRE)
);

Register_Pipe
Add_Result
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_ADD_rESULT),
	.DataOutput(OUT_ADD_rESULT)
);

endmodule 