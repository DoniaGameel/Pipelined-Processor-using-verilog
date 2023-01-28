//`include "./flag_register.v"
//`include "./alu.v"
//`include "./mux1.v"

module execute_stage(
imm_rs2_sig,//choose whether load&store inst or arithematic
alu_op,//alu operation
clk,//clock
immediate,//immediate value used in load&store
rs1,rs2,//source 1,2
rst,//reset

execute_out,
flags_out
);

//declaring ports
input [15:0] rs1,rs2,immediate;
input clk,rst,imm_rs2_sig;

input [3:0] alu_op;
output reg[2:0] flags_out;
output reg [15:0] execute_out;
////////////////////

//intermediate connections 
wire[2:0] alu_out_flags;
reg [2:0] flags;
wire [15:0] alu_out;
///

wire [15:0]imm_rs2_mux_result;
always@(rst)begin
	flags_out=3'b00;
	execute_out=16'b0;
	
	
end
//choose immediate or rs2 
mux1 imm_rs2_mux(immediate,rs2,imm_rs2_sig,imm_rs2_mux_result);
//******************************

//alu stage
alu alu1(rst,alu_op,rs1,imm_rs2_mux_result,flags,alu_out,alu_out_flags);

//flag register
//flag_register flr(rst,alu_out_flags,1'b1,clk,flags);

assign execute_out=alu_out;
assign flags_out=(rst==0)?alu_out_flags:flags_out;

endmodule