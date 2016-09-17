module Controle_ULA(ALUOp,funct,ALUCon);
 input [5:0] ALUOp;
 input [5:0] funct;
 output [2:0] ALUCon;

 reg [3:0] ALUCon;

 always@(ALUOp or funct or andi or ori or addi)
 begin
	 case(ALUOp)
		 
		 6'b000000://R-type
		 begin
			 if(funct==6'b000000)
				 ALUCon = 3'b000;//add
			 if(funct==6'b100101)
			 	ALUCon = 3'b001;//sub
			 if(funct==6'b011000)
			 	ALUCon = 3'b010;//mult
			 if(funct==6'b011010)
			 	ALUCon = 3'b011;//div
			 if(funct==6'b101010)
			 	ALUCon = 3'b100;//slt
			 if(funct==6'b001000)
			 	ALUCon==3'b000;//jr
		 end
		 //tipo I
		 6'b001000://addi
		 	ALUCon = 3'b000;
		 6'b001010://slti
		 	ALUCon = 3'b100; 
		 
		 //saltos e desvios
		 6'b000100: //beq
		 	ALUCon = 3'b000;
		 6'b000010: //j
		 	ALUCon = 3'b000;
		 6'b000011: //jal
		 	ALUCon = 3'b000;
		 6'b100011 //lw
		 	ALUCon = 3'b000;
		 
		 //load/store
		 6'b101011 //sw
		 	ALUCon = 3'b000;
		 6'b101011 //sw
		 	ALUCon = 3'b000;
	 endcase
	 end


endmodule