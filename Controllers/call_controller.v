module call_controller(clk,call,rst,mem_write,nop_signal,freeze_pc,pc_segment,pc_to_stack,flush,take_call_pc,imm,out_imm,INTR,Oh_INTR,is_call_from_buff_1,freeze);
input clk,call,rst,imm,INTR;
input [4:0]is_call_from_buff_1;
output reg nop_signal,freeze_pc,flush,out_imm;
output reg mem_write,pc_to_stack,take_call_pc,Oh_INTR,freeze;
output reg [1:0]pc_segment;




//states
localparam ready=3'b000;
localparam state1=3'b001;
localparam state2=3'b010;
localparam state3=3'b011;
localparam push_pc_h=3'b100;
localparam push_pc_l=3'b101;
localparam push_flags=3'b110;
//localparam push_flags=3'b110;

//////////////

reg [2:0] state_reg,state_next;

always @(posedge clk)begin
	if(rst)begin
		state_reg=ready;
		mem_write=0;
		nop_signal=0;
		freeze_pc=0;
		pc_segment=0;
		flush=0;
		pc_to_stack=0;
		take_call_pc=0;
		out_imm=0;
		Oh_INTR=0;
		freeze=0;
	end
	else 
		state_reg=state_next;
end

always @(state_reg,call,INTR)begin
	case(state_reg)
		ready:
		begin
			if((call||is_call_from_buff_1==5'b11_100)&&INTR)begin
				Oh_INTR=1'b1;
			end
			else
				Oh_INTR=0;
			if(call) begin
				state_next=state1;
				freeze_pc=1;
				nop_signal=1;
				pc_to_stack=0;
				flush=1;
				if(imm)begin
					out_imm=1'b1;
				end
			end	
			else 
			begin
				state_next=ready;
				freeze_pc=0;
				nop_signal=0;
				mem_write=0;
				pc_to_stack=0;
				take_call_pc=0;
				if(!INTR)
					Oh_INTR=0;
			end
		end	
		state1:
		begin
			state_next=state2;
			Oh_INTR=1'b0;
			//if(INTR)
				//Oh_INTR=1'b1;
				
			flush=0;
			take_call_pc=1;
			freeze_pc=0;

		end		
		state2:
		begin	
			state_next=state3;
			//if(INTR)
				//Oh_INTR=1'b1;
			freeze_pc=0;
			nop_signal=0;
			mem_write=1;
			pc_to_stack=1;
			pc_segment=2'b00;
			take_call_pc=0;
			freeze=1;


		end	
		state3: //push_h
		begin
			state_next=push_pc_h;
			pc_segment=2'b01;
			pc_to_stack=1;
			//if(INTR)
				//Oh_INTR=1'b1;
			nop_signal=0;
			freeze=0;	

			
			
		end
		push_pc_h: //push_l
		begin
			//if(INTR)
				//Oh_INTR=1'b1;
			state_next=ready;
				pc_segment=0;
			pc_to_stack=0;
			mem_write=0;
			out_imm=1'b0;
			Oh_INTR=0;
			//pc_to_stack=0;
			//mem_write=0;
		end
		
		
		default:
		begin
			state_next=ready;
			mem_write=0;
			nop_signal=0;
			freeze_pc=0;
			pc_to_stack=0;
		end
	endcase	
end



endmodule
