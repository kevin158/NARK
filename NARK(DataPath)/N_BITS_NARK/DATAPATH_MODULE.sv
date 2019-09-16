module DATAPATH_MODULE #(parameter BITS = 24) (CLK, RST, PCSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, MentoReg, ALUFlags, Instr);
	
	input  logic 				CLK, RST, PCSrc, RegWrite, ALUSrc, MemWrite, MentoReg, ImmSrc;
	input  logic [1:0] 		ALUControl;
	output logic [3:0] 		ALUFlags;
	output logic [BITS-1:0] Instr;
	
	logic [BITS-1:0] W_Instr, W_PCPlus1, W_Result, W_RD1, W_RD2, W_ExtImm, W_ALUResult, W_WriteData, W_ReadData, W_ALUOut;
	logic [3:0] 	  W_WA4DE, W_WA4MW, W_WA4EM;
	
	FETCH_MODULE #(BITS) 
		FM (CLK, RST, PCSrc, W_Result, Instr, W_PCPlus1);
		
	DECODE_MODULE #(BITS) 
		DM (CLK, RST, RegWrite, ImmSrc, W_Instr, W_PCPlus1, W_Result, W_WA4MW, W_RD1, W_RD2, W_WA4DE, W_ExtImm);
		
	EXECUTE_MODULE #(BITS) 
		EM (CLK, RST, W_RD1, W_RD2, W_WA4DE, W_ExtImm, ALUSrc, ALUControl, ALUFlags, W_ALUResult, W_WriteData, W_WA4EM);
		
	MEMORY_MODULE #(BITS) 
		MM (CLK, RST, W_WA4EM, W_ALUResult, W_WriteData, MemWrite, W_ReadData, W_ALUOut, W_WA4MW);
	
	N_BITS_ONE_SELECT_MUX_MODULE #(BITS)
		WRITEBACK_MUX (W_ALUOut, W_ReadData, MentoReg, W_Result);
	
	assign W_Instr = Instr;
	
endmodule 