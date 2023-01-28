module jdu(reset,jump_type,in_flags,jmp_sign,out_flags);
input reset;
input [2:0] in_flags;
input [1:0] jump_type;
output reg[2:0] out_flags;
output reg jmp_sign;
wire zero_detector=0;
wire carry_detector=0;
wire negative_detector=0;
////to facilitate comparsions
//flags: zero flag:2,negative:1,carry:0
localparam JZ=2'b01;
localparam JC=2'b10;
localparam JN=2'b00;

////////////
always@(reset)begin
	if(reset)begin
		jmp_sign=1'b0;
		out_flags=3'b0;
	end
end


always@(*) begin
if(!reset)begin
jmp_sign=((jump_type==JZ&&in_flags[2]==1'b1)
				||(jump_type==JN&&in_flags[1]==1'b1)
				||(jump_type==JC&&in_flags[0]==1'b1))?1'b1:1'b0;
end
end
assign zero_detector=(jump_type==JZ&&in_flags[2]==1'b1&&!reset)?1'b0:in_flags[2];
assign carry_detector=(jump_type==JC&&in_flags[0]==1'b1&&!reset)?1'b0:in_flags[0];
assign negative_detector=(jump_type==JN&&in_flags[1]==1'b1&&!reset)?1'b0:in_flags[1];

assign out_flags=(reset==1'b0&&((jump_type==JZ&&in_flags[2]==1'b1)||(jump_type==JC&&in_flags[0]==1'b1)||(jump_type==JN&&in_flags[1]==1'b1)))?{zero_detector,negative_detector,carry_detector}:out_flags;


endmodule
