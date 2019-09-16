module N_BITS_ARITMETIC_SHIFT_RIGHT #(parameter BITS = 32)(A, N, A_SR);
	
	input  logic        [BITS-1:0] N;
	input  logic signed [BITS-1:0] A;
	output logic signed [BITS-1:0] A_SR;
	
	assign A_SR = A >>> N;
	 
endmodule 