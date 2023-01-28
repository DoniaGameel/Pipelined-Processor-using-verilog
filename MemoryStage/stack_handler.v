module stack_handler(sp_in,mem_write,mem_write_int,mem_read,rti_pop,ret_pop,sp_address,modified_sp,is_pop_buff2);
input mem_write,mem_write_int,mem_read,rti_pop,ret_pop;
input [31:0] sp_in;
output [31:0] sp_address;
output [31:0] modified_sp;
input [4:0]is_pop_buff2;


assign sp_address=(mem_write==1 || mem_write_int==1)
				?sp_in-1
				:sp_in;
assign modified_sp=(mem_read==1 || ret_pop==1 ||rti_pop==1||is_pop_buff2==5'b10001)
				?sp_address+1
				:sp_address;
endmodule
