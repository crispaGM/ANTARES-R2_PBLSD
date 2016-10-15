module 32_to_40(clock,reset, indata, outdata);
  input clock, reset;
  input [31:0] indata;
  output reg [39:0] outdata;

  if(reset)
    output <= 30'b0;
  else
  outdata <= {1'b0, indata[7:0], 1'b1, 1'b0, indata[15:8], 1'b1, 1'b0, indata[23:16], 1'b1, 1'b0, indata[31:24], 1'b1};
endmodule
