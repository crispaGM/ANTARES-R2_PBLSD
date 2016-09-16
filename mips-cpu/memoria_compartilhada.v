module memoria_compartilhada(endereco, indata, lerMem, escMem, clock, output_mem);
input [31:0] endereco,indata;
input lerMem,escMem, clock;
output [31:0] output_mem;
reg [31:0] memoryFiles[511:0];// matriz dos dados na memória
reg [31:0] output_mem;

  always@(endereco,indata,escMem,lerMem)
    begin
    if(escMem && clock)
      begin
      memoryFiles[endereco]<=indata; //memory write
      end
    if(lerMem && clock)
      begin
      output_mem <= memoryFiles[endereco];//memory read
      end
  end
endmodule
