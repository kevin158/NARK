module KERNEL_MEMORY_MODULE #(parameter DATA_SIZE = 24)(CLK, RST, ADDRESS, WRITE, IN_DATA, OUT_DATA);

	input  logic CLK, WRITE, RST;
	input  logic [4:0] ADDRESS;
	input  logic [DATA_SIZE-1:0] IN_DATA;
	output logic [DATA_SIZE-1:0] OUT_DATA;
	
	logic [31:0] 		           DEMUX_WRITE;
	logic [31:0] [DATA_SIZE-1:0] REGISTER_DATA;
	logic [31:0]                 WRT_DATA_R15_MUX;
	 
	FIVE_BITS_SELECT_THIRTY_TWO_DEMUX_MODULE
		FBSSDM (WRITE, ADDRESS, DEMUX_WRITE);
		
	genvar r;
	generate
		for(r = 0; r < 32; r++) 
		begin : GENERATE_BLOCK_IDENTIFIER 
			REGISTER_MODULE #(32,1'b0)
				REGISTER (CLK, RST, DEMUX_WRITE[r], IN_DATA, REGISTER_DATA[r]);
		end
	endgenerate
	
	assign OUT_DATA = REGISTER_DATA[ADDRESS];  

endmodule 