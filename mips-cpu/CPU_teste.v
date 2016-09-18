module CPU_test;

 reg Clock;
 integer i;
 initial begin
 Clock = 1;
 end
 //clock controls
 always begin
 Clock = ~Clock;
 #25;
 end

 initial begin

 // Instr Memory intialization
  $readmemb("tb.input",pipelined.memoria.memoryFiles); 

 

 pipelined.registradores.memoryFiles[0] = 0;
 // Register File initialization
 for (i = 0; i < 32; i = i + 1)
 pipelined.registradores.memoryFiles[i] = 32'd0;
 end
 //Instantiate cpu
CPU pipelined(Clock);

endmodule