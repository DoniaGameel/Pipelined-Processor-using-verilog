module hazard_detection_unit(rst,clk,ID_EX_mem_read, ID_EX_register_dst, IF_ID_register_src1, IF_ID_register_src2, stall, enable);
input ID_EX_mem_read, enable,rst,clk;
input [2:0] ID_EX_register_dst, IF_ID_register_src1, IF_ID_register_src2;
output stall;




//assign stall = (enable && ID_EX_mem_read && (( ID_EX_register_dst == IF_ID_register_src1) || ( ID_EX_register_dst == IF_ID_register_src2)))? 1'b1 : 1'b0 ;
localparam ready=3'b000;
localparam state1=3'b001;
localparam state2=3'b010;	

reg [2:0] state_reg,state_next;


always @(posedge clk)begin
	if(rst)begin
		state_reg=ready;
		stall=0;
	end
	else 
		state_reg=state_next;
end

always @(*)begin
	case(state_reg)
		ready:
		begin
			if((enable && ID_EX_mem_read && (( ID_EX_register_dst == IF_ID_register_src1) || ( ID_EX_register_dst == IF_ID_register_src2)))) begin
				state_next=state1;
				stall=1;
				
			end	
			else 
			begin
				state_next=ready;
				stall=0;
			end
		end	
		state1:
		begin
			state_next=ready;
			stall=0;
		
		end		
		
		
		default:
		begin
			state_next=ready;
			stall=0;
		end
	endcase	
end

endmodule