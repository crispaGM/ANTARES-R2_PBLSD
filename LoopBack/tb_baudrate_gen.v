module tb_baudrate_gen;

reg sysclk;
reg reset_n;
wire half_baud_rate_tick_o;
wire baud_rate_tick_o;

initial begin
    $from_myhdl(
        sysclk,
        reset_n
    );
    $to_myhdl(
        half_baud_rate_tick_o,
        baud_rate_tick_o
    );
end

baudrate_gen dut(
    sysclk,
    reset_n,
    half_baud_rate_tick_o,
    baud_rate_tick_o
);

endmodule
