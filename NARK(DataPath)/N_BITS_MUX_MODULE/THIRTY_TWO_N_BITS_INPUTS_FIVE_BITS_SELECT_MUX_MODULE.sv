module THIRTY_TWO_N_BITS_INPUTS_FIVE_BITS_SELECT_MUX_MODULE #(parameter BITS = 32) (DATA, SELECT, OUT);

	input logic [31:0][BITS-1:0] DATA;
	input logic [4:0] SELECT;
	output logic [BITS-1:0] OUT;
	logic [BITS-1:0] W_FIRST_MUX, W_SECOND_MUX;
	
	SIXTEEN_N_BITS_INPUTS_FOUR_BITS_SELECT_MUX_MODULE #(BITS)
		FIRST_MUX (DATA[15:0], SELECT[3:0], W_FIRST_MUX),
		SECOND_MUX (DATA[31:16], SELECT[3:0], W_SECOND_MUX);
	N_BITS_ONE_SELECT_MUX_MODULE #(BITS)
		THIRD_MUX (W_FIRST_MUX, W_SECOND_MUX, SELECT[4], OUT);
	
endmodule 