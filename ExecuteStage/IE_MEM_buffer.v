module IE_MEM_buffer (reset,ret_in,ret_out,read_addr_2_in,read_addr_2_out, flags_in,flags_out, instr_in,instr_out, pc_in,pc_out, register_write_in, mem_write_in, mem_to_register_in, mem_read_in, branch_in,jump_type_in,in_port_in,stack_or_data_in,pc_to_stack_in,inc_dec_sp_in,ldd_or_std_in, read_data_2_in, register_write_out, mem_write_out, mem_to_register_out, mem_read_out, branch_out,jump_type_out,in_port_out,stack_or_data_out,pc_to_stack_out,inc_dec_sp_out,ldd_or_std_out, read_data_2_out,alu_result_in,alu_result_out ,read_addr_in,read_addr_out,clk,IN_PORT_in,IN_PORT_out,arth_in,arth_out,read_data_1_in,read_data_1_out);
  input [2:0]  read_addr_in,flags_in,read_addr_2_in;    
  input [1:0]jump_type_in;
  input register_write_in,reset,arth_in, ret_in,mem_write_in, mem_to_register_in, mem_read_in, branch_in,in_port_in,stack_or_data_in,pc_to_stack_in,inc_dec_sp_in,ldd_or_std_in, clk; 
  input [15:0]  read_data_2_in,alu_result_in,IN_PORT_in,read_data_1_in;
  input [31:0] pc_in,instr_in;
  output reg [2:0]  jump_type_out,read_addr_out,flags_out,read_addr_2_out;    
  output reg register_write_out,ret_out,arth_out, mem_write_out, mem_to_register_out, mem_read_out, branch_out,in_port_out,stack_or_data_out,pc_to_stack_out,inc_dec_sp_out,ldd_or_std_out; 
  output reg [15:0]  read_data_2_out,alu_result_out,IN_PORT_out,read_data_1_out;
  output reg [31:0] pc_out,instr_out;
  
  always@(posedge clk) begin
  if(reset)begin
  read_data_1_out=0;
  IN_PORT_out=0;
	ret_out=0;
	mem_write_out=0;
	pc_to_stack_out=0;
	stack_or_data_out=0;
arth_out=0;
  register_write_out = 0;
  read_addr_2_out=0;
  mem_to_register_out = 0;
  mem_read_out = 0;
  read_data_2_out = 0;
  branch_out = 0;
  in_port_out = 0;
  inc_dec_sp_out = 0;
  ldd_or_std_out = 0;
	alu_result_out=0;
	read_addr_out=0;
	pc_out=0;
	instr_out=0;
	flags_out=0;
	end
  else  begin
  read_data_1_out=read_data_1_in;
  arth_out=arth_in;
  IN_PORT_out=IN_PORT_in;
  ret_out=ret_in;
  register_write_out = register_write_in;
  read_addr_2_out=read_addr_2_in;
  mem_write_out = mem_write_in;
  mem_to_register_out = mem_to_register_in;
  mem_read_out = mem_read_in;
  read_data_2_out = read_data_2_in;
  branch_out = branch_in;
  in_port_out = in_port_in;
  stack_or_data_out = stack_or_data_in;
  pc_to_stack_out = pc_to_stack_in;
  inc_dec_sp_out = inc_dec_sp_in;
  ldd_or_std_out = ldd_or_std_in;
	alu_result_out=alu_result_in;
	read_addr_out=read_addr_in;
	pc_out=pc_in;
	instr_out=instr_in;
	flags_out=flags_in;
	end
  end
endmodule