module _XNOR (input logic X,Y, output logic Z);
	assign Z = ~(X ^ Y);
endmodule 