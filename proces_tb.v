module proces_tb();


reg clk,reset,INTR;
reg [15:0]IN_PORT;

processor pro(clk,reset,INTR,IN_PORT);


 always #50 clk=~clk;
 initial begin
    clk = 1;
    reset = 1;
    IN_PORT=16'b0;
	INTR=0;
    #100
	IN_PORT=16'b11001;
	reset=0;
	#100
	IN_PORT=16'b1111;
	#100
	IN_PORT=16'b1111_0011_0010_0000;
	#100;
	
	
	
  
end 

endmodule 
