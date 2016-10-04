
module topLevel(
	input clock_50MHz,
	input UART_Rx,
	output UART_Tx
	);

	reg [7:0] loopBack;
	wire canSend;

async_receiver RECEIVER(

	.clk(clk),.RxD(RxD), 


	.RxD_data_ready(canSend),.RxD_data(RxD_data),.RxD_idle()
	);

always @(posedge clk) if(canSend) loopBack <= RxD_data;

async_transmitter TRANSMITTER(
	.clk(clk),
	.TxD_start(canSend),
	.TxD_data(loopBack),

	.TxD(TxD),
	.TxD_busy()
	);

endmodule