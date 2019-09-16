module FETCH_MODULE #(parameter BITS = 24) (CLK, RST, PCSrc, ResultW, InstrF, PCPlus1F);
	
	input  logic 				CLK, RST, PCSrc;
	input  logic [BITS-1:0] ResultW;
	output logic [BITS-1:0] InstrF, PCPlus1F;
	
	logic  						Cout;
	logic        [BITS-1:0] PCSrc_MUX_W, PC_REGISTER_W;
	logic		    [23:0]     InstrF_W;
	 
	INSTRUCTION_MEMORY #(5)
		IM (PC_REGISTER_W, InstrF_W);
	
	ADDER_MODULE #(BITS)
		PC_ADDER (PC_REGISTER_W, 1'b1, 1'b0, PCPlus1F, Cout);
	
	N_BITS_ONE_SELECT_MUX_MODULE #(BITS)
		PCSrc_MUX (PCPlus1F, ResultW, PCSrc, PCSrc_MUX_W);
	 
	REGISTER_MODULE #(BITS, 1'b0) 
		PIPE_REGISTER (CLK, RST, CLK, InstrF_W, InstrF),
		PC_REGISTER   (CLK, RST, CLK, PCSrc_MUX_W, PC_REGISTER_W);
		
endmodule 