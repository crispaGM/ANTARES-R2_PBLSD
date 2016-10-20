module TOP_LEVEL(clock,reset,saida);
input clock,reset;
output [31:0]saida;

wire[31:0]mem_saida,address_out,dadoW_out;
wire lerMem_out, escMem_out;


CPU cpu(
  .clock(clock),
  .reset(reset),
  .mem_out(mem_saida),
  .address_out(addres_out),
  .lerMem_out ( lerMem_out),
  .escMem_out (escMem_out)


);

memoria_compartilhada memoria(

 .endereco(addres_out),
 .indata(dadoW_out),
 .lerMem(lerMem_out), 
 .escMem(escMem_out), 
 .clock(clock), 
 .output_mem(mem_saida)
);





endmodule