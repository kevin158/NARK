module MEMORY_MODULE #(parameter BITS = 24) (CLK, RST, WA4E, ALUResultE, WriteDataE, MenWriteM, ReadDataM, ALUOutM, WA4M);
	
	input  logic  CLK, RST,  MenWriteM;
	input  logic  [BITS-1:0] ALUResultE, WriteDataE;
	input  logic  [3:0]      WA4E;
	output logic  [BITS-1:0] ReadDataM, ALUOutM;
	output logic  [3:0]      WA4M;
	
	logic  [BITS-1:0]        W_ReadDataM;
	
	KERNEL_MEMORY_MODULE #(BITS)
		KERNEL_MEMORY (CLK, RST, ALUResultE, MenWriteM, WriteDataE, W_ReadDataM);
	
	REGISTER_MODULE #(BITS, 1'b0) 
		REGISTER_ReadData (CLK, RST, CLK, W_ReadDataM, ReadDataM),
		REGISTER_ALUOut   (CLK, RST, CLK, ALUResultE,  ALUOutM);
	
	REGISTER_MODULE #(4, 1'b0) 
		REGISTER_WA4      (CLK, RST, CLK, WA4E, WA4M);
	
endmodule 