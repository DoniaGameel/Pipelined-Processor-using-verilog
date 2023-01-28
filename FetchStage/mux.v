module mux(reset,instr,sel,nop,instr_out);

input [15:0] instr,nop;
input sel,reset;
output [15:0] instr_out;


assign instr_out=(reset==1'b1)?16'b01_010_000_000_0_0000:(sel==1'b0)?instr:nop;

endmodule