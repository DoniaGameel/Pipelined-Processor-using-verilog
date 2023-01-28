module memory_stage(mem_read,mem_write,clk,rst,stack_or_data,alu_address,input_data,rti_pop,ret_pop,mem_write_int,pc_to_stack_int,out_data,is_pop_buff2);

input mem_read, mem_write,clk,rst,stack_or_data,rti_pop,ret_pop, pc_to_stack_int, mem_write_int;
//adress souece
input [15:0] alu_address;
//data sources
input [15:0] input_data;
//memory output
output [15:0] out_data;
input [4:0]is_pop_buff2;

reg [15:0] Memory [0:2**11-1];
wire [15:0]mem_address;

wire [31:0] sp_address;
wire [31:0] modified_sp;
wire [31:0] sp;

always@(rst)begin
	Memory[0]=16'b0000_0000_1111_1000;
	Memory[1]=16'b0000_0000_1111_1010;
	Memory[2]=16'b0000_0000_1111_1011;
	Memory[3]=16'b0000_0000_1111_1111;
	Memory[15]=16'b0000_0000_0000_0000;
	Memory[16]=16'b0000_0000_1111_1111;

end

stack_handler shanfing_sp(sp,mem_write,mem_write_int,mem_read,rti_pop,ret_pop,sp_address,modified_sp,is_pop_buff2);
sp_mux sp_to_write(sp,modified_sp,stack_or_data,rti_pop,ret_pop,pc_to_stack_int,clk,rst,sp);
address_mux mem_address_selector(alu_address,sp,stack_or_data,rti_pop,ret_pop,pc_to_stack_int,mem_address);

assign out_data= Memory[mem_address[10:0]];

always@(posedge clk)
begin
if(mem_write)
 Memory[mem_address[10:0]]=input_data;
end

endmodule
