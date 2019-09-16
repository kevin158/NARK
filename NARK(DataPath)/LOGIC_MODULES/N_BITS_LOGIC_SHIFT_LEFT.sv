module N_BITS_LOGIC_SHIFT_LEFT #(parameter BITS = 32)(A, N, A_SR);
	
	input logic [BITS-1:0] A, N;
	output logic [BITS-1:0] A_SR;
	assign A_SR = A << N;
	
endmodule 