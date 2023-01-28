module ID_IE_buffer (reset,instr_in,instr_out, pc_in,pc_out, register_addr_1_in,register_addr_2_in,register_addr_1_out,register_addr_2_out,alu_op_in, register_write_in, alu_src_in, mem_write_in, mem_to_register_in, mem_read_in, jump_type_in,in_port_in,stack_or_data_in,pc_to_stack_in,inc_dec_sp_in,
imm_in,ldd_or_std_in,ret_in,rti_in,call_in, read_data_1_in, read_data_2_in, alu_op_out, register_write_out, alu_src_out, mem_write_out, mem_to_register_out, mem_read_out, jump_type_out,in_port_out,stack_or_data_out,pc_to_stack_out,inc_dec_sp_out,imm_out,ldd_or_std_out,ret_out,rti_out,call_out, read_data_1_out, read_data_2_out, immediate,immediate_out, clk);
  input [2:0] register_addr_1_in,register_addr_2_in;   
  input [3:0] alu_op_in; 
  input [1:0] jump_type_in;
  input register_write_in, alu_src_in, mem_write_in, mem_to_register_in, mem_read_in, in_port_in,stack_or_data_in,pc_to_stack_in,inc_dec_sp_in,imm_in,ldd_or_std_in, clk; 
  input ret_in, rti_in, call_in;
  input [15:0] read_data_1_in, read_data_2_in,immediate;
  input [31:0] pc_in;
  input [15:0]instr_in;
  input reset;
  
  output reg [2:0] register_addr_1_out,register_addr_2_out;   
  output reg [3:0] alu_op_out; 
  output reg [1:0] jump_type_out;   
  output reg register_write_out, alu_src_out, mem_write_out, mem_to_register_out, mem_read_out,in_port_out,stack_or_data_out,pc_to_stack_out,inc_dec_sp_out,imm_out,ldd_or_std_out; 
  output reg ret_out, rti_out, call_out;
  output reg [15:0] read_data_1_out, read_data_2_out,immediate_out;
  output reg [31:0] pc_out,instr_out;
  always@(posedge clk) begin
  if(reset)begin
    alu_op_out = 0;
    register_write_out = 0;
    alu_src_out = 0;
    mem_write_out = 0;
    mem_to_register_out = 0;
    mem_read_out = 0;
    read_data_1_out = 0;
    read_data_2_out = 0;
    in_port_out = 0;
    stack_or_data_out = 0;
    pc_to_stack_out = 0;
    inc_dec_sp_out = 0;
    imm_out = 0;
    ldd_or_std_out = 0;
    immediate_out= 0;
    register_addr_1_out = 0;
    register_addr_2_out = 0;
    pc_out = 0;
    instr_out = 0;
    ret_out = 0;
    rti_out = 0;
    call_out = 0;
    jump_type_out = 0;
end
else begin
    jump_type_out = jump_type_in;
    alu_op_out = alu_op_in;
    register_write_out = register_write_in;
    alu_src_out = alu_src_in;
    mem_write_out = mem_write_in;
    mem_to_register_out = mem_to_register_in;
    mem_read_out = mem_read_in;
    read_data_1_out = read_data_1_in;
    read_data_2_out = read_data_2_in;
    in_port_out = in_port_in;
    stack_or_data_out = stack_or_data_in;
    pc_to_stack_out = pc_to_stack_in;
    inc_dec_sp_out = inc_dec_sp_in;
    imm_out = imm_in;
    ldd_or_std_out = ldd_or_std_in;
    immediate_out=immediate;
    register_addr_1_out = register_addr_1_in;
    register_addr_2_out = register_addr_2_in;
    pc_out=pc_in;
    instr_out=instr_in;
    ret_out = ret_in;
    rti_out = rti_in;
    call_out = call_in;
end
end
endmodule