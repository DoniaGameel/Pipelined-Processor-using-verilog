module rti_controller(clk,rst,rti,pop_segment,write_pc,write_flags,rti_pop,imm,inc_pc);
input clk,rst,rti,imm;
output reg write_flags,write_pc,rti_pop,inc_pc;
output reg[1:0] pop_segment;

localparam ready=3'b000;
localparam state1=3'b001;
localparam state2=3'b010;
localparam state3=3'b011;
localparam state4=3'b100;
localparam state5=3'b101;
localparam state6=3'b110;
reg isImm;
reg [2:0] state_reg;
reg [2:0] state_next;

always @(posedge clk)begin
	if(rst)begin //initial state
		state_reg=ready;
		write_flags=1'b0;
		write_pc=1'b0;
		rti_pop=1'b0;
		pop_segment=2'b00;
		isImm=0;
		inc_pc=0;
	end
	else 
	begin
				if(imm)begin
					isImm=1;
				end
		state_reg=state_next;
	end
end

always @(state_reg,rti) begin
	case(state_reg)
		ready:
		begin
			if(rti) begin
				
				state_next=state1;
				write_flags=1'b0;
				write_pc=1'b0;
				pop_segment=2'b00;
				rti_pop=1'b0;
				
			end	
			else 
			begin //keep initial state
				state_next=ready;
				write_flags=1'b0;
				write_pc=1'b0;
				pop_segment=2'b00;
				rti_pop=1'b0;
			end
		end
		state1:
		begin
			state_next=state2;
			write_flags=1'b0;
			write_pc=1'b0;
			pop_segment=2'b00;
			rti_pop=1'b0;
		end
		state2:
		begin
			//pop pc_h to MEM/WB buffer
			state_next=state3;
			write_flags=1'b0;
			write_pc=1'b0;
			pop_segment=2'b00;
			rti_pop=1'b1;
		end
		state3:
		begin
			//write back pc
			state_next=state4;
			write_flags=1'b1;
			write_pc=1'b0;
			pop_segment=2'b01;
			rti_pop=1'b1;
		end
		state4:
		begin
			//write back pc
			state_next=state5;
			write_flags=1'b0;
			write_pc=1'b0;
			pop_segment=2'b10;
			rti_pop=1'b1;
		end
		state5:
		begin
			//write back pc
			state_next=state6;
			write_flags=1'b0;
			if(isImm==1'b1)begin
				inc_pc=1;
			end
			write_pc=1'b1;
			
		end
		state6:
		begin
			//write back pc
			inc_pc=0;
			isImm=0;
			state_next=ready;
			write_flags=1'b0;
			write_pc=1'b0;
			pop_segment=2'b11;
			rti_pop=1'b0;
		end
		default:
		begin
			state_next=ready;
			write_flags=1'b0;				
			write_pc=1'b0;
			pop_segment=2'b10;
			rti_pop=1'b0;
		end
	endcase
end
endmodule
