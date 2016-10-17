module controlador(clock,address_in,data_in,rw,data_out,data_device,rw_out,address_out);
input clock,rw;
input [31:0] address_in,data_in;
output[31:0] data_out,data_device,address_out;
output rw_out;
wire rw_out;
reg [31:0] dado;
reg [1:0] status;
reg [31:0] data_out,data_device,address_out;
assign rw_out = rw;

always @(posedge clock && rw)
begin

if(address_in [15:0]== 16'b1111111111111111)
 begin
 dado = data_in;
 status  = 2'b1;
 data_device = dado;
 data_out = status;
 address_out =  16'b1111111111111110;
 end

else
begin

data_out = data_in;
address_out = address_in;
 
end



end





endmodule