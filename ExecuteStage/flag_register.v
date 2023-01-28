module flag_register(isNOP, rst,in_flags,en,clk,out_flags);
///////////////////////////////////
//*this module is used to reset flags in//
// the appropriate edge* and change their values//
//////////////////////////////////
input [4:0] isNOP;
input [2:0] in_flags; // input flags next phase
input rst,clk,en;//reset and clock
output reg [2:0] out_flags;

always@(negedge clk) begin // next phase
	if(en&&!rst&&isNOP!==5'b01010)
		out_flags=in_flags;
	//no else we need a latch بالفعل
end

always@(rst)begin //need to check it from TA
	out_flags= 3'b000;
end



endmodule
