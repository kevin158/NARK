module THREE_BITS_SELECT_EIGHT_DEMUX_MODULE (IN, SELECT, OUT);
	
	input  logic 		 IN;
	input  logic [2:0] SELECT;
	output logic [7:0] OUT;
	logic        [3:0] W_IN;
	
	TWO_BITS_SELECT_FOUR_DEMUX_MODULE
		MAIN_DEMUX (IN, SELECT[1:0], W_IN);
	ONE_BITS_SELECT_TWO_DEMUX_MODULE
		DEMUX_1  (W_IN[0],  SELECT[2], OUT[1:0]),
		DEMUX_2  (W_IN[1],  SELECT[2], OUT[3:2]),
		DEMUX_3  (W_IN[2],  SELECT[2], OUT[5:4]),
		DEMUX_4  (W_IN[3],  SELECT[2], OUT[7:6]);
		
endmodule