//`include "./check_imm_circuit.v"
//`include "./get_pc_from_buffer.v"
//`include "./instruction_memory.v"
//`include "./mux.v"
//`include "./program_counter.v"

module instruction_fetch_stage(
take_intr,
INTR,
clk,
rst,
freeze_pc,
imm_instr_sig,
pc_out_from_pc,
pc_out_from_pc_adder,
instr_from_mux,
instr_out_from_mem,
jump_signal,
stall_signal,
pc_to_stack,
mem_read,
poped_pc,
jump_addr,
write_popped_pc
,take_call,
stall_jump
);
input clk,rst,freeze_pc,INTR,take_intr;
input imm_instr_sig;
input jump_signal,stall_jump;
input stall_signal;
input pc_to_stack,take_call;
input mem_read,write_popped_pc;
input [31:0] poped_pc;
input [15:0] jump_addr;
output wire [31:0]pc_out_from_pc;
output wire [31:0]pc_out_from_pc_adder;
output wire [15:0]instr_out_from_mem;
output wire[15:0] instr_from_mux;
wire [31:0]pc_out_from_PC_CU;
wire [15:0] nop=16'b01_010_000_000_0_0000;


//wire sig_from_check_imm;



pc pc_c(pc_out_from_PC_CU,clk,rst,freeze_pc,INTR,pc_out_from_pc);
pc_adder pc_add(pc_out_from_pc,pc_out_from_pc_adder);


instrMEm mem(clk,pc_out_from_pc,instr_out_from_mem);

mux m1(rst,instr_out_from_mem,imm_instr_sig,nop,instr_from_mux);


pc_control_unit pc_cu (
take_intr,
rst,
pc_out_from_pc,
pc_out_from_pc_adder,
poped_pc,
INTR,
write_popped_pc,//pop_signal
jump_signal,
freeze_pc||stall_signal,
jump_addr,
pc_out_from_PC_CU,
take_call,
stall_jump
);



//check_imm_circuit ch(instr_out_from_buff[0],sig_from_check_imm);
//assign imm_instr_sig=sig_from_check_imm;


endmodule