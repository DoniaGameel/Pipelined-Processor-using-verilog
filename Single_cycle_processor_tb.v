//`include "processor.v"
module processor_tb();
reg clk,reset,freeze_pc;
//wires for fetch stage
wire [31:0]pc_out_from_pc;
wire [15:0]instr_from_mux;
wire [15:0] immediate;
/////////////

///////////////////////
//first buffer outputs
wire[31:0] pc_out_from_buff1;
wire [15:0] instr_out_from_buff1;
////////////////////////

/////////////////////
//wires for decode stage
//inputs
wire register_write_in;
wire [2:0]write_addr;
wire [15:0] write_data;
//outputs
wire [2:0]alu_op,jump_type;
wire register_write_out, alu_src, mem_write, mem_to_register, mem_read, branch,in_port,stack_or_data,pc_to_stack,inc_dec_sp,imm,ldd_or_std; 
wire [15:0] read_data_1, read_data_2;
///////////////


//////////////
//buff2 outputs
wire [2:0] alu_op_buff2,jump_type_buff2,read_addr_1_buff2,read_addr_2_buff2;
wire register_write_buff2,alu_src_buff2,mem_write_buff2,mem_to_register_buff2,mem_read_buff2;
wire branch_buff2,in_port_buff2,stack_or_data_buff2,pc_to_stack_buff2,inc_dec_sp_buff2;
wire imm_buff2,ldd_or_std_buff2;
wire [15:0] immediate_buff2,read_data_1_buff2,read_data_2_buff2;

///////////////

//////////////
//wires for execute stage
wire [15:0] alu_out;
wire [2:0] flags_out;
/////////////


//////////////
//buff3 outputs
wire [2:0]jump_type_buff3,read_addr_buff3;
wire register_write_buff3,mem_write_buff3,mem_to_register_buff3,mem_read_buff3;
wire branch_buff3,in_port_buff3,stack_or_data_buff3,pc_to_stack_buff3,inc_dec_sp_buff3;
wire ldd_or_std_buff3;
wire [15:0] read_data_2_buff3,alu_out_buff3;
///////////////

//memory stage wires
wire [15:0] data_out_from_mem;

////

////////////
//buff4 outputs
wire [15:0] alu_out_buff4,data_out_buff4;
wire register_write_buff4,mem_to_register_buff4;
wire [2:0] write_addr_buff4;

////////////////////////////

//wb stage wires
wire [15:0] data_out_from_wb;
//



// fetch stage
instruction_fetch_stage fetch(clk,reset,freeze_pc,imm,pc_out_from_pc,instr_from_mux,immediate);
buffer buff1(1'b1,pc_out_from_pc,instr_from_mux,clk,reset,pc_out_from_buff1,instr_out_from_buff1);
/////

//decode stage
decode_stage dec(instr_out_from_buff1,
register_write_buff4,write_addr_buff4,alu_op,
register_write_out,alu_src,mem_write,
mem_to_register,mem_read,branch,jump_type,
in_port,stack_or_data,pc_to_stack,inc_dec_sp,
imm,ldd_or_std, data_out_from_wb, read_data_1, read_data_2, clk, reset);

ID_IE_buffer  buff2(instr_out_from_buff1[12:10] ,instr_out_from_buff1[9:7],
read_addr_1_buff2,read_addr_2_buff2,alu_op,register_write_out,alu_src,mem_write,mem_to_register,mem_read,
branch,jump_type,in_port,stack_or_data,pc_to_stack,inc_dec_sp,imm,ldd_or_std,read_data_1,read_data_2,
alu_op_buff2,register_write_buff2,alu_src_buff2,mem_write_buff2,mem_to_register_buff2,
mem_read_buff2,branch_buff2,jump_type_buff2,in_port_buff2,stack_or_data_buff2,
pc_to_stack_buff2,inc_dec_sp_buff2,imm_buff2,ldd_or_std_buff2,read_data_1_buff2,read_data_2_buff2,
immediate,immediate_buff2,
 clk
);
/////


//execute stage
execute_stage exe1(imm_buff2,alu_op_buff2,clk,immediate_buff2,read_data_1_buff2,read_data_2_buff2
,reset,alu_out,flags_out
);
	
IE_MEM_buffer buff3(register_write_buff2,mem_write_buff2,
mem_to_register_buff2,mem_read_buff2,branch_buff2,jump_type_buff2,in_port_buff2,
stack_or_data_buff2,pc_to_stack_buff2,inc_dec_sp_buff2,ldd_or_std_buff2,read_data_2_buff2,
register_write_buff3,mem_write_buff3,mem_to_register_buff3,mem_read_buff3,
branch_buff3,jump_type_buff3,in_port_buff3,stack_or_data_buff3,pc_to_stack_buff3,
inc_dec_sp_buff3,ldd_or_std_buff3,read_data_2_buff3,alu_out,alu_out_buff3,
read_addr_1_buff2,read_addr_buff3
,clk
);
//////////////

//memory stage
memory_stage memo1(mem_read_buff3,mem_write_buff3,alu_out_buff3,data_out_from_mem,read_addr_buff3,read_addr_buff3,clk);

MEM_WB_buffer buff4(alu_out_buff3,data_out_buff4,
register_write_buff3,mem_to_register_buff3,in_port_buff3
,read_addr_buff3,register_write_buff4,mem_to_register_buff4,in_port_buff4,write_addr_buff4,
alu_out_buff4,data_out_buff4,clk
);

////////////
///wb stage
write_back_stage wb(data_out_buff4,alu_out_buff4,mem_to_register_buff4,data_out_from_wb);
////
  always
  #50 clk=~clk;
  initial begin
    clk = 1;
    reset = 1;
    freeze_pc = 1;
    #100
    reset = 0;
    
    freeze_pc = 0;
    #200
    freeze_pc=1;
    #300
    
    freeze_pc = 0;
    #200
    freeze_pc=1;
    #300;
    
    freeze_pc = 0;
    #100
    freeze_pc=1;
    #400;
    
    freeze_pc = 0;
    #100
    freeze_pc=1;
    #400;
    
    freeze_pc = 0;
    #100
    freeze_pc=1; 
    #400;
    
    freeze_pc = 0;
    #100
    freeze_pc=1;
    #400;
    
    freeze_pc = 0;
    #100
    freeze_pc=1;
    #400;
    
    freeze_pc = 0;
    #100
    freeze_pc=1;
    #400;
    #400;
    
    freeze_pc = 0;
    #100
    freeze_pc=1;
    #400;
    
  end
endmodule
  