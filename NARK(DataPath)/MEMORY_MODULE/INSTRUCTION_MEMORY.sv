module INSTRUCTION_MEMORY #(parameter N_ENTRIES = 1)(ADDRESS, INSTRUCTION);

	input  logic [31:0] ADDRESS;
	output logic [31:0] INSTRUCTION; 
	
	logic [23:0] INSTRUCTIONS [0:N_ENTRIES-1];
	
	initial begin
		$readmemh("C:/Users/Lenovo/Desktop/NARK(DataPath)/INSTRUCTIONS.txt", INSTRUCTIONS);
	end
	
	assign INSTRUCTION = INSTRUCTIONS[ADDRESS];
	
endmodule 