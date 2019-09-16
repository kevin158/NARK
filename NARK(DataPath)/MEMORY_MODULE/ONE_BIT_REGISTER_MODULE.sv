module ONE_BIT_REGISTER_MODULE #(parameter INIT = 1'b1) (CLK, RST, WRITE, WRITE_DATA, READ_DATA);

	input  logic CLK, WRITE, RST;
	input  logic WRITE_DATA;
	output logic READ_DATA;
	
	logic DATA, CHANGE;
	//sequential logic
	always_ff @(negedge CLK, negedge RST) begin
	
		if (!RST) DATA <= INIT;
		else DATA <= CHANGE;
		
	end
	
	//combinational logic
	always_comb begin
		
		case (DATA)
 
			1'b0: begin
				if (WRITE) CHANGE = WRITE_DATA;
				else CHANGE = 1'b0;
				READ_DATA = 1'b0;
			end
			
			1'b1: begin
				if (WRITE) CHANGE = WRITE_DATA;
				else CHANGE = 1'b1;
				READ_DATA = 1'b1;
			end
			
		endcase
		
	end
	
endmodule 