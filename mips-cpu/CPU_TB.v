module CPU_TB;

 reg Clock;
 initial begin
 Clock = 1;
 end
 //clock controls
 always begin
 Clock = ~Clock;
 #25;
 end
reg [31:0]binary[0:1];
 initial begin

 // Instr Memory intialization
  $readmemb("tb.input", binary); //só tem o binário de um add
  $display("Binary: %b", binary[0][31:0]);
  cpu.memoria.memoryFiles[0] = binary[0][31:0];
  $display("memoryFiles: %b", cpu.memoria.memoryFiles[0]);
 end
 //Instantiate cpu
CPU cpu(Clock);

endmodule