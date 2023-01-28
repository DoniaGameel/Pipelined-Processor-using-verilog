
module MEM_WB_buffer(reset,ret_in,ret_out, read_addr_2_in,read_addr_2_out, pc_to_stack_in,pc_to_stack_out,mem_read_in,mem_read_out, pc_l_in,pc_l_out, alu_out_in,data_mem_in, register_write_in,mem_to_register_in,in_port_in,write_addr_in,write_pc_rti_in,write_pc_ret_in,write_flags_in, register_write_out,mem_to_register_out,in_port_out,write_addr_out, alu_out_out,data_mem_out,clk,write_pc_rti_out,write_pc_ret_out,write_flags_out,pop_segment_rti,pop_segment_ret,pc_h,pc_l,flags_out,IN_PORT_in,IN_PORT_out);
  input [2:0] write_addr_in,read_addr_2_in;
  input register_write_in,reset,ret_in,mem_to_register_in,in_port_in,clk,pc_to_stack_in,mem_read_in,write_pc_rti_in,write_pc_ret_in,write_flags_in; 
  input [15:0]  alu_out_in,data_mem_in,pc_l_in,IN_PORT_in;
  input [1:0] pop_segment_rti;
  input [1:0] pop_segment_ret;
  output reg [2:0]  write_addr_out,read_addr_2_out;    
  output reg ret_out,register_write_out,mem_to_register_out,in_port_out,pc_to_stack_out,mem_read_out,write_pc_rti_out,write_pc_ret_out,write_flags_out;
  output reg [15:0]  data_mem_out,alu_out_out,pc_l_out,pc_h,pc_l,IN_PORT_out;
  output reg [2:0] flags_out;
 
  always@(posedge clk) begin
  if(reset)begin
  IN_PORT_out=0;
    register_write_out = 0;
    ret_out=0;
    read_addr_2_out=0;
    mem_to_register_out = 0;
    
    pc_to_stack_out=0;
    mem_read_out=0;
    in_port_out = 0;
   
    alu_out_out=0;
    write_addr_out=0;
    data_mem_out=0;
    pc_l_out=0;
    //when write_flags_out=1 ==> pop flags in flags register
    write_flags_out=0;
    //when write_pc_rti_out=1 || write_pc_ret_out=1==> pop pc
    write_pc_rti_out=0;
    write_pc_ret_out=0;
    
    flags_out=0;
	  pc_l=0;
	  pc_h=0;
  end
  else begin
  IN_PORT_out=IN_PORT_in;
    register_write_out = register_write_in;
    ret_out=ret_in;
    read_addr_2_out=read_addr_2_in;
    mem_to_register_out = mem_to_register_in;
    
    pc_to_stack_out=pc_to_stack_in;
    mem_read_out=mem_read_in;
    in_port_out = in_port_in;
   
    alu_out_out=alu_out_in;
    write_addr_out=write_addr_in;
    data_mem_out=data_mem_in;
    pc_l_out=pc_l_in;
    //when write_flags_out=1 ==> pop flags in flags register
    write_flags_out=write_flags_in;
    //when write_pc_rti_out=1 || write_pc_ret_out=1==> pop pc
    write_pc_rti_out=write_pc_rti_in;
    write_pc_ret_out=write_pc_ret_in;

   case(pop_segment_rti)
	2'b01:flags_out=data_mem_in[2:0];
	2'b10:pc_l=data_mem_in;
	2'b11:pc_h=data_mem_in;
   endcase

   case(pop_segment_ret)
	2'b10:pc_l=data_mem_in;
	2'b11:pc_h=data_mem_in;
   endcase
    end
  end
endmodule