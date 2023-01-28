module address_mux(alu_adress,sp_adress,stack_or_data,rti_pop,ret_pop,pc_to_stack_int,adress_out);
input [15:0] alu_adress;
input [31:0] sp_adress;
input stack_or_data,rti_pop,ret_pop,pc_to_stack_int;
output [15:0] adress_out;

wire [15:0]extendedAluAdress;
assign extendedAluAdress={alu_adress};
assign adress_out=(stack_or_data==0 || ret_pop==1 ||rti_pop==1 || pc_to_stack_int==1)
				?sp_adress[15:0]
				:extendedAluAdress;

endmodule
