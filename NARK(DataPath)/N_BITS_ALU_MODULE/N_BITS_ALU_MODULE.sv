module N_BITS_ALU_MODULE #(parameter BITS = 24) (A, B, CIN, OP, RST, COUT, FLAGS);
	
	input  logic  [BITS-1:0] A, B;
	input  logic  [1:0] 		 OP;
	input  logic  				 CIN;
	output logic  [BITS-1:0] RST;
	output logic  [3:0] 		 FLAGS;
	output logic 				 COUT;
	logic  [3:0]  [BITS-1:0] DATA;
	logic 						 W_COUT, W_SUB, ZERO_FLAG, W_XOR, W_AND, W_EQU, W_OP, W_LB_RST;
	logic         [BITS-1:0] W_ADD_SUB_RST;
	
	//----------------------------------------------- Aritmetic functions -----------------------------------------------
	
	//Full adder-subtracter module -> Operation ADD = 00, SUB = 01
	EQUAL_COMPARATOR_MODULE #(2) 
		EQU_SUB (OP, 2'b01, W_SUB);
	
	N_BITS_ADD_SUB_MODULE #(BITS) 
		ADD_SUB (A, B, CIN, W_SUB, W_ADD_SUB_RST, W_COUT);
	
	assign DATA[0] = W_ADD_SUB_RST;
	assign DATA[1] = W_ADD_SUB_RST;
	
	//Multiplier module -> Operation MUL = 10
	N_BITS_MULTIPLIER #(BITS)
		MUL (A, B, DATA[2]);
	
	//Pass B operator -> Operation NULL = 11 (System only)
	assign DATA[3] = B;
	
	//Operation selection multiplexor 
	FOUR_N_BITS_INPUTS_TWO_BITS_SELECT_MUX_MODULE #(BITS)
		ALU_MUX (DATA, OP, RST);
		
	assign COUT = W_COUT;
	assign W_LB_RST = RST[BITS-1];
	
	//----------------------------------------------- Conditional Flags -----------------------------------------------
	
	//N conditional flag
	assign FLAGS[0] = RST[BITS-1];
	
	//Z conditional flag
	N_INPUTS_OR #(BITS)
		ZERO (RST, ZERO_FLAG);
	assign FLAGS[1] = ~ZERO_FLAG;
	
	//C conditional flag
	_AND
		AND_C  (~OP[1], A[BITS-1], W_OP);
	_OR
		OR_C   (W_COUT, W_OP, FLAGS[2]);
		
	//V conditional flag
	_XOR
		XOR_V (A[BITS-1], B[BITS-1], W_XOR);
	_AND
		FIRST_AND_V  (B[BITS-1], W_LB_RST, W_AND),
		SECOND_AND_V (W_XOR, W_AND, FLAGS[3]);
		
endmodule 