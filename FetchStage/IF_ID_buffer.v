
module buffer(stall,en,pc,instr,clk,rst,pc_out,instr_out, flush,IN_PORT_in,IN_PORT_out);

input [31:0] pc;
input [15:0] instr,IN_PORT_in;
input clk,rst,en,flush,stall;
output reg [31:0] pc_out;
output reg[15:0] instr_out,IN_PORT_out;

always@(posedge clk)begin
	if(en) begin
	if(rst)begin
	  pc_out=31'b100000;
	  instr_out=16'b01_010_111_100_1_0000;
	  IN_PORT_out=0;
	end
	else if(flush)begin
	  instr_out=16'b0101000000000000;
	  	pc_out=pc;
		IN_PORT_out=0;
	end
	else if(!stall)
	begin
	pc_out=pc;
	instr_out=instr;
	IN_PORT_out=IN_PORT_in;
	end
end

end

endmodule 