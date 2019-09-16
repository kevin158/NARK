module condUnit
	(
	 input logic CLK, 
	 input logic Reset,
	 input logic [3:0] CondE,
	 input logic PCSrcE,
	 input logic RegWriteE,
	 input logic MemWriteE,
	 input logic BranchE,
	 input logic [3:0] FlagsE,
	 input logic [1:0] FlagWriteE,	
	 input logic NoWriteE,
	 input logic [3:0] ALUFlags,
	 output logic [3:0] FlagsPrime,
	 output logic PCScrM,
	 output logic RegWriteM,
	 output logic MemWriteM
	 );

	logic [1:0] FlagWrite;
	logic CondEx, PCSrcCond, BranchCond;

	//Write controls are conditional
	assign FlagWrite = FlagWriteE & {2{CondEx}};

	FlipFlop #(2) flagreg1(ALUFlags[3:2], CLK, Reset, FlagWrite[1], FlagsPrime[3:2]);
	FlipFlop #(2) flagreg0(ALUFlags[1:0], CLK, Reset, FlagWrite[0], FlagsPrime[1:0]);
	
	condCheck cc (CondEx, CondE, FlagsE);

	and and1(PCSrcCond, PCSrcE, CondEx);
	and and2(BranchCond, BranchE, CondEx);

	or or1(PCScrM, PCSrcCond, BranchCond);
	and and3(RegWriteM, RegWriteE, ~NoWriteE, CondEx);
	and and4(MemWriteM, MemWriteE, CondEx);

	assign FlagsPrime = FlagsE;

endmodule
