
module pc_control_unit(take_intr,reset,
current_pc,
next_pc,
popped_pc,interrupt_signal,
pop_signal,jump_signal,stall_signal,
jump_addr,pc_out_from_PC_CU
,
take_call,
stall_jump
);
input [31:0] current_pc,next_pc,popped_pc;
input [15:0]jump_addr;
input reset,take_intr,take_call,stall_jump;
input interrupt_signal,pop_signal,jump_signal,stall_signal;
output reg [31:0] pc_out_from_PC_CU;


always@(*)
begin
 if(reset)
	pc_out_from_PC_CU=32'b100000;
 else if(stall_signal)
     pc_out_from_PC_CU=current_pc;
else if(take_intr)
    pc_out_from_PC_CU=32'b0;
 else if(pop_signal)
    pc_out_from_PC_CU=popped_pc;
 else if(jump_signal)
    pc_out_from_PC_CU=jump_addr-1;
else if(take_call)
		pc_out_from_PC_CU=jump_addr;
    else if(stall_jump)
		pc_out_from_PC_CU=pc_out_from_PC_CU;
 else
     pc_out_from_PC_CU=next_pc;
        
end
endmodule 
