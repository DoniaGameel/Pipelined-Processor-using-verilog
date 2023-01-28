module flush_controller(unconditional_jump, jump, pc_to_stack, flush, rst, clk);
input unconditional_jump, jump, pc_to_stack, rst, clk;
output reg flush;
  
//states

localparam ready=3'b000;
localparam state1=3'b001;
localparam state2=3'b010;
localparam state3=3'b011;
localparam state4=3'b100;

//////////////

reg [1:0] state_reg,state_next;

always @(posedge clk)begin
	if(rst)begin
		state_reg=ready;
		flush=1'b0;
	end
	else 
		state_reg=state_next;
end

always @(*)begin
  case(state_reg)
		ready:
		begin
			if(jump || unconditional_jump) begin
				state_next=state3;
				flush=1'b1;
			end	
			else if(pc_to_stack) 
			begin
				state_next=state1;
				flush=1'b1;
			end
			else
			begin
				state_next=ready;
				flush=1'b0;
			end
		end	
  		state1:
		begin
			state_next=state2;
			flush=1'b1;
		end
		state2:
		begin
			state_next=state3;
			flush=1'b1;
		end
		state3:
		begin
			state_next=ready;
			flush=1'b0;
		end
		default:
		begin
			state_next=ready;
			flush=1'b0;
		end
	endcase	
end
endmodule