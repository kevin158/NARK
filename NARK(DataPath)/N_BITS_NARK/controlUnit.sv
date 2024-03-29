module controlUnit 
	(
	 input logic CLK, 
	 input logic Reset,
	 input logic [1:0] Op,
	 input logic [3:0] Funct,
	 input logic [3:0] Rd,
	 output logic PCSrcD,
	 output logic RegWriteD,
	 output logic MemWriteD,
	 output logic BranchD,
	 output logic MemtoRegD,
	 output logic [1:0] ALUControlD,
	 output logic ALUSrcD,
	 output logic [1:0] FlagWriteD,	
	 output logic ImmSrcD,
	 output logic NoWriteD
	 );

	logic [6:0] controls;
	logic ALUOp;

	//---------------------------------------------------------------------------------------
	// Main Decoder
	//---------------------------------------------------------------------------------------
	// DP Reg -> 0 0 0 0 0 1 1 -> 7'b0000011
	// DP Imm -> 0 0 0 1 0 1 1 -> 7'b0001011
	// STR    -> 0 X 1 1 0 0 0 -> 7'b0011000
	// LDR    -> 0 1 0 1 0 1 0 -> 7'b0101010
	// B      -> 1 0 0 1 1 0 0 -> 7'b1001100
	//---------------------------------------------------------------------------------------
	always_comb
		case(Op)
			2'b00:
				if (Funct[3]==1)begin		//Funct[3] = 0 -> DP Reg
					controls = 7'b0000011;
				end
				else						//Funct[3] = 1 -> DP Imm
					controls = 7'b0001011;
			2'b01:
				if (Funct[2]==1)begin		//Funct[2] = 1 -> LDR
					controls = 7'b0101010;
				end
				else						//Funct[2] = 0 -> STR
					controls = 7'b0011000;
			2'b10:							
				controls = 7'b1001100;		//B
			default:						
				controls = 7'bx;			//Unimplemented
		endcase	

	assign {BranchD, MemtoRegD, MemWriteD, ALUSrcD, ImmSrcD, RegWriteD, ALUOp} = controls;

	//---------------------------------------------------------------------------------------
	// ALU Decoder
	//---------------------------------------------------------------------------------------
	always_comb
		if (ALUOp) begin
			ALUControlD = Funct[1:0];
			FlagWriteD[1] = Funct[0];
			FlagWriteD[0] = Funct[0] & (ALUControlD == 2'b00 | ALUControlD == 2'b01 | ALUControlD == 2'b10);
			NoWriteD = Funct[0] & (Funct[1:0] == 2'b01);
		end
		else begin
			ALUControlD = 2'b00;
			FlagWriteD = 2'b00;
			NoWriteD = 1'b0;
		end

	//---------------------------------------------------------------------------------------
	// PC Logic
	//---------------------------------------------------------------------------------------
	assign PCSrcD = ((Rd == 4'b1111) & RegWriteD) | BranchD;

endmodule