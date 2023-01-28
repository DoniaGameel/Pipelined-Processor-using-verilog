module std_ldd_addr_mux(read_1_addr,read_2_addr,ldd_or_std,out_addr);
input [15:0] read_1_addr,read_2_addr;
input ldd_or_std;
output [15:0] out_addr;
assign out_addr=(ldd_or_std==0)?read_1_addr:read_2_addr;
endmodule
