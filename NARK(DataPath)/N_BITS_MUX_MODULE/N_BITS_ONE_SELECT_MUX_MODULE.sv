module N_BITS_ONE_SELECT_MUX_MODULE #(parameter BITS=32)(A, B, S, R);

	input logic [BITS-1:0] A, B;
	input logic S;
	output logic [BITS-1:0] R;
	
	genvar i;
	generate
		for(i = 0; i < BITS; i++) 
		begin : generate_block_identifier
			ONE_BIT_MUX_MODULE
				OBMM (A[i], B[i], S, R[i]);
		end
	endgenerate
	
endmodule 