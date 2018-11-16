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


module MIPS_Processor_2
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
//IF/ID
wire [31:0] pc_plus_4_to_if_id;
wire [31:0] instruction_wire_to_if_id;
//EX/MEM
wire [31:0] alu_result_to_ex_mem;
wire zero_flag_ex;
 
//ID/
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
	
	.Result(pc_plus_4_to_if_id)
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
	.Selector(reg_dst_wire),
	.MUX_Data0(instruction_bus_wire[20:16]),
	.MUX_Data1(instruction_bus_wire[15:11]),
	
	.MUX_Output(write_register_wire)

);



RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(reg_write_wire),
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
	.Selector(alu_src_wire),
	.MUX_Data0(read_data_2_wire),
	.MUX_Data1(Inmmediate_extend_wire),
	
	.MUX_Output(read_data_2_orr_inmmediate_wire)

);


ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(aluop_wire),
	.ALUFunction(instruction_bus_wire[5:0]),
	.ALUOperation(alu_operation_wire)

);



ALU
ArithmeticLogicUnit 
(
	.ALUOperation(alu_operation_wire),
	.A(read_data_1_wire),
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
	.WriteData(read_data_2_wire),
	.Address(alu_result_wire),
	.clk(clk),
	.MemWrite(mem_write_wire),
	.MemRead(mem_read_wire),
	.ReadData(read_data_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForALUSourceOrRam
(
	.Selector(mem_to_reg_wire),
	.MUX_Data0(alu_result_wire),
	.MUX_Data1(read_data_wire),
	
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
	.MUX_Data0(write_register_wire), 	
	.MUX_Data1(31),		
	
	.MUX_Output(write_register_mux_wire)
);

//Branches


assign selector_branch_flag_wire = (branch_ne_wire && !zero_wire ) || (branch_eq_wire && zero_wire);
assign branch_address_wire = ( (Inmmediate_extend_wire<<2) + pc_plus_4_wire); //ADDER

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
	

	.IN_PC_Conter_Plus_4(pc_plus_4_to_if_id),
	.IN_Instruction_Wire(instruction_wire_to_if_id),

	.OUT_PC_Conter_Plus_4(pc_plus_4_wire),
	.OUT_Instruction_Wire(instruction_bus_wire)
);

EX_MEM
EX_MEM_Stage
(
	.clk(clk),
	.reset(reset),
	
	.IN_Alu_RESULT(),
	.IN_ALU_zERO(),
	.IN_REG_dEST(),
	.IN_READ_dATA(),
	.IN_BEQ_wIRE(),
	.IN_BNE_wIRE(),
	.IN_ADD_rESULT(),
	
	.OUT_DM_aDRESS(),
	.OUT_DM_wRITE_DATA(),
	.OUT_BRANCH_sELECTOR(), 
	.OUT_REG_dEST(),
	.OUT_BEQ_wIRE(),
	.OUT_BNE_wIRE(),
	.OUT_ADD_rESULT()
);

ID_EX
ID_EX_Stage
(
	.clk(clk),
	.reset(reset),
	
	.IN_Alu_Op(),
	.IN_Alu_Src(),
	.IN_Beq(),
	.IN_Bne(),
	.In_Jump_L(),
	.IN_Jump_R(),
	.IN_Jump(),
	.IN_Mem_Read(),
	.IN_Mem_Write(),
	.IN_Mem_to_Reg(),
	.IN_Reg_Dst(),
	.IN_Read_Data_1(),
	.IN_Read_Data_2(),
	.IN_Pc_Plus_4(),
	.IN_Sign_Extend(),
	.IN_Instruction_20_16(),
	.IN_Instruction_15_11(),
	
	.OUT_Alu_Op(),
	.OUT_Alu_Src(),
	.OUT_Beq(),
	.OUT_Bne(),
	.OUT_Jump_L(),
	.OUT_Jump_R(),
	.OUT_Jump(),
	.OUT_Mem_Read(),
	.OUT_Mem_Write(),
	.OUT_Mem_to_Reg(),
	.OUT_Reg_Dst(),
	.OUT_Read_Data_1(),
	.OUT_Read_Data_2(),
	.OUT_Pc_Plus_4(),
	.OUT_Sign_Extend(),
	.OUT_Instruction_20_16(),
	.OUT_Instruction_15_11(),
);

endmodule

