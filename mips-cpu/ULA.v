module ALU(ALUCon,DataA,DataB,Result);
 input [2:0] ALUCon;
 input [31:0] DataA,DataB;
 output [31:0] Result;

 reg [31:0] Result;
 reg Zero;

 initial begin
 Result = 32'd0;
 end
 always@(ALUCon,DataA,DataB)
 begin
	 case(ALUCon)
		 3'b000://add
		 	Result <= DataA+DataB;


		 3'b001://sub
			 Result <= DataA-DataB;

		 3'b010://multiply
		 	Result <= DataA*DataB;
		
		 3'b011://divide
			 Result <= DataA/DataB;
		 
		 3'b100://slt
			 Result = DataA<DataB ? 1:0;

		 default: //error
		 begin
			 $display("ALUERROR");
			 Result = 0;
		 end
	 endcase
 end
endmodule 