module interrupt_delayer_imm_controller(clk,rst,INTR,imm,OUT_INTR);
input clk;

input INTR,imm,rst;
output reg OUT_INTR;

//states
localparam ready=3'b000;
localparam state1=3'b001;
localparam state2=3'b010;
localparam state3=3'b011;


reg activate_INTR;


reg [2:0] state_reg =state2;
reg [2:0] state_next;

always @(posedge clk)begin
	if(rst)begin
		OUT_INTR=0;
		state_next=ready;
		activate_INTR=0;
	end
	else begin
		if(imm&&INTR)begin
			state_reg=ready;
			activate_INTR=1'b1;
		end	
		else if(INTR==1'b1&&imm==1'b0)begin
			state_reg=state3;
			activate_INTR=1'b1;
			OUT_INTR=1'b1;
		end
			else
			state_reg=state_next;

	end
end

always @(state_reg,INTR)begin
	case(state_reg)
		ready:
		begin
			if(activate_INTR)begin
				state_next=state1;
				OUT_INTR=1;
				activate_INTR=0;
			end
			
			
		end	
		state1:
		begin
			state_next=ready;
			OUT_INTR=0;
		end		
		state2:
		begin	
			OUT_INTR=0;
			if(activate_INTR)
				state_next=ready;

			
		end	
		state3:
		begin	
			OUT_INTR=0;
			activate_INTR=0;
			state_next=ready;

			
		end	
		
		
		default:
		begin
			state_next=ready;
			OUT_INTR=0;
		end
	endcase	
end






//always@(imm)begin
//if(imm)
	//active_imm=1'b1;
//else
	//active_imm=1'b0;


//end


//assign OUT_INTR=(active_imm==1'b0&&activate_INTR==1'b1)?1'b1:1'b0;


//assign  activate_INTR=(INTR==1'b1)?1'b1
  //  :activate_INTR;
//assign  active_imm=(imm==1'b1)?1'b1:1'b0;

//always@(INTR)begin
//if(INTR)
//	activate_INTR=1'b1;
//else
	//activate_INTR=activate_INTR;
//end
//always@(active_imm,activate_INTR)begin
	//if(active_imm==1'b0&&activate_INTR==1'b1)begin
		//OUT_INTR=1'b1;
		//activate_INTR=1'b0;
	//	active_imm=1'b0; //nonsense statement but ok ^^
	//end
	//else
	//	OUT_INTR=1'b0;
//end



endmodule

