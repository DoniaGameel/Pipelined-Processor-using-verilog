//`include "./reg_file.v"
//`include "./control_unit.v"

module decode_stage(instruction, register_write_in, write_addr ,alu_op, register_write_out, alu_src,mem_write, mem_to_register, mem_read, jump_type,in_port,stack_or_data,pc_to_stack,inc_dec_sp,imm,ldd_or_std, write_data, read_data_1, read_data_2,ret,rti,call, clk, reset);
  input [15:0] instruction;
  input [2:0] write_addr;
  input clk, reset, register_write_in;
  input [15:0] write_data;
  output [1:0] jump_type;
  output [3:0]  alu_op;    
  output register_write_out, alu_src, mem_write, mem_to_register, mem_read, in_port,stack_or_data,pc_to_stack,inc_dec_sp,imm,ldd_or_std,ret,rti,call; 
  output [15:0] read_data_1, read_data_2;
  control_unit CU (instruction[15:14], instruction[13:11] ,alu_op ,register_write_out ,alu_src ,mem_write ,mem_to_register ,mem_read , unconditional_jump, jump_type ,in_port ,stack_or_data ,pc_to_stack ,inc_dec_sp ,imm,ldd_or_std,ret,rti,call,reset);
  reg_file RF (instruction[10:8] ,instruction[7:5] ,register_write_in ,write_addr ,write_data ,read_data_1, read_data_2, clk, reset);

endmodule