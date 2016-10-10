module controlador_Dispositivo(clock,address_in, data_in,address_out,data_out,data_device);
input clock;
input [31:0] address_in,data_in;
output [31:0] address_out,data_out,data_device;

always(psedge clock)
begin

if(address_in == 900000)
 begin
data_out = 1'b1;
address_out = 65536;
data_device = data_in;

 end

else
begin

data_out = data_in;
address_out = address_in;


end



end





endmodule