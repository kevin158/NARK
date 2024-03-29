module EXTEND_MODULE (IMM, IMM_SRC, EXT_IMM);
	
	input  logic [15:0] IMM;
	input  logic IMM_SRC;
	output logic [23:0] EXT_IMM;
	
	logic [23:0] EXT16, EXT10;
	
	N_BITS_ARITMETIC_SHIFT_RIGHT #(24)
		ASR_EXT16 ({IMM,      8'd00}, 24'd08, EXT16),
		ASR_EXT10 ({IMM[9:0], 14'd0}, 24'd14, EXT10);
		
	N_BITS_ONE_SELECT_MUX_MODULE #(24)
		EXT_MUX (EXT10, EXT16, IMM_SRC, EXT_IMM);
	
endmodule 