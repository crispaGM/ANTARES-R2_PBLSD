module CPU (clock);
  input clock;

  //variáveis do IF
  wire [31:0] proximo_PC, IF_pc_mais_4, IFinst;
  reg [31:0] PC;
  wire lerMem, escMem; //variáveis de controle do IF

  

  //variaveis do ID
 wire PCSrc;
 wire [4:0] IDRegRs,IDRegRt,IDRegRd; // registradores que vão ser usados na instrução
 wire [31:0] IDpc_plus_4,IDinst; 
 wire [31:0] IDRegAout, IDRegBout; // valor lido
 wire [31:0] IDimm_value,BranchAddr,PCMuxOut,JumpTarget; // variaveis, imediata, endereço do desvio, saida do mux para o pc. endereço do salto
 wire PCWrite,IFIDWrite,HazMuxCon,jump,bne,imm,andi,ori,addi; // variaveis de controle para auxiliar no ID
 wire [8:0] IDcontrol,ConOut; 

  /**
  * Instruction Fetch
  */
  assign PCFonte = ((IDRegAout==IDRegBout)&IDcontrol[6])|((IDRegAout!=IDRegBout)&bne); // verifica a ocorrência de desvio condicional
  assign IFFlush = PCSrc|jump; // se houver desvio ou salto
  assign IF_pc_mais_4 = PC + 4; //variável do registrador if

  assign nextpc = PCFonte ? BranchAddr : PCMuxOut; // se houve desvio pc recebe endereço do branch, caso não recebe saida do mux

  always @ (posedge clock) begin
    if(PCWrite)
    begin
      PC = nextpc; //update pc
    end
  end
  memoria_compartilhada memoria(PC, 32'bx, lerMem, escMem, clock, IFinst);















endmodule //
