
module check_imm_circuit(check_bit,out_sig);

input check_bit;
output out_sig;
assign out_sig=(check_bit==1'b1)?1'b1:1'b0;

endmodule