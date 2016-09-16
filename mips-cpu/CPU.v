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


  //variaveis de execução
 wire [1:0] EXWB,ForwardA,ForwardB,aluop;
 wire [2:0] EXM;
 wire [3:0] EXEX,ALUCon;
 wire [4:0] EXRegRs,EXRegRt,EXRegRd,regtopass;
 wire [31:0] EXRegAout,EXRegBout,EXimm_value, b_value;
 wire [31:0] EXALUOut,ALUSrcA,ALUSrcB; 


 //variveis de memoria
 wire [1:0] MEMWB;
 wire [2:0] MEMM;
 wire [4:0] MEMRegRd;
 wire [31:0] MEMALUOut,MEMWriteData,MEMReadData;

 //variaveis de escrita
 wire [1:0] WBWB;
 wire [4:0] WBRegRd;
 wire [31:0] datatowrite,WBReadData,WBALUOut; 

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
   
  HazardUnit HU(IDRegRs,IDRegRt,EXRegRt,EXM[1],PCWrite,IFIDWrite,HazMuxCon); // unidade de hazard 
  Control uc (IDinst[31:26],ConOut,jump,bne,imm,andi,ori,addi); // unidade de controle
 Banco_Registradores registradores (clock,WBWB[0],datatowrite,WBRegRd,IDRegRs,IDRegRt,IDRegAout,IDRegBout);  // banco de registradores

 IDEX
IDEXreg(clock,IDcontrol[8:7],IDcontrol[6:4],IDcontrol[3:0],IDRegAout,IDRegBout,IDimm_value,IDRegRs,IDRegRt,IDRegRd,EXWB,EXM,EXEX,EXRegAout,EXRegBout,EXimm_value,EXRegRs,EXRegRt,EXRegRd
);  // passando para o estágio de execução

 
 /**
 * Execução
 */
 assign regtopass = EXEX[3] ? EXRegRd : EXRegRt;
 assign b_value = EXEX[2] ? EXimm_value : EXRegBout;

 MUX MUX1(ForwardA,EXRegAout,datatowrite,MEMALUOut,0,ALUSrcA);
 MUX MUX2(ForwardB,b_value,datatowrite,MEMALUOut,0,ALUSrcB);
 ForwardUnit FU(MEMRegRd,WBRegRd,EXRegRs, EXRegRt, MEMWB[0], WBWB[0], ForwardA,
ForwardB);
 // ALU control
  assign aluop[0] =
 (~IDinst[31]&~IDinst[30]&~IDinst[29]&IDinst[28]&~IDinst[27]&~IDinst[26])|(imm);
  assign aluop[1] =
 (~IDinst[31]&~IDinst[30]&~IDinst[29]&~IDinst[28]&~IDinst[27]&~IDinst[26])|(imm);

 ALUControl ALUcontrol(andi,ori,addi,EXEX[1:0],EXimm_value[5:0],ALUCon);
 ALU theALU(ALUCon,ALUSrcA,ALUSrcB,EXALUOut);

 EXMEM EXMEMreg(clock,EXWB,EXM,EXALUOut,regtopass,EXRegBout,MEMM,MEMWB,MEMALUOut,MEMRegRd,MEMWriteData); // estágio de acesso a memória
 /**
 * Acesso a memória
 */
memoria_compartilhada DM(MEMM[0],MEMM[1],MEMALUOut,MEMWriteData,MEMReadData); 

MEMWB
MEMWBreg(clock,MEMWB,MEMReadData,MEMALUOut,MEMRegRd,WBWB,WBReadData,WBALUOut,WBRegRd); // passando para o estágio final de escrita no registrador
 /**
 * Escrita no registrador
 */
 assign datatowrite = WBWB[1] ? WBReadData : WBALUOut; 

endmodule 