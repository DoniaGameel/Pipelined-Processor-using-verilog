module ret_controller_ch(INTR,clk,rst,ret,pop_segment,write_pc,ret_pop,is_INTR,out_INTR,nop);
input clk,rst,ret,is_INTR,INTR;
output reg write_pc,ret_pop,out_INTR,nop;
output reg[1:0] pop_segment;

//states
localparam ready=3'b000;
localparam state1=3'b001;
localparam state2=3'b010;
localparam state3=3'b011;
localparam state4=3'b100;
localparam state5=3'b101;
localparam state6=3'b110;
localparam state7=3'b111;
//localparam push_flags=3'b110;
reg [2:0] state_reg;
reg [2:0] state_next;
reg go_INTR;
always @(posedge clk)begin
	if(rst)begin //initial state
		state_reg=ready;
		write_pc=1'b0;
		ret_pop=1'b0;
		out_INTR=0;
		pop_segment=2'b00;
		go_INTR=0;
		nop=0;
	end
	else 
		state_reg=state_next;
end

always @(state_reg,ret,is_INTR,INTR) begin
	case(state_reg)
		ready:
		begin
			if(is_INTR)begin
				go_INTR=1'b1;
			end
			else if(INTR)
			begin
				out_INTR=1'b1;
				state_next=state7;
			end	
			if(ret) begin
				state_next=state1;
				write_pc=1'b0;
				pop_segment=2'b00;
				ret_pop=1'b0;
				
			end	
			else 
			begin
				nop=0;
				if(!INTR)begin
					state_next=ready;
				end	
				write_pc=1'b0;
				pop_segment=2'b00;
				ret_pop=1'b0;
			end
		end
		state1:
		begin
			state_next=state2;
			write_pc=1'b0;
			pop_segment=2'b00;
			ret_pop=1'b0;
		end
		state2:
		begin
			//pop pc_h to MEM/WB buffer
			state_next=state3;
			write_pc=1'b0;
			pop_segment=2'b00;
			ret_pop=1'b1;
		end
		state3:
		begin
			//pop pc_h to MEM/WB buffer
			state_next=state4;
			write_pc=1'b0;
			pop_segment=2'b10;
			ret_pop=1'b1;
		end
		state4:
		begin
			//write back pc
			state_next=state5;
			write_pc=1'b1;
			pop_segment=2'b11;
			ret_pop=1'b0;
		end
		state5:
		begin
			//write back pc
			
			state_next=state6;
			write_pc=1'b0;
			if(go_INTR)
				nop=1;
		end
		state6:
		begin
			if(go_INTR)begin
				out_INTR=1'b1;
				go_INTR=0;
				
			end
			nop=0;

		state_next=state7;	
		end
		state7:
		begin
		out_INTR=0;
		//nop=0;
		state_next=ready;	
		end
		default:
		begin
			state_next=ready;
			write_pc=1'b0;
			pop_segment=2'b00;
			ret_pop=1'b0;
		end
	endcase
end
endmodule
