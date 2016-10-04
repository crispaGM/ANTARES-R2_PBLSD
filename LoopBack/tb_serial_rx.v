module tb_serial_rx;

reg sysclk;
reg reset_n;
reg half_baud_rate_tick_i;
reg baud_rate_tick_i;
reg recieve_i;
wire [7:0] data_o;
wire ready_o;

initial begin
    $from_myhdl(
        sysclk,
        reset_n,
        half_baud_rate_tick_i,
        baud_rate_tick_i,
        recieve_i
    );
    $to_myhdl(
        data_o,
        ready_o
    );
end

serial_rx dut(
    sysclk,
    reset_n,
    half_baud_rate_tick_i,
    baud_rate_tick_i,
    recieve_i,
    data_o,
    ready_o
);

endmodule
