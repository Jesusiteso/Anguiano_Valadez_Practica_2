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
add wave -noupdate -label ra /MIPS_Processor_TB/DUV/Register_File/Register_ra/DataOutput
add wave -noupdate -divider Tower1
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[7]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[6]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[5]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[4]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[3]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[2]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[1]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[0]}
add wave -noupdate -divider Tower2
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[15]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[14]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[13]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[12]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[11]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[10]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[9]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[8]}
add wave -noupdate -divider Tower3
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[23]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[22]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[21]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[20]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[19]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[18]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[17]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[16]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5 ps} 0}
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
WaveRestoreZoom {0 ps} {51 ps}
