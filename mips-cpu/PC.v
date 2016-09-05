module PC (
   output reg [31:0] PC,             // Output of pc_mod
   input wire [31:0] npc             // Input of pc_mod
   );

   initial begin
      PC <= 0;
   end
   always @ ( npc) begin
      #1 PC <= npc;
   end

endmodule // pc_mod
