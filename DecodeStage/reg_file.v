module reg_file (read_addr_1, read_addr_2,register_write, write_addr, write_data, read_data_1, read_data_2, clk, reset);
  input [2:0] read_addr_1, read_addr_2, write_addr;
  input register_write, clk, reset;
  input [15:0] write_data;
  output reg [15:0] read_data_1, read_data_2;
  integer i;
  //registers declaration : array has Eight 16-bit general purpose registers
    reg [15:0] array_reg [7:0];
	
  //reset
    always@(posedge reset)begin
       //for (i = 0; i < 8; i = i + 1) begin
         // array_reg[i] = 0; 
		array_reg[0]=16'b0001_1111_1111_1100;
		array_reg[1]=16'b0000_0000_0000_0000;
		array_reg[2]=16'b0000_0000_0010_1010;
		array_reg[3]=16'b0000_0000_0011_0100;
		array_reg[7]=16'b0000_0000_0011_1110;
   // end 
  end
  //write operation
    always@(posedge clk) begin
      if(register_write && !reset)
        array_reg[write_addr] = write_data;
    end
  //read operation
    always@(negedge clk) begin
      if(!reset)begin
        read_data_1 = array_reg[read_addr_1];
        read_data_2 = array_reg[read_addr_2];
      end
    end
endmodule