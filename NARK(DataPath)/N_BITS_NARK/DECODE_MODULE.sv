module DECODE_MODULE #(parameter BITS = 24) (CLK, RST, WE4, ImmSrcD, InstrD, PCPlus1F, ResultW, WA4W, RD1, RD2, WA4D, ExtImmD);
	
	input  logic CLK, RST, WE4, ImmSrcD;
	input  logic [BITS-1:0] InstrD, PCPlus1F, ResultW;
	input  logic [3:0] WA4W;
	output logic [3:0] WA4D;
	output logic [BITS-1:0] RD1, RD2, ExtImmD;
	
	logic  [BITS-1:0] P_RD1, P_RD2, P_ExtImmD;
	
	REGISTER_FILE_MODULE #(BITS) 
		REGISTER_MODULE (CLK, RST, InstrD[13:10], InstrD[9:6], WA4W, ResultW, PCPlus1F, WE4, P_RD1, P_RD2);
	
	REGISTER_MODULE #(4, 1'b0)
		REGISTER_RD1_ADDRS (CLK, RST, CLK, InstrD[13:10], WA4D);
	
	EXTEND_MODULE 
		EXTM (InstrD[15:0], ImmSrcD, P_ExtImmD);
	
	REGISTER_MODULE #(BITS, 1'b0) 
		REGISTER_RD1     (CLK, RST, CLK, P_RD1,         RD1),
		REGISTER_RD2 	  (CLK, RST, CLK, P_RD2,     		RD2),
		REGISTER_ExtImmD (CLK, RST, CLK, P_ExtImmD, 		ExtImmD);
	
endmodule 