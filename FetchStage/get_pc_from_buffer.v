
module get_pc_from_buffer(pc,clk,get_pc);


input [31:0]pc;
input clk;
output reg [31:0]get_pc;

always@(posedge clk)begin

	get_pc=pc;	

end

endmodule