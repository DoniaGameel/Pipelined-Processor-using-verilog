module sp_mux(old_sp,modified_sp,stack_or_data,rti_pop,ret_pop,pc_to_stack_int,clk,rst,new_sp);
input [31:0] old_sp;
input [31:0] modified_sp;
input stack_or_data,pc_to_stack_int,rti_pop,ret_pop,clk,rst;
output reg[31:0] new_sp;


always@(posedge rst)begin //need to check it from TA
	new_sp= 32'b0000_0000_0000_0000_0000_0000_0000_1000;
end

always@(posedge clk) begin 
	if(!rst)
		new_sp=(stack_or_data==0 || ret_pop==1 ||rti_pop==1|| pc_to_stack_int==1)
				?modified_sp
				:old_sp;
	else
		new_sp= 32'b0000_0000_0000_0000_0000_0000_0000_1000;
end
endmodule
