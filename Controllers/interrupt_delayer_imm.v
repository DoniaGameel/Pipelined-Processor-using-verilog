module interrupt_delayer_imm(reset,INTR,imm,OUT_INTR);
input INTR,imm,reset;
output reg OUT_INTR;

reg active_imm;
reg activate_INTR;

always@(reset)begin
	//active_imm=1'b0;
	//activate_INTR=1'b0;
	OUT_INTR=1'b0;
end


//always@(imm)begin
//if(imm)
	//active_imm=1'b1;
//else
	//active_imm=1'b0;


//end


//assign OUT_INTR=(active_imm==1'b0&&activate_INTR==1'b1)?1'b1:1'b0;


assign  activate_INTR=(INTR==1'b1)?1'b1
    :activate_INTR;
assign  active_imm=(imm==1'b1)?1'b1:1'b0;

//always@(INTR)begin
//if(INTR)
//	activate_INTR=1'b1;
//else
	//activate_INTR=activate_INTR;
//end
always@(active_imm,activate_INTR)begin
	if(active_imm==1'b0&&activate_INTR==1'b1)begin
		OUT_INTR=1'b1;
		activate_INTR=1'b0;
	//	active_imm=1'b0; //nonsense statement but ok ^^
	end
	else
		OUT_INTR=1'b0;
end



endmodule

