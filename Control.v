/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module Control
(
	input [5:0]OP,
	input [5:0]ALUFunction,
	
	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output [2:0]ALUOp,
	
	output JumpR,
	output Jump,
	output JumpL
);
localparam R_Type = 0;
localparam I_Type_ADDI = 6'h8;
localparam I_Type_ORI  = 6'h0d;
localparam I_Type_LUI  = 6'h0f;
localparam I_Type_ANDI = 6'h0c;

localparam I_Type_LW   = 6'h23;
localparam I_Type_SW   = 6'h2b;

localparam J_Type_J	  = 6'h02;
localparam J_Type_JAL  = 6'h03;

localparam ALUF_JR     = 6'b001000;


reg [13:0] ControlValues;

always@(OP or ALUFunction) begin

	if(OP == R_Type)
			case(ALUFunction)
				ALUF_JR: ControlValues= 14'b001_1_000_00_00_111;
			
			default:    ControlValues= 14'b000_1_001_00_00_111;
			endcase

	casex(OP)
		//R_Type:       ControlValues= 11'b1_001_00_00_111;
		I_Type_ADDI:  ControlValues= 14'b000_0_101_00_00_100;
		I_Type_ORI:   ControlValues= 14'b000_0_101_00_00_101;
		I_Type_LUI:   ControlValues= 14'b000_0_101_00_00_000;
		I_Type_ANDI:  ControlValues= 14'b000_0_101_00_00_110;
		
		I_Type_LW:	  ControlValues= 14'b000_0_111_10_00_100;
		I_Type_SW:    ControlValues= 14'b000_0_100_01_00_100;
		
		J_Type_J:     ControlValues= 14'b010_0_000_00_00_111;
		J_Type_JAL:   ControlValues= 14'b100_0_101_00_00_100;
		
		default:
			ControlValues= 14'b00000000000000;
		endcase
end	
	
assign JumpL    = ControlValues[13]; //Instruccion JAL	
assign Jump     = ControlValues[12]; //Instruccion Jump	
assign JumpR    = ControlValues[11]; //Toma valor de Data1
	
assign RegDst   = ControlValues[10];

assign ALUSrc   = ControlValues[9];
assign MemtoReg = ControlValues[8];
assign RegWrite = ControlValues[7];

assign MemRead  = ControlValues[6];
assign MemWrite = ControlValues[5];

assign BranchNE = ControlValues[4];
assign BranchEQ = ControlValues[3];

assign ALUOp    = ControlValues[2:0];	

endmodule


