module pc(pc_in,clk,rst,freeze_pc,INTR,pc_out);

input [31:0]pc_in;
input clk,rst,freeze_pc,INTR;
output reg[31:0] pc_out;
reg [31:0]pc_temp=32'b100000;



always@(negedge clk or rst)begin

	if(rst)begin
		pc_out=32'b100000;
		pc_temp=32'b100000;
	end
	else if(!freeze_pc)
		begin
			pc_out=pc_in;
		end
	else if(freeze_pc)
		pc_out=pc_in;
	else if(INTR)
		begin
			pc_out=32'b0;
			pc_temp=32'b0;
		end	
end


endmodule