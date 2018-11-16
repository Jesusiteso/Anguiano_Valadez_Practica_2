module ID_EX
#(
	parameter N=32
)
(
	input[2:0] IN_Alu_Op,
	input IN_Alu_Src,
	input IN_Beq,
	input IN_Bne,
	input In_Jump_L,
	input IN_Jump_R,
	input IN_Jump,
	input IN_Mem_Read,
	input IN_Mem_Write,
	input IN_Mem_to_Reg,
	input IN_Reg_Dst,
	input IN_Read_Data_1,
	input IN_Read_Data_2,
	input[31:0] IN_Pc_Plus_4,
	input[31:0] IN_Sign_Extend,
	input[20:16] IN_Instruction_20_16,
	input[15:11] IN_Instruction_15_11,
	
	output[2:0] OUT_Alu_Op,
	output OUT_Alu_Src,
	output OUT_Beq,
	output OUT_Bne,
	output OUT_Jump_L,
	output OUT_Jump_R,
	output OUT_Jump,
	output OUT_Mem_Read,
	output OUT_Mem_Write,
	output OUT_Mem_to_Reg,
	output OUT_Reg_Dst,
	output OUT_Read_Data_1,
	output OUT_Read_Data_2,
	output[31:0] OUT_Pc_Plus_4
	output[31:0] OUT_Sign_Extend,
	output[4:0] OUT_Instruction_20_16,
	output[4:0] OUT_Instruction_15_11

);

Register_Pipe
Alu_Op
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Alu_OP),
	.DataOutput(OUT_Alu_Op)
);

Register_Pipe
Alu_Src
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Alu_Src),
	.DataOutput(OUT_Alu_Src)
);

Register_Pipe
Beq
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Beq),
	.DataOutput(OUT_Beq)
);

Register_Pipe
Bne
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Bne),
	.DataOutput(OUT_Bne)
);

Register_Pipe
Jump_L
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Jump_L),
	.DataOutput(OUT_Jump_L)
);

Register_Pipe
Jump_R
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Jump_R),
	.DataOutput(OUT_Jump_R)
);

Register_Pipe
Jump
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Jump),
	.DataOutput(OUT_Jump)
);

Register_Pipe
Mem_Read
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Mem_Read),
	.DataOutput(OUT_Mem_Read)
);

Register_Pipe
Mem_Write
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Mem_Write),
	.DataOutput(OUT_Mem_Write)
);

Register_Pipe
Mem_to_Reg
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Mem_to_Reg),
	.DataOutput(OUT_Mem_to_Reg)
);

Register_Pipe
Reg_Dst
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Reg_Dst),
	.DataOutput(OUT_Reg_Dst)
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
Pc_Plus_4
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Pc_Plus_4),
	.DataOutput(OUT_Pc_Plus_4)
);

Register_Pipe
Sign_Extend
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Sign_Extend),
	.DataOutput(OUT_Sign_Extend)
);

Register_Pipe
Instruction_20_16
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Instruction_20_16),
	.DataOutput(OUT_Instruction_20_16)
);

Register_Pipe
Instruction_15_11
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput(IN_Instruction_15_11),
	.DataOutput(OUT_Instruction_15_11)
);

endmodule 