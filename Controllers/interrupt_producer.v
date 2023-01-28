module interrupt_producer(reset,INTR,CALL,END_CALL,OUT_INTR);
input INTR,CALL,END_CALL,reset;
output reg OUT_INTR;

reg active_call,activate_INTR;

always@(reset)begin
//	active_call=1'b0;
	//activate_INTR=1'b0;
	OUT_INTR=1'b0;
end

//always@(*)begin
//if(CALL)
	//active_call=1'b1;

//else if(END_CALL)
//	active_call=1'b0;
//else
//	active_call=active_call;
//	end
assign active_call=(reset==1'b1)?1'b0:(CALL==1'b1)?1'b1:(END_CALL==1'b1)?1'b0:active_call;
assign activate_INTR=(reset==1'b1)?1'b0:(INTR==1'b1)?1'b1:(active_call==1'b0)?1'b0:activate_INTR;


//always@(*)begin
//if(INTR)
//	activate_INTR=1'b1;
//else if(active_call==1'b0)
	//	activate_INTR=1'b0;
//else
//	activate_INTR=activate_INTR;
//end


always@(activate_INTR,active_call)begin
	if(active_call==1'b0&&activate_INTR==1'b1)begin
		//OUT_INTR=1'b1;
		activate_INTR=1'b0;
		active_call=1'b0; //nonsense statement but ok ^^
	end
	else if(active_call==1'b0&&activate_INTR==1'b0)
		OUT_INTR=1'b0;
end

//assign activate_INTR=(INTR==1'b1)?1'b1:activate_INTR;
//assign active_call = (CALL==1'b1)?1'b1:
	//				 (END_CALL==1'b1)?1'b0:active_call;
assign OUT_INTR = (active_call==1'b0&&activate_INTR==1'b1)?1'b1:1'b0;

endmodule
