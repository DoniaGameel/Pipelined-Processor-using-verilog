module pc_adder(
  pc_out, //output of PC module
  pc_adder_out //output of PC adder
  );

  input[31:0]pc_out;
  output reg[31:0]pc_adder_out;
  always @(pc_out)
  begin
    pc_adder_out = pc_out + 32'b1;
  end

endmodule