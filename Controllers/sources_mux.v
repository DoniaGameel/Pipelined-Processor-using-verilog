module sources_mux(rsrc,alu_out_IE_MEM,alu_out_MEM_WB,sel,out,imm,immediate,in_port_data,in_port_sig,alu_op);
	input[1:0] sel;
	input [3:0] alu_op;
	input imm,in_port_sig;
	input [15:0] rsrc,alu_out_IE_MEM,alu_out_MEM_WB,immediate,in_port_data;
	output [15:0]out ;
assign out=(in_port_sig==1'b1)?in_port_data:(imm==1'b1&&alu_op!=4'b1011&&alu_op!=4'b1100)?immediate:(sel==2'b00)?alu_out_IE_MEM:(sel==2'b01)?alu_out_MEM_WB:(sel==2'b10)?rsrc:rsrc;
endmodule