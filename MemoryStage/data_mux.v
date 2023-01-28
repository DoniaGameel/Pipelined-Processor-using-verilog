module data_mux(flags, pc_h,pc_l, alu_in,pc_to_stack_in,pc_segment,data_out);
    input [15:0] pc_h;
    input [15:0] pc_l;
    input [15:0] alu_in;
    input pc_to_stack_in;
    input [1:0]pc_segment;
    input [2:0]flags;
    output [15:0] data_out;

    wire [15:0] extendedFlags;


assign extendedFlags= {13'b0,flags};

assign data_out=
	(pc_to_stack_in==1'b0)?alu_in:
	(pc_to_stack_in==1'b1&&pc_segment==2'b00)?pc_h:
	(pc_to_stack_in==1'b1&&pc_segment==2'b01)?pc_l:
	(pc_to_stack_in==1'b1&&pc_segment==2'b10)?extendedFlags:
	alu_in;
endmodule