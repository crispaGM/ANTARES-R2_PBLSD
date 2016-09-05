module adder_PC_4 (pcout, pcin);
	input [31:0] pcin;
	output reg [31:0] pcout;

	assign pcout = pcin + 3'd1;
endmodule
