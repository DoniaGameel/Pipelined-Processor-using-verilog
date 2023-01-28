module flags_mux(in1,in2,sel,out);
input [2:0] in1,in2;
input sel;
output [2:0] out;
assign out=(sel==1'b0)?in1:in2;


endmodule
