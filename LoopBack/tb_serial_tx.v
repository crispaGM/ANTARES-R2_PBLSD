module tb_serial_tx;

reg sysclk;
reg reset_n;
reg start_i;
reg [7:0] data_i;
reg baud_rate_tick_i;
wire transmit_o;

initial begin
    $from_myhdl(
        sysclk,
        reset_n,
        start_i,
        data_i,
        baud_rate_tick_i
    );
    $to_myhdl(
        transmit_o
    );
end

serial_tx dut(
    sysclk,
    reset_n,
    start_i,
    data_i,
    baud_rate_tick_i,
    transmit_o
);

endmodule
