module monitor(clock,reset,position,gatilho);

input clock, reset,position;
output gatilho;




  always @ (posedge clock or posedge reset or position) begin
    if (reset)
      state = 2'b00
      gatilho = 1'0;
    else
    begin
      case (state)
        2'b00:
        begin
         if(position)
         state = 2'b01
          end
        2'b01:
        begin
          gatilho = 1'b1
          state = 2'b00;
        end
       
      endcase
    end
  end

endmodule
