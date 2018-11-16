onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider ProgramCounter
add wave -noupdate /MIPS_Processor_TB/DUV/ProgramCounter/clk
add wave -noupdate /MIPS_Processor_TB/DUV/ProgramCounter/reset
add wave -noupdate /MIPS_Processor_TB/DUV/ProgramCounter/NewPC
add wave -noupdate /MIPS_Processor_TB/DUV/ProgramCounter/PCValue
add wave -noupdate -divider testers
add wave -noupdate /MIPS_Processor_TB/DUV/ROMProgramMemory/Instruction
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/ControlValues
add wave -noupdate /MIPS_Processor_TB/DUV/selector_branch_flag_wire
add wave -noupdate -divider ALU
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/A
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/B
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/Zero
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/ALUResult
add wave -noupdate -label t0 /MIPS_Processor_TB/DUV/Register_File/Register_t0/DataOutput
add wave -noupdate -label t1 /MIPS_Processor_TB/DUV/Register_File/Register_t1/DataOutput
add wave -noupdate -label t2 /MIPS_Processor_TB/DUV/Register_File/Register_t2/DataOutput
add wave -noupdate -label t3 /MIPS_Processor_TB/DUV/Register_File/Register_t3/DataOutput
add wave -noupdate -label t4 /MIPS_Processor_TB/DUV/Register_File/Register_t4/DataOutput
add wave -noupdate -label s0 /MIPS_Processor_TB/DUV/Register_File/Register_s0/DataOutput
add wave -noupdate -label s1 /MIPS_Processor_TB/DUV/Register_File/Register_s1/DataOutput
add wave -noupdate -label s2 /MIPS_Processor_TB/DUV/Register_File/Register_s2/DataOutput
add wave -noupdate -label s3 /MIPS_Processor_TB/DUV/Register_File/Register_s3/DataOutput
add wave -noupdate -label s7 /MIPS_Processor_TB/DUV/Register_File/Register_s7/DataOutput
add wave -noupdate -label ra /MIPS_Processor_TB/DUV/Register_File/Register_ra/DataOutput
add wave -noupdate -label sp /MIPS_Processor_TB/DUV/Register_File/Register_sp/DataOutput
add wave -noupdate -label IDEX_RegWrite /MIPS_Processor_TB/DUV/ID_EX_Stage/OUT_RegWrite
add wave -noupdate -label EXMEM_RegWrite /MIPS_Processor_TB/DUV/EX_MEM_Stage/OUT_RegWrite
add wave -noupdate -label MEMWB_RegWrite /MIPS_Processor_TB/DUV/MEM_WB_Stage/OUT_RegWrite
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteData
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteRegister
add wave -noupdate -label EXMEM_WriteRedister /MIPS_Processor_TB/DUV/EX_MEM_Stage/OUT_WriteRegisterData
add wave -noupdate -label MEM_WB_WriteRegister /MIPS_Processor_TB/DUV/MEM_WB_Stage/OUT_WriteRegisterData
add wave -noupdate -divider IF_ID
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID_Stage/clk
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID_Stage/reset
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID_Stage/IN_PC_Conter_Plus_4
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID_Stage/IN_Instruction_Wire
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID_Stage/OUT_PC_Conter_Plus_4
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID_Stage/OUT_Instruction_Wire
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {117 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {104 ps} {167 ps}
