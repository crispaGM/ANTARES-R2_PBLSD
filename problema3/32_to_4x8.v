module 32_to_4x8(clock,reset, indata, outdata);

input clock, reset;
input [31:0] indata;
output [0:7] outdata;

reg [7:0] outdata;
reg [1:0]state;

  always @ (posedge clock or posedge reset) begin
    if (reset)
      state = 2'b00
    else
    begin
      case (state)
        2'b00:
        begin
          outdata = indata[7:0];
          state = 2'b01;
        end
        2'b01:
        begin
          outdata = indata[15:8];
          state = 2'b10;
        end
        2'b10:
        begin
          outdata = indata[23:16];
          state = 2'b11;
        end
        2'b11:
        begin
          outdata = indata[31:24];
          state = 2'b00;
        end
      endcase
    end
  end

endmodule
