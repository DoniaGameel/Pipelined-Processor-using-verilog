module write_back_stage(memory_data, alu_data,IN_PORT,in_signal, mem_to_reg, data_to_reg);
  input [15:0] memory_data ,alu_data,IN_PORT;
  input mem_to_reg,in_signal;
  output reg [15:0] data_to_reg;
   
   
   assign data_to_reg=(in_signal==1'b1)?IN_PORT:(mem_to_reg==1'b0)?alu_data:memory_data;
   
//always@(*)
//begin
 // if(in_signal==1)
 //   data_to_reg=IN_PORT;
 // else if(mem_to_reg == 0)
  //  data_to_reg = alu_data;
 // else 
  //  data_to_reg = memory_data;
 // end
endmodule