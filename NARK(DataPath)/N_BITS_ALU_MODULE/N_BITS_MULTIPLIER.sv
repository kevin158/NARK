module N_BITS_MULTIPLIER #(parameter BITS = 24)(A, B, RESULT);
	input  logic [BITS-1:0] A, B;
	output logic [BITS-1:0] RESULT;
	logic 		 [BITS-2:0][BITS-1:0] A_ENA;
	logic 		 [BITS-2:0][BITS-1:0] A_SL, PARTIAL_RESULT;
	logic 		 [BITS-1:0] Cout;
	
	ENABLE_MODULE #(BITS)
		FIRST_EN (A, B[0], PARTIAL_RESULT[0]);
	
	genvar i;
	generate
		for(i = 1; i < BITS-1; i++) 
		begin : generate_block_identifier
			ENABLE_MODULE #(BITS)
				EN (A, B[i], A_ENA[i-1]);
			N_BITS_LOGIC_SHIFT_LEFT #(BITS)
				NBLSL (A_ENA[i-1], i[23:0], A_SL[i-1]);
			ADDER_MODULE #(BITS)
				AM (A_SL[i-1], PARTIAL_RESULT[i-1], 1'b0, PARTIAL_RESULT[i], Cout[i]);
		end
	endgenerate
	
	ENABLE_MODULE #(BITS)
		LAST_EN (A, B[BITS-1], A_ENA[BITS-2]);
	N_BITS_LOGIC_SHIFT_LEFT #(BITS)
		LAST_NBLSL (A_ENA[BITS-2], BITS-1, A_SL[BITS-2]);
	ADDER_MODULE #(BITS)
		LAST_AM (A_SL[BITS-2], PARTIAL_RESULT[BITS-2], 1'b0, RESULT, Cout[BITS-1]);
	
endmodule 