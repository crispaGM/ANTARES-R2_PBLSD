// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Lab 3, 2016.1
//
// Module: ALU.v
// Desc:   32-bit ALU for the MIPS150 Processor
// Inputs:
// 	A: 32-bit value
// 	B: 32-bit value
// 	ALUop: Selects the ALU's operation
//
// Outputs:
// 	Out: The chosen function mapped to A and B.

`include "Opcode.vh"
`include "ALUop.vh"

module ALU(
    input [31:0] A,B,
    input [3:0] ALUop,
    output reg [31:0] Out
);

always @(ALUop)
begin

  case (ALUop)
    `ALU_ADDU: // add
        Out 		= A + B;
  `ALU_SUBU: // SUB
        Out 		= A - B;
    `ALU_SLT: // SLT
        Out 		= (A < B) ? -1 : 0;
    `ALU_SLTU: // SLTU
        Out 		= (A < B) ? 1 : 0;
    `ALU_AND: // AND
        Out 		= A & B;
    `ALU_OR: // OR
        Out 		= A | B;
    `ALU_XOR: // XOR
        Out 		= A ^ B;
    `ALU_LUI: //LUI
        Out = {B[15:0], 16'd0};
    `ALU_SLL: // shift left
        Out 		= A << B;
    `ALU_SRL: // shift right
        Out 		= A >> B;
    `ALU_SRA: // shift right arithmetic
        Out 		= A >>> B;
    `ALU_NOR: // NOR
        Out 		= ~(A | B);
  endcase
end
endmodule
