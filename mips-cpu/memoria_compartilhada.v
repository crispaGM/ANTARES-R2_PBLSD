module memoria_compartilhada(endereco, indata, controle, lerMem, escMem, clock, output_mem);

  input [31:0] endereco,indata;
  input controle, lerMem, escMem, clock;
  output [31:0] output_mem;
  reg [31:0] dados[511:0];// matriz dos dados
  reg [31:0] instrucoes[511:0];
  reg [31:0] output_mem;

  if(controle && clock)
    begin
    always@(endereco,indata,escMem,lerMem)
    if(escMem)
    begin
    regfile[endereco]<=indata; //memory write
    end
    always@(endereco,indata,escMem,lerMem)
    if(lerMem)
    begin
    output_mem <= dados[endereco];//memory read
     end
    end

  else if (~controle && clock)
  begin
    assign output_mem = instrucoes[endereco];

    end



endmodule
