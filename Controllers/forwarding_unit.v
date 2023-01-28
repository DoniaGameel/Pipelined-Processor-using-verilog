
module forwarding_unit(clk,forwardA,forwardB,alu_out_IE_MEM,alu_out_MEM_WB,Rsrc1,Rsrc2,reg_write_MEM,reg_write_WB,en);
input reg_write_MEM,reg_write_WB,en,clk;
input [2:0] Rsrc1,Rsrc2;
input [2:0] alu_out_IE_MEM,alu_out_MEM_WB;
output reg [1:0]forwardA=2'b10; 
output reg [1:0]forwardB=2'b10; 

always @(*)
begin
	if(en)begin
  if (Rsrc1 == alu_out_IE_MEM && reg_write_MEM == 1)
      forwardA =2'b00;
   else if (Rsrc1 == alu_out_MEM_WB && reg_write_WB == 1)
      forwardA = 2'b01;
   else 
      forwardA = 2'b10;

   if (Rsrc2 == alu_out_IE_MEM && reg_write_MEM == 1)
      forwardB =2'b00;
   else if (Rsrc2 == alu_out_MEM_WB && reg_write_WB == 1)
      forwardB = 2'b01;
   else 
      forwardB = 2'b10;
	 end
		
end
endmodule