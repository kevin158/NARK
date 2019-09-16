module NARK_PROCESSOR #(parameter BITS = 24) (CLK, RST);

	input logic  CLK, RST;
	
	logic        PCSrcD,  RegWriteD,  MemWriteD, BranchD, MemtoRegD, ALUSrcD, ImmSrcD,  NoWriteD,
			       PCSrcE,  RegWriteE,  MemWriteE, BranchE, MemtoRegE, ALUSrcE,           NoWriteE,
					 W_PCScr, W_RegWrite, W_MemWrite,
			       PCSrcM,  RegWriteM,  MemWriteM,          MemtoRegM,
					 PCSrcW,  RegWriteW,  						   MemtoRegW;
	logic [1:0]  ALUControlD, FlagWriteD,
					 ALUControlE,  FlagWriteE;
	logic [3:0]	 FlagsPrime,  ALUFlags,
					 FlagsE, CondE;
	
	logic [23:0] Instr;
	   
	//-----------------------------------------------------------------------------------------------------------
	// Control Unit
	//-----------------------------------------------------------------------------------------------------------
	
	controlUnit 
		CONTROL_UNIT (CLK, RST, Instr[23:22], Instr[17:14], Instr[13:10], PCSrcD, RegWriteD, MemWriteD, BranchD, MemtoRegD, ALUControlD, ALUSrcD, FlagWriteD, ImmSrcD, NoWriteD);
	
	REGISTER_MODULE #(19, 1'b0) 
		DECODE_REGISTER (CLK, RST, CLK, 
		{PCSrcD, RegWriteD, MemWriteD, BranchD, MemtoRegD, ALUControlD, ALUSrcD, FlagsPrime, FlagWriteD, NoWriteD, Instr[21:18]}, 
		{PCSrcE, RegWriteE, MemWriteE, BranchE, MemtoRegE, ALUControlE, ALUSrcE, FlagsE,     FlagWriteE, NoWriteE, CondE});
	
	condUnit
		CONDITIONAL_UNIT (CLK, RST, CondE, PCSrcE, RegWriteE, MemWriteE, BranchE, FlagsE, FlagWriteE, NoWriteE, ALUFlags, FlagsPrime, W_PCScr, W_RegWrite, W_MemWrite);
	 
	REGISTER_MODULE #(4, 1'b0) 
		EXECUTE_REGISTER (CLK, RST, CLK, 
		{W_PCScr, W_RegWrite, W_MemWrite, MemtoRegE}, 
		{PCSrcM,  RegWriteM,  MemWriteM,  MemtoRegM});
	 
	REGISTER_MODULE #(3, 1'b0) 
		MEMORY_REGISTER (CLK, RST, CLK, 
		{PCSrcM,  RegWriteM,  MemtoRegM}, 
		{PCSrcW,  RegWriteW,  MemtoRegW});
	
	//-----------------------------------------------------------------------------------------------------------
		
	DATAPATH_MODULE #(BITS) 
		DATAPATH (CLK, RST, PCSrcW, RegWriteW, ImmSrcD, ALUSrcE, ALUControlE, MemWriteM, MemtoRegW, ALUFlags, Instr);
		
endmodule 