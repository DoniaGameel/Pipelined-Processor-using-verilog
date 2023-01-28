module hazard_detection_unit_controller_ch(clk,reset,out_sig,uncond_jump); 
input clk,reset,uncond_jump; 
output reg out_sig; 
 
 
//states 
localparam ready=2'b00; 
localparam state1=2'b01; 
localparam state2=2'b10; 
localparam state_end=2'b11; 
 
///////////////////// 
 
reg [1:0] state_reg,state_next; 
 
always @(posedge clk)begin 
 if(reset)begin 
  state_reg=ready; 
  out_sig=0; 
 end 
 else  
  state_reg=state_next; 
end 
 
always @(state_reg,uncond_jump)begin 
 case(state_reg) 
  ready: 
  begin
   
    state_next=state1; 
    
		end
  state1: 
  begin
	
    if(uncond_jump==1'b1)begin
		out_sig=1;
	end
   state_next=state2; 
   
  end   
  state2: 
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
