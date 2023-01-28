
module alu(rst,op,rs1,rs2,in_flags,out,out_flags);

input [3:0]op;
input rst;
input [2:0]in_flags; //ALU-operation,input flags
input  [15:0] rs1,rs2;//16-bit the two outputs of decode stage. with one bit in msb extended
output wire [15:0]out;
output reg [2:0] out_flags;//zero flag:0,negative:1,carry:2
reg[16:0] temp_out,rs1_temp,rs2_temp;
reg zero_result_detector=0;
reg neg_result_detector=0;
reg carry_detector=0;

//const parameters (to facilitate the comparisons)
localparam [3:0] ADD=4'b0000;
//localparam [3:0] MOV=4'b0001;
localparam [3:0] SUB=4'b0010;
localparam [3:0] AND=4'b0011;
localparam [3:0] OR =4'b0100;
localparam [3:0] INC=4'b0101;
localparam [3:0] DEC=4'b0110;
localparam [3:0] NOT=4'b0111;
localparam [3:0] NOP=4'b1000;
localparam [3:0] SETC=4'b1001;
localparam [3:0] CLRC=4'b1010;
localparam [3:0] SHL=4'b1011;
localparam [3:0] SHR=4'b1100;
//localparam [2:0] NOP=3'b001;
//localparam [2:0] ADD=3'b011;
//localparam [2:0] NOT=3'b100;
//localparam [2:0] LDM=3'b111;


//

//always@(rst)begin
	//out_flags=3'b000;
//end

always@(*)begin

	rs1_temp={1'b0,rs1};
	rs2_temp={1'b0,rs2};
	if(op==ADD)begin 
		temp_out=rs1_temp+rs2_temp;	
	end
	else if(op==SUB)begin 
		temp_out=rs1_temp-rs2_temp;
	end
	//else if(op==MOV)begin 
		//temp_out=rs1_temp; 
	//end
	else if(op==AND)begin 
		temp_out=rs1_temp&rs2_temp; 
	end
	else if(op==OR)begin 
		temp_out=rs1_temp|rs2_temp; 
	end
	else if(op==INC)begin 
		temp_out=rs1_temp+1; 
	end
	else if(op==NOP)begin 
		temp_out=rs1_temp; 
	end
	//else if(op==LDM)begin
		//temp_out=rs2_temp; 

	//end
	else if(op==DEC)begin 
		temp_out=rs1_temp-1; 
	end
	else if(op==NOT)begin 
		temp_out=~rs1_temp; 
	end
	else if(op==SETC)begin 
		//out_flags[0]=1'b1;
		temp_out=17'b01;
	end
	else if(op==CLRC)begin 
		//out_flags[0]=1'b0;
		temp_out=17'b01;
		
	end
	else if(op==SHL)begin 
		temp_out=rs1_temp<<rs2_temp; //shift left rs1 by rs2 times. 
	end
	else if(op==SHR)begin 
		temp_out=rs1_temp>>rs2_temp; //shift right rs1 by rs2 times. 
	end
	else begin
		temp_out=rs1_temp+rs2_temp;	
		end
	zero_result_detector=(temp_out==17'b0)?1'b1:1'b0;
//
	neg_result_detector=(temp_out<0 ||temp_out[15]==1'b1)?1'b1:1'b0;
	carry_detector=(op!=NOT&&(op==SETC||temp_out[16]==1'b1||(op==SHR&&rs2<17&&rs1[rs2-1])||(op==SHL&&rs2<17&&rs1[16-rs2])))?1'b1:(op==CLRC)?1'b0:carry_detector;
	//carry_detector=(op==CLRC)?1'b0:carry_detector;
	//carry_detector=(temp_out[16]==1'b1)?1'b1:1'b0;

end

//assign out_flags[0]=(temp_out[15:0]==0)?1'b1:1'b0;
//assign out_flags[1]=(temp_out<16'b0)?1'b1:1'b0;
//assign out_flags[2]=(temp_out[16])?1'b1:1'b0;

//phase v3
//assign out_flags=(op==ADD||op==INC||op==SHL)?{zero_result_detector,neg_result_detector,carry_detector}
	//			:(op==NOP||op==MOV)?3'b000
		//		:(op==NOT||op==DEC||op==SUB)?{zero_result_detector,neg_result_detector,in_flags[0]}
			//	:(op==SETC||op==CLRC)?{2'b00,carry_detector}:in_flags;


//assign out_flags=(op==ADD)?{zero_result_detector,neg_result_detector,carry_detector}
	//			:(op==NOP)?3'b000
		//		:(op==NOT)?{zero_result_detector,neg_result_detector,in_flags[0]}
			//	:in_flags;
assign out_flags=(op==NOP)?out_flags:{zero_result_detector,neg_result_detector,carry_detector};
assign out=temp_out[15:0];
endmodule

//setc and clrc is in code
//shl and shr are handeled in code if zero or in case of shl handeled in if condition 