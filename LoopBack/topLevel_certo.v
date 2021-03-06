
module topLevel_certo(
	input CLOCK_50,
	input UART_Rx,
	input start_bit,
	output UART_Tx
	);

	wire [7:0] loopBack;
	wire baud;

serial_tx serial_tx_inst(

	.sysclk(CLOCK_50),
	.reset_n(1'b1),
	.start_i(start_bit),
	.data_i(loopBack),
	.baud_rate_tick_i(baud),
	.transmit_o(UART_Tx)
	);


baudrate_gen baudarate_gen_inst(

      .sysclk(CLOCK_50),
      .reset_n(1'b1),
      .baud_rate_tick_o(baud)


);


serial_rx serial_rx_inst(

	.sysclk(CLOCK_50),
	.reset_n(1'b1),
	.half_baud_rate_tick_i(baud),
	.baud_rate_tick_i(baud),
	.receive_i(UART_Rx),
	.data_o(loopBack)





);




endmodule