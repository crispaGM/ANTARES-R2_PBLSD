module Banco_Registradores(clock,EscReg,Dado_Escrito,RegW,ReadA,ReadB,OutA,OutB);
input [4:0] RegW, ReadA, ReadB;
input EscReg,clock;
input [31:0] Dado_Escrito;
output [31:0] OutA,OutB;

reg [31:0] OutA, OutB;
reg [31:0] regfile[31:0];

initial begin
OutA = 0;
OutB = 0;
end

always@(clock,Dado_Escrito,RegW,EscReg)
begin
if(EscReg && clock)
begin
regfile[RegW]<=Dado_Escrito; // /guardando valor no registrador de escrita
end
end

always @ (clock,ReadA,ReadB,RegW)
begin
if(~clock)
begin
OutA <= regfile[ReadA];
OutB <= regfile[ReadB];
end
end
endmodule
