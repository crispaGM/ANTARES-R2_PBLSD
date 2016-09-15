`include "memoria_compartilhada.v"
`include "IF_ID.v"
`include "sign_ext.v"

module CPU (clock);
  input clock;

  //variáveis do IF
  wire [31:0] proximo_PC, IF_pc_mais_4, IFinst;
  reg [31:0] PC;
  wire lerMem, escMem; //variáveis de controle do IF



  //variaveis do ID
 wire PCSrc;
 wire [4:0] IDRegRs,IDRegRt,IDRegRd; // registradores que vão ser usados na instrução
 wire [31:0] ID_pc_mais_4,IDinst;
 wire [31:0] IDRegAout, IDRegBout; // valor lido
 wire [31:0] IDimm_value,BranchAddr,PCMuxOut,JumpTarget; // variaveis, imediata, endereço do desvio, saida do mux para o pc. endereço do salto
 wire PCWrite,IFIDWrite,HazMuxCon,jump,bne,imm,andi,ori,addi; // variaveis de controle para auxiliar no ID
 wire [8:0] IDcontrol,ConOut;

  /**
  * Busca de instruções
  */
  assign PCFonte = ((IDRegAout==IDRegBout)&IDcontrol[6])|((IDRegAout!=IDRegBout)&bne); // verifica a ocorrência de desvio condicional
  assign IFFlush = PCSrc|jump; // se houver desvio ou salto atualiza o valor do flush
  assign IF_pc_mais_4 = PC + 4; //variável do registrador if

  assign nextpc = PCFonte ? BranchAddr : PCMuxOut; // se houve desvio pc recebe endereço do branch, caso não recebe saida do mux

  always @ (posedge clock) begin
    if(PCWrite)
    begin
      PC = proximo_PC; //update pc
    end
  end
  memoria_compartilhada memoria(PC, 32'bx, lerMem, escMem, clock, IFinst); // acessa a memória compartilhada e coloca em Ifinst o endereço da instrução buscada

  IF_ID if_id (IFFlush,clock,IFIDWrite,IF_pc_mais_4,IFinst,IDinst,ID_pc_mais_4); // criação do registrador interestágio de busca de instrução


/**
  * Decodificação de instruções
  */

  assign IDRegRs[4:0]=IDinst[25:21]; // definindo os registradores usados na instrução
  assign IDRegRt[4:0]=IDinst[20:16];
  assign IDRegRd[4:0]=IDinst[15:11];

  sign_ext extensor (IDinst[15:0],IDimm_value); // usando extensor na constante imediata
  assign BranchAddr = (IDimm_value << 2) + ID_pc_mais_4; // calculando o endereço do branch constante com deslocamento de 2 + PC +4
  assign JumpTarget[31:28] = IF_pc_mais_4[31:28]; // calculando endereço do salto
  assign JumpTarget[27:2] = IDinst[25:0];
  assign JumpTarget[1:0] = 0;
  assign PCMuxOut = jump ? JumpTarget : IF_pc_mais_4;  // definindo valor do mux do pc



endmodule //
