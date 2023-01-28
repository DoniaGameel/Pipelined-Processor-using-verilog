module interrupt_controller(clk,INTR,rst,mem_write,nop_signal,freeze_pc,pc_segment,pc_to_stack,flush,take_intr,imm,out_imm);
input clk,INTR,rst,imm;

output reg nop_signal,freeze_pc,flush,out_imm;
output reg mem_write,pc_to_stack,take_intr;
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
		take_intr=0;
		out_imm=0;
	end
	else 
		state_reg=state_next;
end

always @(state_reg,INTR)begin
	case(state_reg)
		ready:
		begin
			if(INTR) begin
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
				take_intr=0;
			end
		end	
		state1:
		begin
			state_next=state2;
		
		end		
		state2:
		begin	
			state_next=state3;
			flush=0;

			
		end	
		state3: //push_h
		begin
			state_next=push_pc_h;
			mem_write=1;
			pc_to_stack=1;
			pc_segment=2'b00;
			
			
		end
		push_pc_h: //push_l
		begin
			state_next=push_pc_l;
			pc_segment=2'b01;
			pc_to_stack=1;
			freeze_pc=0;
			nop_signal=0;
			take_intr=1;
			
		end
		push_pc_l: //push flags
		begin
			state_next=push_flags;
			pc_to_stack=1;
			pc_segment=2'b10;
			take_intr=0;
			//pc_to_stack=0;
			//mem_write=0;
		end
		push_flags:
		begin
			state_next=ready;
			pc_segment=0;
			pc_to_stack=0;
			mem_write=0;
			out_imm=1'b0;
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
