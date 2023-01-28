
module instrMEm(clk,pc_in,instruction);

input [31:0] pc_in;
input clk;
output wire[15:0] instruction;

reg[15:0] mem[(2**20)-1:0];

initial begin

//AND R3,R4
//mem[0]=16'b0010001110000000;
//ADD R1,R4
//mem[1]=16'b0000100110000000;
//RTI
//mem[2]=16'b11_110_000_000_00000;


//mem[2**5]=16'b00_001_010_010_00000;

///mem[2**5+1]=16'b11_011_000_000_00000;

//mem[2**5+2]=16'b0110100010000000;

//mem[2**5+3]=16'b00_001_011_011_00000;
//mem[2**5+4]=16'b00_001_011_011_00000;
//ret
//mem[2**5+5]=16'b11_101_000_000_00000;
//NOT R1
//mem[2**5+6]=16'b11_101_000_000_00000;
//STD R2,R1
//mem[2**5+7]=16'b0110100010000000;
//reset nop instruction

$readmemb("instructionMem.txt", mem,2**5,(2**20)-1);

$readmemb("isrMem.txt", mem,0,6);

end


	assign instruction=mem[pc_in];


endmodule