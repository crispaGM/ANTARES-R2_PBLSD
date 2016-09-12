module CPU (clock);
  input clock;

  //variáveis do IF
  wire [31:0] proximo_PC, IF_pc_mais_4, IFinst;
  reg [31:0] PC;
  wire lerMem, escMem; //variáveis de controle do IF

  //control vars do ID
  wire PCWrite,IFIDWrite,HazMuxCon,jump,bne,imm,andi,ori,addi;
  wire [8:0] IDcontrol,ConOut;

  /**
  * Instruction Fetch
  */
  //assign PCSrc = ((IDRegAout==IDRegBout)&IDcontrol[6])|((IDRegAout!=IDRegBout)&bne);
  //assign IFFlush = PCSrc|jump;
  assign IF_pc_mais_4 = PC + 4; //variável do registrador

  //assign nextpc = PCSrc ? BranchAddr : PCMuxOut;

  always @ (posedge clock) begin
    if(PCWrite)
    begin
      PC = nextpc; //update pc
    end
  end
  memoria_compartilhada memoria(PC, 32'bx, lerMem, escMem, clock, IFinst);















endmodule //
