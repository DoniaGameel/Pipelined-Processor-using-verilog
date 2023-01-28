module flush_mux(jump_sign, control_signals_in, control_signals_out);
	input jump_sign;
	input [19:0] control_signals_in;
	output [19:0] control_signals_out;
assign control_signals_out = jump_sign? 20'b0 : control_signals_in;
endmodule