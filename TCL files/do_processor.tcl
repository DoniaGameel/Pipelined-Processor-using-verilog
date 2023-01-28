
vlog processor.v
vsim processor


add wave *
add wave -position 2  sim:/processor/dec/imm
add wave -position 33  sim:/processor/dec/CU/imm
add wave -position 19  sim:/processor/dec/CU/family
add wave -position 24  sim:/processor/dec/CU/opcode
add wave -position insertpoint  \
sim:/processor/dec/CU/mem_read\
sim:/processor/fetch/instr_out_from_mem\
sim:/processor/fetch/pc_c/freeze_pc \
sim:/processor/fetch/pc_c/INTR \
sim:/processor/fetch/pc_c/pc_out \
sim:/processor/fetch/pc_c/pc_temp
add wave -position insertpoint  \
sim:/processor/ic/clk \
sim:/processor/ic/freeze_pc \
sim:/processor/ic/INTR \
sim:/processor/ic/mem_write \
sim:/processor/ic/nop_signal \
sim:/processor/ic/pc_segment \
sim:/processor/ic/push_pc_h \
sim:/processor/ic/push_pc_l \
sim:/processor/ic/ready \
sim:/processor/ic/rst \
sim:/processor/ic/state1 \
sim:/processor/ic/state2 \
sim:/processor/ic/state3 \
sim:/processor/ic/state_next \
sim:/processor/ic/state_reg
add wave -position insertpoint  \
sim:/processor/dec/RF/array_reg
add wave -position insertpoint  \
sim:/processor/dec/RF/register_write
add wave -position insertpoint  \
sim:/processor/jdu1/carry_detector \
sim:/processor/jdu1/in_flags \
sim:/processor/jdu1/JC \
sim:/processor/jdu1/jmp_sign \
sim:/processor/jdu1/JN \
sim:/processor/jdu1/jump_type \
sim:/processor/jdu1/JZ \
sim:/processor/jdu1/negative_detector \
sim:/processor/jdu1/out_flags \
sim:/processor/jdu1/zero_detector
add wave -position insertpoint  \
sim:/processor/fetch/pc_c/pc_out
add wave -position insertpoint  \
sim:/processor/fetch/pc_c/pc_temp
add wave -position insertpoint  \
sim:/processor/fetch/pc_cu/pc_out_from_PC_CU
add wave -position insertpoint  \
sim:/processor/exe1/rs1
add wave -position insertpoint  \
sim:/processor/exe1/rs2
add wave -position insertpoint sim:/processor/fuc/*
add wave -position insertpoint  \
sim:/processor/fu/forwardA \
sim:/processor/fu/forwardB
add wave -position insertpoint  \
sim:/processor/fu/en

add wave -position insertpoint  \
sim:/processor/ic/flush
add wave -position insertpoint  \
sim:/processor/fetch/pc_cu/current_pc \
sim:/processor/fetch/pc_cu/interrupt_signal \
sim:/processor/fetch/pc_cu/jump_addr \
sim:/processor/fetch/pc_cu/jump_signal \
sim:/processor/fetch/pc_cu/next_pc \
sim:/processor/fetch/pc_cu/pc_out_from_PC_CU \
sim:/processor/fetch/pc_cu/pop_signal \
sim:/processor/fetch/pc_cu/popped_pc \
sim:/processor/fetch/pc_cu/reset \
sim:/processor/fetch/pc_cu/stall_signal
add wave -position insertpoint  \
sim:/processor/exe1/flags_out
add wave -position insertpoint  \
sim:/processor/exe1/flags
add wave -position insertpoint  \
sim:/processor/exe1/alu_out_flags
add wave -position insertpoint  \
sim:/processor/exe1/alu1/zero_result_detector
add wave -position insertpoint  \
sim:/processor/exe1/alu1/neg_result_detector
add wave -position insertpoint  \
sim:/processor/exe1/alu1/carry_detector
add wave -position insertpoint  \
sim:/processor/exe1/alu_op
add wave -position insertpoint  \
sim:/processor/memo1/alu_address \
sim:/processor/memo1/clk \
sim:/processor/memo1/input_data \
sim:/processor/memo1/mem_address \
sim:/processor/memo1/mem_read \
sim:/processor/memo1/mem_write \
sim:/processor/memo1/mem_write_int \
sim:/processor/memo1/Memory \
sim:/processor/memo1/modified_sp \
sim:/processor/memo1/out_data \
sim:/processor/memo1/pc_to_stack_int \
sim:/processor/memo1/ret_pop \
sim:/processor/memo1/rst \
sim:/processor/memo1/rti_pop \
sim:/processor/memo1/sp \
sim:/processor/memo1/sp_address \
sim:/processor/memo1/stack_or_data
add wave -position insertpoint  \
sim:/processor/exe1/alu_op \
sim:/processor/exe1/alu_out \
sim:/processor/exe1/alu_out_flags \
sim:/processor/exe1/clk \
sim:/processor/exe1/execute_out \
sim:/processor/exe1/flags \
sim:/processor/exe1/flags_out \
sim:/processor/exe1/imm_rs2_mux_result \
sim:/processor/exe1/imm_rs2_sig \
sim:/processor/exe1/immediate \
sim:/processor/exe1/rs1 \
sim:/processor/exe1/rs2 \
sim:/processor/exe1/rst

add wave -position insertpoint  \
sim:/processor/fr/clk \
sim:/processor/fr/en \
sim:/processor/fr/in_flags \
sim:/processor/fr/out_flags \
sim:/processor/fr/rst
add wave -position insertpoint  \
sim:/processor/exe1/alu1/carry_detector \
sim:/processor/exe1/alu1/in_flags \
sim:/processor/exe1/alu1/neg_result_detector \
sim:/processor/exe1/alu1/op \
sim:/processor/exe1/alu1/out_flags \
sim:/processor/exe1/alu1/rs1 \
sim:/processor/exe1/alu1/rs2 \
sim:/processor/exe1/alu1/temp_out \
sim:/processor/exe1/alu1/zero_result_detector
add wave -position insertpoint  \
sim:/processor/rti_controller/clk \
sim:/processor/rti_controller/pop_segment \
sim:/processor/rti_controller/ready \
sim:/processor/rti_controller/rst \
sim:/processor/rti_controller/rti \
sim:/processor/rti_controller/rti_pop \
sim:/processor/rti_controller/state1 \
sim:/processor/rti_controller/state2 \
sim:/processor/rti_controller/state3 \
sim:/processor/rti_controller/state4 \
sim:/processor/rti_controller/state5 \
sim:/processor/rti_controller/state6 \
sim:/processor/rti_controller/state_next \
sim:/processor/rti_controller/state_reg \
sim:/processor/rti_controller/write_flags \
sim:/processor/rti_controller/write_pc
add wave -position insertpoint  \
sim:/processor/rti_controller/imm
add wave -position insertpoint  \
sim:/processor/rti_controller/inc_pc
add wave -position insertpoint  \
sim:/processor/call_cont/call \
sim:/processor/call_cont/clk \
sim:/processor/call_cont/flush \
sim:/processor/call_cont/freeze_pc \
sim:/processor/call_cont/imm \
sim:/processor/call_cont/INTR \
sim:/processor/call_cont/is_call_from_buff_1 \
sim:/processor/call_cont/mem_write \
sim:/processor/call_cont/nop_signal \
sim:/processor/call_cont/Oh_INTR \
sim:/processor/call_cont/out_imm \
sim:/processor/call_cont/pc_segment \
sim:/processor/call_cont/pc_to_stack \
sim:/processor/call_cont/push_flags \
sim:/processor/call_cont/push_pc_h \
sim:/processor/call_cont/push_pc_l \
sim:/processor/call_cont/ready \
sim:/processor/call_cont/rst \
sim:/processor/call_cont/state1 \
sim:/processor/call_cont/state2 \
sim:/processor/call_cont/state3 \
sim:/processor/call_cont/state_next \
sim:/processor/call_cont/state_reg \
sim:/processor/call_cont/take_call_pc
add wave -position insertpoint  \
sim:/processor/ret_cont/ret_pop
add wave -position insertpoint  \
sim:/processor/ret_cont/clk \
sim:/processor/ret_cont/go_INTR \
sim:/processor/ret_cont/is_INTR \
sim:/processor/ret_cont/out_INTR \
sim:/processor/ret_cont/pop_segment \
sim:/processor/ret_cont/ready \
sim:/processor/ret_cont/ret \
sim:/processor/ret_cont/ret_pop \
sim:/processor/ret_cont/rst \
sim:/processor/ret_cont/state1 \
sim:/processor/ret_cont/state2 \
sim:/processor/ret_cont/state3 \
sim:/processor/ret_cont/state4 \
sim:/processor/ret_cont/state5 \
sim:/processor/ret_cont/state_next \
sim:/processor/ret_cont/state_reg \
sim:/processor/ret_cont/write_pc
add wave -position insertpoint  \
sim:/processor/ret_cont/nop
add wave -position insertpoint  \
sim:/processor/memo1/mem_address_selector/adress_out \
sim:/processor/memo1/mem_address_selector/alu_adress \
sim:/processor/memo1/mem_address_selector/extendedAluAdress \
sim:/processor/memo1/mem_address_selector/pc_to_stack_int \
sim:/processor/memo1/mem_address_selector/ret_pop \
sim:/processor/memo1/mem_address_selector/rti_pop \
sim:/processor/memo1/mem_address_selector/sp_adress \
sim:/processor/memo1/mem_address_selector/stack_or_data
add wave -position insertpoint  \
sim:/processor/hdu/enable \
sim:/processor/hdu/ID_EX_mem_read \
sim:/processor/hdu/ID_EX_register_dst \
sim:/processor/hdu/IF_ID_register_src1 \
sim:/processor/hdu/IF_ID_register_src2 \
sim:/processor/hdu/stall
add wave -position insertpoint  \
sim:/processor/suj_luc/clk \
sim:/processor/suj_luc/ready \
sim:/processor/suj_luc/rst \
sim:/processor/suj_luc/stall \
sim:/processor/suj_luc/stall_out \
sim:/processor/suj_luc/state1 \
sim:/processor/suj_luc/state2 \
sim:/processor/suj_luc/state_next \
sim:/processor/suj_luc/state_reg \
sim:/processor/suj_luc/unconditional_jump
add wave -position insertpoint  \
sim:/processor/hduc2/clk \
sim:/processor/hduc2/out_sig \
sim:/processor/hduc2/ready \
sim:/processor/hduc2/reset \
sim:/processor/hduc2/state1 \
sim:/processor/hduc2/state2 \
sim:/processor/hduc2/state_end \
sim:/processor/hduc2/state_next \
sim:/processor/hduc2/state_reg \
sim:/processor/hduc2/uncond_jump
add wave -position insertpoint  \
sim:/processor/fetch/pc_cu/current_pc \
sim:/processor/fetch/pc_cu/interrupt_signal \
sim:/processor/fetch/pc_cu/jump_addr \
sim:/processor/fetch/pc_cu/jump_signal \
sim:/processor/fetch/pc_cu/next_pc \
sim:/processor/fetch/pc_cu/pc_out_from_PC_CU \
sim:/processor/fetch/pc_cu/pop_signal \
sim:/processor/fetch/pc_cu/popped_pc \
sim:/processor/fetch/pc_cu/reset \
sim:/processor/fetch/pc_cu/stall_signal \
sim:/processor/fetch/pc_cu/take_call \
sim:/processor/fetch/pc_cu/take_intr
add wave -position insertpoint  \
sim:/processor/fc/call \
sim:/processor/fc/clk \
sim:/processor/fc/flush \
sim:/processor/fc/jump \
sim:/processor/fc/pc_to_stack \
sim:/processor/fc/ready \
sim:/processor/fc/rst \
sim:/processor/fc/state1 \
sim:/processor/fc/state2 \
sim:/processor/fc/state3 \
sim:/processor/fc/state4 \
sim:/processor/fc/state5 \
sim:/processor/fc/state_next \
sim:/processor/fc/state_reg \
sim:/processor/fc/unconditional_jump
add wave -position insertpoint  \
sim:/processor/suj_luc/take_jmp
add wave -position insertpoint  \
sim:/processor/fu/alu_out_IE_MEM \
sim:/processor/fu/alu_out_MEM_WB \
sim:/processor/fu/en \
sim:/processor/fu/forwardA \
sim:/processor/fu/forwardB \
sim:/processor/fu/reg_write_MEM \
sim:/processor/fu/reg_write_WB \
sim:/processor/fu/Rsrc1 \
sim:/processor/fu/Rsrc2
add wave -position insertpoint  \
sim:/processor/buff1/clk \
sim:/processor/buff1/en \
sim:/processor/buff1/flush \
sim:/processor/buff1/IN_PORT_in \
sim:/processor/buff1/IN_PORT_out \
sim:/processor/buff1/instr \
sim:/processor/buff1/instr_out \
sim:/processor/buff1/pc \
sim:/processor/buff1/pc_out \
sim:/processor/buff1/rst \
sim:/processor/buff1/stall
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/INTR 0 0
run;
force -freeze sim:/processor/reset 0 0