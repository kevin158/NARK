//`timescale 1 ps / 1 ps

module TESTBENCH_MODULE;

/** Fetch Testbench

	logic [31:0] InstrF, PCPlus1F;
	logic        CLK, RST;
	
	FETCH_MODULE #(32) 
		FM (CLK, RST, 1'b0, 32'd3, InstrF, PCPlus1F);
	
	initial begin  
		RST = 1'b0; CLK = 1'b0; #100;
		RST = 1'b1; CLK = 1'b1; #100;	
	end 

	always begin 
		CLK = ~ CLK; #100;
	end
 
**/

/** Specific purpose registers Testbench
	
	logic [3:0]  ADDRS_RN, ADDRS_RM;
	logic        CLK, RST, WRT_ENA;
	logic [23:0] WRT_DATA, RN_DATA, RM_DATA;

	REGISTER_FILE_MODULE #(24) 
		RFM (CLK, RST, ADDRS_RN, ADDRS_RM, WRT_DATA, 24'd0, WRT_ENA, RN_DATA, RM_DATA);

	initial begin

		ADDRS_RM = 4'b0;  WRT_DATA = 24'h0;      WRT_ENA = 1'b0;
		
		RST = 1'b0; CLK = 1'b1; #100;
		RST = 1'b1; CLK = 1'b0; #100;	
		
	 
		ADDRS_RN = 4'd12; WRT_DATA = 24'h010201; WRT_ENA = 1'b1;
		 
		CLK = 1'b1; #100; 
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000001; WRT_ENA = 1'b1;
		 
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000002; WRT_ENA = 1'b1;
		
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000003; WRT_ENA = 1'b1;
		 
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;
		
		//-----------------------------------------------------------------------------------------------------

		ADDRS_RN = 4'd12; WRT_DATA = 24'h000000; WRT_ENA = 1'b1;
		 
		CLK = 1'b1; #100; 
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000004; WRT_ENA = 1'b1;
		
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000005; WRT_ENA = 1'b1;
		
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000006; WRT_ENA = 1'b1;
		 
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;

		//-----------------------------------------------------------------------------------------------------
		
		ADDRS_RN = 4'd12; WRT_DATA = 24'hFFFEFF; WRT_ENA = 1'b1;
		
		CLK = 1'b1; #100; 
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000007; WRT_ENA = 1'b1;
		
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000008; WRT_ENA = 1'b1;
		
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;
		
		ADDRS_RN = 4'd13; WRT_DATA = 24'h000009; WRT_ENA = 1'b1;
		  
		CLK = 1'b1; #100;
		CLK = 1'b0; #100;

		ADDRS_RN = 4'd14; WRT_ENA = 1'b0;
		
	end 

	always begin 
		CLK = ~ CLK; #100;
	end
**/

/** RAM Testbench	
	logic CLK, WRT_ENA;
	logic [7:0] IN_DATA, OUT_DATA;
	logic [19:0] READ_ADDRS, WRITE_ADDRS, ADDRS;
	
	RAM 
		IMG_RAM (CLK, IN_DATA, READ_ADDRS, WRITE_ADDRS, WRT_ENA, OUT_DATA);
	
	initial begin
		IN_DATA = 8'h00; READ_ADDRS = 20'h00000; WRITE_ADDRS = 20'h00000; WRT_ENA = 1'b0;

		for(ADDRS = 1; ADDRS < 5000; ADDRS++) begin
			CLK = 1'b1; #100;
			CLK = 1'b0; #100;
			READ_ADDRS = ADDRS;
		end
		
	end
**/

/** Extend Testbench	
	logic IMM_SRC;
	logic [15:0] IMM; 
	logic [23:0] EXT_IMM;
	
	EXTEND_MODULE 
		EXTM (IMM, IMM_SRC, EXT_IMM);

	initial begin
		IMM = 16'hF2FF; IMM_SRC = 1'b0; #100;
		IMM_SRC = 1'b1; #100;
	end
**/

// NARK Testbench

	logic        CLK, RST;
	
	NARK_PROCESSOR #(24) 
		NARK (CLK, RST);
	
	initial begin  
		RST = 1'b0; CLK = 1'b0; #100;
		RST = 1'b1; CLK = 1'b1; #100;
	end 

	always begin 
		CLK = ~ CLK; #100;
   end

endmodule 
