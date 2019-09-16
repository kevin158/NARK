module EXECUTE_MODULE #(parameter BITS = 24) (CLK, RST, RD1, RD2, WA4D, ExtImmE, ALUSrcE, ALUControlE, ALUFlags, ALUResultE, WriteDataE, WA4E);
	
	input  logic            CLK, RST, ALUSrcE;
	input  logic [BITS-1:0] RD1, RD2;
	input  logic [3:0]      WA4D;
	input  logic [23:0]     ExtImmE;
	input  logic [1:0]		ALUControlE;
	output logic [3:0]		ALUFlags;
	output logic [BITS-1:0] ALUResultE, WriteDataE;
	output logic [3:0]      WA4E;
	
	logic 			  COUT;
	logic [BITS-1:0] SrcBE, W_ALUResultE;
	
	N_BITS_ONE_SELECT_MUX_MODULE #(BITS)
		MUX (RD2, ExtImmE, ALUSrcE, SrcBE);
	
	N_BITS_ALU_MODULE #(BITS)
		ALU (RD1, SrcBE, 1'b0, ALUControlE, W_ALUResultE, COUT, ALUFlags);
	
	REGISTER_MODULE #(BITS, 1'b0) 
		REGISTER_ALUResult (CLK, RST, CLK, W_ALUResultE, ALUResultE),
		REGISTER_WriteData (CLK, RST, CLK, SrcBE,        WriteDataE);
		
	REGISTER_MODULE #(4, 1'b0) 
		REGISTER_WA4E (CLK, RST, CLK, WA4D, WA4E);
	
endmodule 