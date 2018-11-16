/******************************************************************
* Description
*	This is the top-level of a MIPS processor that can execute the next set of instructions:
*		add
*		addi
*		sub
*		ori
*		or
*		and
*		nor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer architecture class at ITESO.
* Version:
*	1.5
* Author:
*	Dr. JosÃ© Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	2/09/2018
******************************************************************/


module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 32,
	parameter PC_INCREMENT = 4
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);
//******************************************************************/
//******************************************************************/
assign  PortOut = 0;

//******************************************************************/
//******************************************************************/
// signals to connect modules
wire branch_ne_wire;
wire branch_eq_wire;
wire reg_dst_wire;
wire not_zero_and_brach_ne;
wire zero_and_brach_eq;
wire or_for_branch;
wire alu_src_wire;
wire reg_write_wire;
wire zero_wire;

//LW, SW wires
wire mem_read_wire;
wire mem_to_reg_wire;
wire mem_write_wire;
// end LW, WS wires
//JR, Jmp
wire jump_r_wire;
wire [31:0] pc_direct_wire;
wire [27:0] jump_shift_wire;
wire [31:0] jumped_address_wire;
wire jump_wire;
wire jump_l_wire;
wire [31:0] mux_jump_to_mux_jr_wire;
wire [31:0] write_back_data_jal_wire;
wire [4:0] write_register_mux_wire;
wire selector_branch_flag_wire;
wire [31:0] branch_address_wire;
wire [31:0] mux_branch_to_mux_jump_wire;
// end JR, Jmp
//Pipeline wires
wire [31:0] pc_plus_4_to_if_id;
wire [31:0] instruction_wire_to_if_id;
//ID_EX

wire [2:0] idex_aluop_wire;
wire idex_alusrc_wire;
wire idex_regdst_wire;
wire [31:0] idex_read_data_1_wire;
wire [31:0] idex_read_data_2_wire;
wire [31:0] idex_signextend_instruction_wire;
wire [4:0] idex_rt_to_regdest_wire;
wire [4:0] idex_rd_to_regdest_wire;
wire [5:0] idex_alucontrol_values_wire;

wire idex_to_exmem_beq_wire;
wire idex_to_exmem_bne_wire;
wire idex_to_exmem_memread_wire;
wire idex_to_exmem_memwrite_wire;
wire idex_to_exmem_memtoreg_wire;
wire idex_to_exmem_regwrite_wire;

//EX_MEM

wire exmem_memread_wire;
wire exmem_memwrite_wire;
//wire exmem_aluzero_wire; //branch
wire [31:0] exmem_readdata2_wire;
wire [31:0] exmem_ALUResult;

wire [4:0] exmem_to_memwb_witeregisterdata_wire;
wire exmem_to_memwb_memtoreg_wire;
wire exmem_to_memwb_regwrite_wire;

//MEM_WB
wire memwb_memtoreg_wire;
wire memwb_regwrite_wire;

wire [31:0] memwb_datamemory_data_wire;
wire [31:0] memwb_aluresult_wire;
wire [4:0] memwb_writeregisterdata_wire;

//Pipeline wire end

wire [2:0] aluop_wire;
wire [3:0] alu_operation_wire;
wire [4:0] write_register_wire;
wire [31:0] mux_pc_wire;
wire [31:0] pc_wire;
wire [31:0] instruction_bus_wire;
wire [31:0] read_data_1_wire;
wire [31:0] read_data_2_wire;
wire [31:0] Inmmediate_extend_wire;
wire [31:0] read_data_2_orr_inmmediate_wire;
wire [31:0] alu_result_wire;
wire [31:0] pc_plus_4_wire;
wire [31:0] inmmediate_extended_wire;
wire [31:0] pc_to_branch_wire;

wire [31:0] read_data_wire;
wire [31:0] write_back_data_wire;

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
ControlUnit
(
	.OP(instruction_bus_wire[31:26]),
	.RegDst(reg_dst_wire),
	.BranchNE(branch_ne_wire),
	.BranchEQ(branch_eq_wire),
	.ALUOp(aluop_wire),
	.ALUSrc(alu_src_wire),
	.RegWrite(reg_write_wire),
	//LW,SW wires
	.MemRead(mem_read_wire),
	.MemtoReg(mem_to_reg_wire),
	.MemWrite(mem_write_wire),
	//JR
	.ALUFunction(instruction_bus_wire[5:0]),
	.JumpR(jump_r_wire),
	.Jump(jump_wire),
	.JumpL(jump_l_wire) //unconeccted
);

PC_Register
ProgramCounter
(
	.clk(clk),
	.reset(reset),
	.NewPC(pc_direct_wire),
	.PCValue(pc_wire)
);


ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(pc_wire),
	.Instruction(instruction_wire_to_if_id)
);

Adder32bits
PC_Puls_4
(
	.Data0(pc_wire),
	.Data1(PC_INCREMENT),
	
	.Result(pc_plus_4_wire)
);


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(idex_regdst_wire),
	.MUX_Data0(idex_rt_to_regdest_wire),
	.MUX_Data1(idex_rd_to_regdest_wire),
	
	.MUX_Output(write_register_wire)

);



RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(memwb_regwrite_wire),
	.WriteRegister(write_register_mux_wire), 
	.ReadRegister1(instruction_bus_wire[25:21]),
	.ReadRegister2(instruction_bus_wire[20:16]),
	.WriteData(write_back_data_jal_wire),
	.ReadData1(read_data_1_wire),
	.ReadData2(read_data_2_wire)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(instruction_bus_wire[15:0]),
   .SignExtendOutput(Inmmediate_extend_wire)
);



Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(idex_alusrc_wire),
	.MUX_Data0(idex_read_data_2_wire),
	.MUX_Data1(idex_signextend_instruction_wire),
	
	.MUX_Output(read_data_2_orr_inmmediate_wire)

);


ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(idex_aluop_wire),
	.ALUFunction(idex_alucontrol_values_wire),
	.ALUOperation(alu_operation_wire)

);



ALU
ArithmeticLogicUnit 
(
	.ALUOperation(alu_operation_wire),
	.A(idex_read_data_1_wire),
	.B(read_data_2_orr_inmmediate_wire),
	.shamt(instruction_bus_wire[10:6]),
	.Zero(zero_wire),
	.ALUResult(alu_result_wire)
);

assign ALUResultOut = alu_result_wire;

//Temp LW

DataMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
RAMDataMemory
(
	.WriteData(exmem_readdata2_wire),
	.Address(exmem_ALUResult),
	.clk(clk),
	.MemWrite(exmem_memwrite_wire),
	.MemRead(exmem_memread_wire),
	.ReadData(read_data_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForALUSourceOrRam
(
	.Selector(memwb_memtoreg_wire),
	.MUX_Data0(memwb_aluresult_wire),
	.MUX_Data1(memwb_datamemory_data_wire),
	
	.MUX_Output(write_back_data_wire)

);

//JR

Multiplexer2to1
#(
	.NBits(32)
)
MUX_PC_From_ALU_Source
(
	.Selector(jump_r_wire),
	.MUX_Data0(mux_jump_to_mux_jr_wire),
	.MUX_Data1(read_data_1_wire),
	
	.MUX_Output(pc_direct_wire)

);

//J_Type

ShiftLeft2
JumpShift
(
	.DataInput(instruction_bus_wire[25:0]),
	.DataOutput(jump_shift_wire)
);

assign jumped_address_wire = {pc_plus_4_wire[31:28],jump_shift_wire};


Multiplexer2to1
#(
	.NBits(32)
)
MUX_PC_For_Jump
(
	.Selector(jump_wire),
	.MUX_Data0(mux_branch_to_mux_jump_wire), //aqui va la salida de los branch
	.MUX_Data1(jumped_address_wire),
	
	.MUX_Output(mux_jump_to_mux_jr_wire)

);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_WriteBack_
(
	.Selector(jump_l_wire),
	.MUX_Data0(write_back_data_wire),
	.MUX_Data1(pc_plus_4_wire), //flag to see
	
	.MUX_Output(write_back_data_jal_wire)

);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_Register_or_ra
(
	.Selector(jump_l_wire),
	.MUX_Data0(memwb_writeregisterdata_wire), //write register data	
	.MUX_Data1(31),		
	
	.MUX_Output(write_register_mux_wire)
);

//Branches


assign selector_branch_flag_wire = (branch_ne_wire && !zero_wire ) || (branch_eq_wire && zero_wire);
assign branch_address_wire = ( (Inmmediate_extend_wire<<2) + pc_plus_4_wire);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_Branch_or_PC
(
	.Selector(selector_branch_flag_wire),
	.MUX_Data0(pc_plus_4_wire),
	.MUX_Data1(branch_address_wire),//salida de los branch
	
	.MUX_Output(mux_branch_to_mux_jump_wire)

);

IF_ID
IF_ID_Stage
(
	.clk(clk),
	.reset(reset),
	
	.IN_PC_Conter_Plus_4(pc_plus_4_wire),
	.IN_Instruction_Wire(instruction_wire_to_if_id),
//outputs
	.OUT_PC_Conter_Plus_4(pc_plus_4_to_if_id),
	.OUT_Instruction_Wire(instruction_bus_wire)
);


ID_EX
ID_EX_Stage
(
	.clk(clk),
	.reset(reset),
	//All control Values
	//.IN_ControlValues(controlvalues_wire),
	.IN_ALUOP     (aluop_wire), //2:0
	.IN_Branch_EQ (branch_eq_wire),
	.IN_Branch_NE (branch_ne_wire),
	.IN_MemWrite  (mem_write_wire),
	.IN_MemRead   (mem_read_wire),
	.IN_RegWrite  (reg_write_wire),
	.IN_MemToReg  (mem_to_reg_wire),
	.IN_ALUSrc    (alu_src_wire),
	.IN_RegDst    (reg_dst_wire),
	.IN_Jump_r    (jump_r_wire),
	.IN_Jump      (jump_wire),
	.IN_Jump_l    (jump_l_wire),
	//PC_wire
	.IN_PC_Conter_Plus_4(pc_plus_4_to_if_id), //[31:0]
	//Read Datas
	.IN_Read_Data_1(read_data_1_wire), //[31:0]
	.IN_Read_Data_2(read_data_2_wire), //[31:0]
	//Instruction wires
	.IN_SignExtended_Instruction(Inmmediate_extend_wire), //[31:0]
	.IN_RT_To_RegDst(instruction_bus_wire[20:16]), //[20:16]
	.IN_RD_To_RegDst(instruction_bus_wire[15:11]), //[15:11]
	.IN_ALUControl_Values(instruction_bus_wire[5:0]), //[5:0]
	
	//outputs
	//.OUT_ControlValues(),
	.OUT_ALUOP(idex_aluop_wire), //2:0
	.OUT_Branch_EQ(idex_to_exmem_beq_wire),
	.OUT_Branch_NE(idex_to_exmem_bne_wire),
	.OUT_MemWrite(idex_to_exmem_memwrite_wire),
	.OUT_MemRead(idex_to_exmem_memread_wire),
	.OUT_RegWrite(idex_to_exmem_regwrite_wire),
	.OUT_MemToReg(idex_to_exmem_memtoreg_wire),
	.OUT_ALUSrc(idex_alusrc_wire),
	.OUT_RegDst(idex_regdst_wire),
//	.OUT_Jump_r(),
//	.OUT_Jump(),
//	.OUT_Jump_l(),
	
//	.OUT_PC_Conter_Plus_4(), //[31:0]
	.OUT_Read_Data_1(idex_read_data_1_wire), //[31:0]
	.OUT_Read_Data_2(idex_read_data_2_wire), //[31:0]
	.OUT_SignExtended_Instruction(idex_signextend_instruction_wire), //[31:0]
	.OUT_RT_To_RegDst(idex_rt_to_regdest_wire), //[20:16]
	.OUT_RD_To_RegDst(idex_rd_to_regdest_wire), //[15:11]
	.OUT_ALUControl_Values(idex_alucontrol_values_wire) //[5:0]
);



EX_MEM
EX_MEM_Stage
(
	.clk(clk),
	.reset(reset),
	
	.IN_BEQ(idex_to_exmem_beq_wire),
	.IN_BNE(idex_to_exmem_bne_wire),
	.IN_MemRead(idex_to_exmem_memread_wire),
	.IN_MemWrite(idex_to_exmem_memwrite_wire),
	.IN_MemToReg(idex_to_exmem_memtoreg_wire),
	.IN_RegWrite(idex_to_exmem_regwrite_wire),
	
	.IN_ALUResult(alu_result_wire), //31:0
	.IN_ALUZero(zero_wire),
//	.IN_Added_Address(),
	.IN_ReadData2(idex_read_data_2_wire), //31:0
	.IN_WriteRegisterData(write_register_wire), //4:0
	
	//outputs
//	.OUT_BEQ(),
//	.OUT_BNE(),
	.OUT_MemRead(exmem_memread_wire),
	.OUT_MemWrite(exmem_memwrite_wire),
	.OUT_MemToReg(exmem_to_memwb_memtoreg_wire),
	.OUT_RegWrite(exmem_to_memwb_regwrite_wire),
	.OUT_ALUResult(exmem_ALUResult), //31:0
//	.OUT_ALUZero(),
//	.OUT_Added_Address(),
	.OUT_ReadData2(exmem_readdata2_wire), //31:0
	.OUT_WriteRegisterData(exmem_to_memwb_witeregisterdata_wire) //4:0
	
);



MEM_WB
MEM_WB_Stage
(
	.clk(clk),
	.reset(reset),
	
	.IN_MemToReg(exmem_to_memwb_memtoreg_wire),
	.IN_RegWrite(exmem_to_memwb_regwrite_wire),
	.IN_DataMemory_Data(read_data_wire), //[31:0]
	.IN_ALUResult(exmem_ALUResult), //[31:0] 
	.IN_WriteRegisterData(exmem_to_memwb_witeregisterdata_wire),
	//outputs
	.OUT_MemToReg(memwb_memtoreg_wire),
	.OUT_RegWrite(memwb_regwrite_wire),
	.OUT_DataMemory_Data(memwb_datamemory_data_wire), //[31:0]
	.OUT_ALUResult(memwb_aluresult_wire), //[31:0]
	.OUT_WriteRegisterData(memwb_writeregisterdata_wire)
);



endmodule







