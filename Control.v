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
	
	output JumpR
);
localparam R_Type = 0;
localparam I_Type_ADDI = 6'h8;
localparam I_Type_ORI  = 6'h0d;
localparam I_Type_LUI  = 6'h0f;
localparam I_Type_ANDI = 6'h0c;

localparam I_Type_LW   = 6'h23;
localparam I_Type_SW   = 6'h2b;

localparam ALUF_JR     = 6'b001000;


reg [10:0] ControlValues;

always@(OP or ALUFunction) begin

	if(OP == R_Type)
			case(ALUFunction)
				ALUF_JR: ControlValues= 12'b1_1_000_00_00_111;
			
			default:    ControlValues= 12'b0_1_001_00_00_111;
			endcase

	casex(OP)
		//R_Type:       ControlValues= 11'b1_001_00_00_111;
		I_Type_ADDI:  ControlValues= 12'b0_0_101_00_00_100;
		I_Type_ORI:   ControlValues= 12'b0_0_101_00_00_101;
		I_Type_LUI:   ControlValues= 12'b0_0_101_00_00_000;
		I_Type_ANDI:  ControlValues= 12'b0_0_101_00_00_110;
		
		I_Type_LW:	  ControlValues= 12'b0_0_111_10_00_100;
		I_Type_SW:    ControlValues= 12'b0_0_100_01_00_100;
		
		default:
			ControlValues= 10'b0000000000;
		endcase
end	
	
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


