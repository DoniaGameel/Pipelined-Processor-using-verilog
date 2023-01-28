//`include "../FetchStFage/fetch_stage.v"
//`include "../FetchStage/buffer.v"
//`include "../FetchStage/check_imm_circuit.v"
//`include "../DecodeStage/decode_stage.v"
//`include "../DecodeStage/ID_IE_buffer.v"
//`include "../ExecuteStage/execute_stage.v"
//`include "../MemoryStage/memory_stage.v"
//`include "../WriteBackStage/write_back_stage.v"
//`include "../MemoryStage/MEM_WB_buffer.v"

//`include "../ExecuteStage/IE_MEM_buffer.v"
module processor(clk,reset,INTR,IN_PORT);
input clk,reset,INTR;
input [15:0] IN_PORT;

////in port wires

//wire [15:0]IN_PORT=16'b0000_0000_0000_0000;
wire [15:0]IN_PORT_buffer1;
wire [15:0]IN_PORT_buffer2;
wire [15:0]IN_PORT_buffer3;
wire [15:0]IN_PORT_buffer4;
//////////////////////////////////



////////////////////////
//wires for fetch stage
wire [31:0]pc_out_from_pc;
wire [15:0]instr_from_mux;
wire [15:0] immediate;
wire [31:0] next_pc_out_from_fetch;
wire freeze_pc;
wire imm_mux;
wire write_popped_pc;
/////////////

///////////////////////
//first buffer outputs
wire[31:0] pc_out_from_buff1;
wire [15:0] instr_out_from_buff1;
wire [31:0] final_pc_out_from_buff1;
////////////////////////

/////////////////////
//wires for decode stage
//inputs
wire [2:0]write_addr;
wire [15:0] write_data;
//outputs
wire [3:0] alu_op;
wire [1:0] jump_type;
wire register_write_out, alu_src, mem_write, mem_to_register, mem_read, in_port, stack_or_data, pc_to_stack, inc_dec_sp, imm,ldd_or_std, unconditional_jump, ret,rti,call; 
wire [15:0] read_data_1, read_data_2;
///////////////
wire [3:0] alu_op_flush_mux_out;
wire [1:0] jump_type_flush_mux_out;
wire alu_src_flush_mux_out, mem_write_flush_mux_out, mem_to_register_flush_mux_out, mem_read_flush_mux_out,in_port_flush_mux_out, stack_or_data_flush_mux_out, pc_to_stack_flush_mux_out, inc_dec_sp_flush_mux_out, imm_flush_mux_out,ldd_or_std_flush_mux_out,ret_flush_mux_out,rti_flush_mux_out,call_flush_mux_out,register_write_flush_mux_out; 

//////////////
//buff2 outputs
wire [3:0] alu_op_buff2;
wire [1:0] jump_type_buff2;
wire [2:0] read_addr_1_buff2,read_addr_2_buff2;
wire register_write_buff2,alu_src_buff2,mem_write_buff2,mem_to_register_buff2,mem_read_buff2;
wire branch_buff2,in_port_buff2,stack_or_data_buff2,pc_to_stack_buff2,inc_dec_sp_buff2;
wire imm_buff2,ldd_or_std_buff2;
wire ret_buff2,rti_buff2,call_buff2;
wire [15:0] immediate_buff2,read_data_1_buff2,read_data_2_buff2,read_data_1_mux;
wire [31:0] pc_out_from_buff2;
///////////////

//////////////
//wires for execute stage
wire [15:0] alu_out;
wire [2:0] flags_out;
/////////////

//////////
//wires for flag register
wire [2:0] OUT_FLAGS_FROM_FLAG_REGISTER;
wire [2:0] out_flags_from_flags_mux;
/////

//jdu wires
wire jump_sign;
wire [2:0] jdu_out_flags;
//


//////////////
//buff3 outputs
wire [1:0] jump_type_buff3;
wire [2:0]read_addr_1_buff3,read_addr_2_buff3;
wire register_write_buff3,mem_write_buff3,mem_to_register_buff3,mem_read_buff3;
wire branch_buff3,in_port_buff3,stack_or_data_buff3,pc_to_stack_buff3,inc_dec_sp_buff3;
wire ldd_or_std_buff3;
wire [15:0] read_data_2_buff3,alu_out_buff3;
wire [31:0] pc_out_from_buff3;
wire [2:0] flags_out_from_buff3;
wire ret_buff3,rti_buff3;
///////////////

//memory stage wires
wire [15:0] data_out_from_mem;
wire mem_write_to_mem;
wire pc_to_stack_mem_in;
wire [15:0] data_out_from_mux;
////


//buff4 outputs
wire pc_to_stack_buff4,mem_read_buff4;
wire [15:0] alu_out_buff4,data_out_buff4,pc_l_from_buff4;
wire register_write_buff4,mem_to_register_buff4;
wire [2:0] write_addr_buff4,read_addr_2_buff4;
wire write_pc_rti_out,write_pc_ret_out,write_flags_out;
wire [15:0] pc_h_from_wb;
wire [15:0] pc_l_from_wb;
wire [2:0]flags_out_from_buff4;
////////////////////////////
//memory controller signals
wire write_pc_ret,write_pc_rti,write_flags,rti_pop,ret_pop;
wire [1:0] pop_segment_ret;
wire [1:0] pop_segment_rti;
wire [2:0] flags_out_from_mux_rti;
wire inc_popped_pc;
/////////
//wb stage wires
wire [15:0] data_out_from_wb;
//

/////
///interrupt_controller wires
wire nop_signal_from_intr,mem_write_from_ic,pc_to_stack_from_ic,flush_buff2_from_ic,flush_buff2;
wire [1:0] pc_segment;
wire take_intr_from_ic;
wire imm_indicator;
//////
////
//call controller wires
wire take_call_pc,freeze_pc_from_call;
wire nop_signal_from_call,mem_write_from_call,pc_to_stack_from_call,flush_buff2_from_call;
wire final_freeze_pc;
wire [1:0] final_pc_segment,pc_segment_from_call;
wire [15:0] pc_h_final,pc_l_final;
/////
///interrupt delayer wires
wire Oh_INTR;
wire nop_from_ret_case_of_intr_after_call;

//
//suj luc wires
wire take_jmp_pc_from_suj_luc;
//

/////////
//fu muxes wires
wire [15:0] out_from_mux_1_before_alu,out_from_mux_2_before_alu;
////


//////
// interrupt producer wires
wire OUT_INTR_FROM_PRODUCER;
///
/////
///interrupt delayer wires
wire OUT_INTR_FROM_DELAYER;
///
/////
///flush controller wires
wire flush;
//////


/////
///hazard detection unit wires
wire stall;
wire stall2;
wire out_from_hazard_controller;
//////

wire [15:0] read_data_1_buff3;


/////////
//temp wires for instr
wire [15:0] instr_out_from_buff2,instr_out_from_buff3;
///////////////////////////////

///forwarding unit wires
wire [1:0] forwardA,forwardB;
wire arth,arth_buff2,arth_buff3;
wire [15:0]final_read_2_data_buff2;
////////////////////////////

//temp wires for popped pc
wire [31:0] popped_pc_temp,popped_pc_after_imm_check,final_popped_pc;
wire [15:0] final_jump_addr;
wire [15:0] final_jump_addr_after_ldd_jmp, final_jump_after_unconcheck;
wire stall_jump;
wire nop_from_luc;
//

assign popped_pc_after_imm_check=(inc_popped_pc==1'b1)?popped_pc_temp+1:popped_pc_temp;
assign final_popped_pc=(write_pc_ret==1'b1)?popped_pc_after_imm_check-1:popped_pc_after_imm_check;
assign final_jump_addr=(take_call_pc==1'b1)?out_from_mux_1_before_alu-1:out_from_mux_1_before_alu;
 assign final_jump_addr_after_ldd_jmp=(take_jmp_pc_from_suj_luc==1'b1)?read_data_1_mux:final_jump_addr;
wire freeze_from_call;
assign final_jump_after_unconcheck= (unconditional_jump==1'b1)?read_data_1:final_jump_addr_after_ldd_jmp;
// fetch stage
instruction_fetch_stage fetch(take_intr_from_ic, OUT_INTR_FROM_DELAYER ,clk ,reset ,final_freeze_pc, imm_mux, pc_out_from_pc, next_pc_out_from_fetch, instr_from_mux ,immediate, jump_sign||take_jmp_pc_from_suj_luc,stall,pc_to_stack_buff4,mem_read_buff4,final_popped_pc,final_jump_after_unconcheck,write_popped_pc,take_call_pc,stall_jump||freeze_from_call);
assign final_pc_out_from_buff1=(unconditional_jump&&!jump_sign&&INTR)?{16'b0,read_data_1_mux}:(!unconditional_jump&&jump_sign&&INTR)?{16'b0,final_jump_addr}:pc_out_from_pc;

buffer buff1( stall||stall2 ,1'b1,final_pc_out_from_buff1,instr_from_mux,clk,reset,pc_out_from_buff1,instr_out_from_buff1,flush,IN_PORT,IN_PORT_buffer1);
/////

//decode stage
decode_stage dec(instr_out_from_buff1,
register_write_buff4,read_addr_2_buff4,alu_op,
register_write_out,alu_src,mem_write,
mem_to_register,mem_read,jump_type,
in_port,stack_or_data,pc_to_stack,inc_dec_sp,
imm,ldd_or_std, data_out_from_wb, read_data_1,
 read_data_2, ret,rti,call, clk, reset,unconditional_jump,arth);


assign flush_buff2=jump_sign || flush_buff2_from_ic||flush_buff2_from_call;
flush_mux fm(flush_buff2, { alu_src,mem_write,
mem_to_register,mem_read,jump_type,
in_port,stack_or_data,pc_to_stack,inc_dec_sp,
imm,ldd_or_std, ret,rti,call, register_write_out,alu_op}, {
alu_src_flush_mux_out, mem_write_flush_mux_out, mem_to_register_flush_mux_out, mem_read_flush_mux_out,jump_type_flush_mux_out, in_port_flush_mux_out, stack_or_data_flush_mux_out, pc_to_stack_flush_mux_out, inc_dec_sp_flush_mux_out, imm_flush_mux_out,ldd_or_std_flush_mux_out,ret_flush_mux_out,rti_flush_mux_out,call_flush_mux_out,register_write_flush_mux_out,alu_op_flush_mux_out});

assign read_data_1_mux = (stall2==1'b1)?data_out_from_mem:read_data_1;
ID_IE_buffer  buff2( stall||stall2,reset,instr_out_from_buff1,instr_out_from_buff2, pc_out_from_buff1,pc_out_from_buff2,  instr_out_from_buff1[10:8] ,instr_out_from_buff1[7:5],
read_addr_1_buff2,read_addr_2_buff2,alu_op_flush_mux_out,register_write_flush_mux_out,alu_src_flush_mux_out,mem_write_flush_mux_out,mem_to_register_flush_mux_out,mem_read_flush_mux_out,

jump_type_flush_mux_out,in_port_flush_mux_out,stack_or_data_flush_mux_out,pc_to_stack_flush_mux_out,inc_dec_sp_flush_mux_out,imm_flush_mux_out,ldd_or_std_flush_mux_out,ret_flush_mux_out,rti_flush_mux_out,call_flush_mux_out,
read_data_1_mux,read_data_2,
alu_op_buff2,register_write_buff2,alu_src_buff2,mem_write_buff2,mem_to_register_buff2,
mem_read_buff2,jump_type_buff2,in_port_buff2,stack_or_data_buff2,
pc_to_stack_buff2,inc_dec_sp_buff2,imm_buff2,ldd_or_std_buff2,ret_buff2,rti_buff2,call_buff2,read_data_1_buff2,read_data_2_buff2,
immediate,immediate_buff2,
clk,IN_PORT_buffer1,IN_PORT_buffer2,arth,arth_buff2
);
/////




//execute stage
execute_stage exe1(imm_buff2,alu_op_buff2,clk,immediate_buff2,out_from_mux_1_before_alu,out_from_mux_2_before_alu
,reset,alu_out,flags_out
);
flags_mux fmux(flags_out,jdu_out_flags,jump_sign,out_flags_from_flags_mux);
flags_mux fmux2(out_flags_from_flags_mux,flags_out_from_buff4,write_flags_out,flags_out_from_mux_rti);
flag_register fr(instr_out_from_buff2[15:11],reset,flags_out_from_mux_rti,1'b1,clk,OUT_FLAGS_FROM_FLAG_REGISTER);	

assign final_read_2_data_buff2=(instr_out_from_buff2[15:11]==5'b10100&&forwardB==2'b00)?data_out_from_mem:read_data_2_buff2;
IE_MEM_buffer buff3(reset,ret_buff2,ret_buff3, read_addr_2_buff2,read_addr_2_buff3, OUT_FLAGS_FROM_FLAG_REGISTER,flags_out_from_buff3, instr_out_from_buff2,instr_out_from_buff3, pc_out_from_buff2,pc_out_from_buff3, register_write_buff2,mem_write_buff2,
mem_to_register_buff2,mem_read_buff2,branch_buff2,jump_type_buff2,in_port_buff2,
stack_or_data_buff2,pc_to_stack_buff2,inc_dec_sp_buff2,ldd_or_std_buff2,final_read_2_data_buff2,
register_write_buff3,mem_write_buff3,mem_to_register_buff3,mem_read_buff3,
branch_buff3,jump_type_buff3,in_port_buff3,stack_or_data_buff3,pc_to_stack_buff3,
inc_dec_sp_buff3,ldd_or_std_buff3,read_data_2_buff3,alu_out,alu_out_buff3,
read_addr_1_buff2,read_addr_1_buff3
,clk,IN_PORT_buffer2,IN_PORT_buffer3,arth_buff2,arth_buff3,read_data_1_buff2,read_data_1_buff3
);
//////////////
///jdu

jdu jdu1(reset,jump_type_buff2,OUT_FLAGS_FROM_FLAG_REGISTER,jump_sign,jdu_out_flags);

///

//
stall_unconditional_jump_when_load_use_case suj_luc(stall, unconditional_jump, stall2, clk, reset,take_jmp_pc_from_suj_luc,stall_jump,nop_from_luc);
///
///wire for this mux
wire [15:0] out_addr;
std_ldd_addr_mux addr_mux_mem(read_data_1_buff3,read_data_2_buff3,ldd_or_std_buff3,out_addr);

//memory stage
memory_stage memo1(mem_read_buff3,mem_write_to_mem,clk,reset,stack_or_data_buff3,out_addr,data_out_from_mux,rti_pop,ret_pop,mem_write_from_ic,pc_to_stack_from_ic,data_out_from_mem,instr_out_from_buff2[15:11]);

assign pc_to_stack_mem_in=pc_to_stack_buff3||pc_to_stack_from_ic||pc_to_stack_from_call;
assign final_pc_segment=(mem_write_from_call)?pc_segment_from_call:pc_segment;
assign pc_l_final=(mem_write_from_call==1'b1)?pc_l_from_buff4+1:pc_l_from_buff4;
data_mux datamx(flags_out_from_buff3,pc_out_from_buff3[31:16],pc_l_final,alu_out_buff3,pc_to_stack_mem_in,final_pc_segment,data_out_from_mux);

assign popped_pc_temp={pc_h_from_wb,pc_l_from_wb};

MEM_WB_buffer buff4(reset,ret_buff3,ret_buff4,read_addr_2_buff3,read_addr_2_buff4, pc_to_stack_buff3,pc_to_stack_buff4,
mem_read_buff3,mem_read_buff4,
pc_out_from_buff3[15:0],pc_l_from_buff4,  alu_out_buff3,data_out_from_mem,
register_write_buff3,mem_to_register_buff3,in_port_buff3
,read_addr_1_buff3,
write_pc_rti,write_pc_ret,write_flags,
register_write_buff4,mem_to_register_buff4,in_port_buff4,
write_addr_buff4,
alu_out_buff4,data_out_buff4,
clk,write_pc_rti_out,write_pc_ret_out,write_flags_out,
pop_segment_rti,pop_segment_ret,pc_h_from_wb,pc_l_from_wb,flags_out_from_buff4,IN_PORT_buffer3,IN_PORT_buffer4
);
////////////
///wb stage
write_back_stage wb(data_out_buff4,alu_out_buff4,IN_PORT_buffer4,in_port_buff4,mem_to_register_buff4,data_out_from_wb);
////
assign write_popped_pc=write_pc_ret||write_pc_rti;
ret_controller_ch ret_cont(INTR,clk,reset,ret,pop_segment_ret,write_pc_ret,ret_pop,Oh_INTR,OUT_INTR_FROM_DELAYER,nop_from_ret_case_of_intr_after_call);
rti_controller rti_controller(clk,reset,rti,pop_segment_rti,write_pc_rti,write_flags,rti_pop,imm_indicator,inc_popped_pc);

/////
assign imm_mux=imm||nop_signal_from_intr||nop_signal_from_call||nop_from_ret_case_of_intr_after_call||nop_from_luc;
assign mem_write_to_mem=mem_write_buff3 || mem_write_from_ic||mem_write_from_call;
assign final_freeze_pc=freeze_pc||freeze_pc_from_call;
interrupt_controller ic(clk,OUT_INTR_FROM_DELAYER,reset,mem_write_from_ic,nop_signal_from_intr,freeze_pc,pc_segment,pc_to_stack_from_ic,flush_buff2_from_ic,take_intr_from_ic,imm_buff2,imm_indicator);
///
///call controler
call_controller call_cont(clk,call,reset,mem_write_from_call,nop_signal_from_call,freeze_pc_from_call,pc_segment_from_call,pc_to_stack_from_call,flush_buff2_from_call,take_call_pc,imm_buff2,imm_indicator,INTR,Oh_INTR,instr_from_mux[15:11],freeze_from_call);
///

////
flush_controller fc(call,unconditional_jump, jump_sign, pc_to_stack, flush, reset, clk);
///


//// hazard detection unit
hazard_detection_unit_controller_ch hduc2(clk,reset,out_from_hazard_controller,unconditional_jump); 
hazard_detection_unit hdu(reset,clk,mem_read_buff2, read_addr_2_buff2, instr_out_from_buff1[10:8], instr_out_from_buff1[7:5], stall,out_from_hazard_controller);
///

/// interrupt producer
wire tempRETI_BUFF4;
//interrupt_producer ip(reset,INTR,call_buff2,ret_buff4,OUT_INTR_FROM_PRODUCER);
///////
///interrupt delayer
//interrupt_delayer_imm id(reset,OUT_INTR_FROM_PRODUCER,imm,OUT_INTR_FROM_DELAYER	);
///////
//wires 
wire out_from_forward_unit_controller;
//forwarding_unit controller in beginning of the program
forwarding_unit_controller fuc(clk,reset,out_from_forward_unit_controller,arth_buff2,arth_buff3);
///////////////////
///FU
forwarding_unit fu(clk,forwardA,forwardB,read_addr_2_buff3,read_addr_2_buff4,read_addr_1_buff2,read_addr_2_buff2,register_write_buff3,register_write_buff4,out_from_forward_unit_controller);
/////////

///before alu muxes
sources_mux sm1(read_data_1_buff2,alu_out_buff3,alu_out_buff4,forwardA,out_from_mux_1_before_alu,imm_buff2,immediate_buff2,IN_PORT_buffer2,in_port_buff2,alu_op_buff2);
sources_mux sm2(read_data_2_buff2,alu_out_buff3,alu_out_buff4,forwardB,out_from_mux_2_before_alu,0,0,0,0,0);

///

///
wire [15:0] OUT_PORT=alu_out_buff4;
assign OUT_PORT=alu_out_buff4;


endmodule