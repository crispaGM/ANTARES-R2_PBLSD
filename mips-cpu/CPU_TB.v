module CPU_TB;

 reg Clock;
 initial begin
 Clock = 1;
 end
 //clock controls
 always begin
 Clock = ~Clock;
 #10;
 end
reg [31:0]binary[0:2];
 initial begin
   cpu.PC = 0;
 // Instr Memory intialization
  $readmemb("tb.input", binary); //só tem o binário de um add
  $display("Binary: %b", binary[0][31:0]);
  cpu.memoria.memoryFiles[0] = binary[0][31:0];
   cpu.memoria.memoryFiles[4] = binary[1][31:0];
  $display("memoryFiles: %b", cpu.memoria.memoryFiles[0]);
    $display("memoryFiles: %b", cpu.memoria.memoryFiles[1]);
 



 end
 //Instantiate cpu
CPU cpu(Clock);

endmodule