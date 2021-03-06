// File: serial_rx.v
// Generated by MyHDL 0.9.0
// Date: Sun Oct  2 19:35:50 2016


`timescale 1ns/10ps

module serial_rx (
    sysclk,
    reset_n,
    half_baud_rate_tick_i,
    baud_rate_tick_i,
    receive_i,
    data_o,
    ready_o
);


input sysclk;
input reset_n;
input half_baud_rate_tick_i;
input baud_rate_tick_i;
input receive_i;
output [7:0] data_o;
wire [7:0] data_o;
output ready_o;
wire ready_o;

reg [7:0] data_reg;
reg [2:0] count_8_bits_reg;
reg [7:0] data;
reg [2:0] count_8_bits;
reg ready;
reg [1:0] state;
reg [2:0] count_stop_bits_reg;
reg [2:0] count_stop_bits;
reg [1:0] state_reg;
reg ready_reg;






assign data_o = data_reg;
assign ready_o = ready_reg;


always @(posedge sysclk, negedge reset_n) begin: SERIAL_RX_SEQUENTIAL_PROCESS
    if (reset_n == 0) begin
        count_8_bits_reg <= 0;
        count_stop_bits_reg <= 0;
        ready_reg <= 0;
        state_reg <= 2'b00;
        data_reg <= 0;
    end
    else begin
        state_reg <= state;
        data_reg <= data;
        ready_reg <= ready;
        count_8_bits_reg <= count_8_bits;
        count_stop_bits_reg <= count_stop_bits;
    end
end


always @(count_8_bits_reg, receive_i, data_reg, baud_rate_tick_i, count_stop_bits_reg, state_reg, ready_reg) begin: SERIAL_RX_COMBINATIONAL_PROCESS
    state = state_reg;
    data = data_reg;
    ready = ready_reg;
    count_8_bits = count_8_bits_reg;
    count_stop_bits = count_stop_bits_reg;
    case (state_reg)
        2'b00: begin
            ready = 1'b0;
            if ((baud_rate_tick_i == 1'b1)) begin
                if ((receive_i == 1'b0)) begin
                    state = 2'b01;
                end
            end
        end
        2'b01: begin
            if ((baud_rate_tick_i == 1'b1)) begin
                data[count_8_bits_reg] = receive_i;
                if ((count_8_bits_reg == 7)) begin
                    count_8_bits = 0;
                    state = 2'b10;
                end
                else begin
                    count_8_bits = (count_8_bits_reg + 1);
                    state = 2'b01;
                end
            end
        end
        2'b10: begin
            if ((baud_rate_tick_i == 1'b1)) begin
                if (($signed({1'b0, count_stop_bits_reg}) == (2 - 1))) begin
                    count_stop_bits = 0;
                    ready = 1'b1;
                    state = 2'b00;
                end
                else begin
                    count_stop_bits = (count_stop_bits_reg + 1);
                end
            end
        end
        default: begin
            $finish;
        end
    endcase
end

endmodule
