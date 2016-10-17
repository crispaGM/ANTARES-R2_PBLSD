module Controlador_Device(CLOCK_50,data_out,data_device,rw_out,address_out);
input CLOCK_50;
reg rw;
reg [31:0] address_in,data_in;
output [31:0] data_out,data_device,address_out;
output rw_out;
reg [31:0] dado;
reg [1:0] status;
integer i;

 
controlador control (
.clock(CLOCK_50),
.address_in(address_in),
.data_in(data_in),
.rw(rw),
.data_out(data_out),
.data_device(data_device),
.rw_out(rw_out),
.address_out(address_out)




);

always@(posedge CLOCK_50)
begin


address_in = 32'b11111111111111111111111111111111;
  data_in = 32'b10;
  rw = 1;



$display("Data_device: %b", data_device);
$display("Data_out: %b", data_out);
$display("RW_out: %b", rw_out);


  





end








endmodule