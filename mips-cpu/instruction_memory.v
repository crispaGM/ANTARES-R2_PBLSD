module InstructMem(PC,Inst);
 input [31:0] PC;
 output [31:0] Inst;

 reg [31:0] regfile[511:0];//32 32-bit register

 assign Inst = regfile[PC]; //assigns output to instruction

endmodule 
