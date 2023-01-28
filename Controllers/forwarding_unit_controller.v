
module forwarding_unit_controller(clk,reset,out_sig,arth_buff2,arth_buff3);
input clk,reset,arth_buff2,arth_buff3;
output reg out_sig;


//states
localparam ready=3'b000;
localparam state1=3'b001;
localparam state2=3'b010;
localparam state3=3'b011;
localparam state_end=3'b100;

/////////////////////

reg [2:0] state_reg,state_next;

always @(posedge clk)begin
	if(reset)begin
		state_reg=ready;
		out_sig=0;
	end
	else 
		state_reg=state_next;
end

always @(state_reg)begin
	case(state_reg)
		ready:
		
				state_next=state1;
			
			
		state1:
		begin
			state_next=state2;
		
		end		
		state2:
		begin	
			state_next=state3;
			if(arth_buff2==1'b1&&arth_buff3==1'b1)
				out_sig=1;
		end	
		state3: 
		begin
			state_next=state_end;
			out_sig=1;
		end
		
		default:
		begin
			state_next=ready;
			
		end
	endcase	
end



endmodule
