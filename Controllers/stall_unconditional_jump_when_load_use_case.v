module stall_unconditional_jump_when_load_use_case (stall, unconditional_jump, stall_out, clk, rst,take_jmp,stall_jump,nop);
  input stall, unconditional_jump, clk, rst;
  output reg stall_out,take_jmp,stall_jump,nop;
  

localparam ready=2'b00;
localparam state1=2'b01;
localparam state2=2'b10;
localparam state3=2'b11;
reg [1:0] state_reg;
reg [1:0] state_next;

always @(posedge clk)begin
	if(rst)begin
		state_reg=ready;
		stall_out=1'b0;
		take_jmp=0;
		stall_jump=0;
		nop=0;
	end
	else 
		state_reg=state_next;
end


 
always @(state_reg, stall, unconditional_jump)begin 
 case(state_reg) 
  ready: 
   if(stall == 1'b1 && unconditional_jump == 1'b1 ) begin
      state_next=state1; 
      stall_out=1'b1;
  end
  else
	begin
		state_next=ready;
		stall_out = 1'b0;
		   stall_jump=1'b0;
	nop=0;
	end
    
  state1: 
  begin 
   state_next=state2; 
   stall_out=1'b0;
   take_jmp=1'b1;
   nop=1;
  end   
  state2: 
  begin  
   state_next=ready; 
   stall_out=1'b0;
   stall_jump=1'b1;
    take_jmp=1'b0;
	nop=0;
  end  

  default: 
  begin 
   state_next=ready; 
    
  end 
 endcase  
end 
endmodule

