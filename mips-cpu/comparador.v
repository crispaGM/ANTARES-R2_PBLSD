module comparator(a,b, equal, lower, greater);
    input  [31:0] a,b;
    output equal, lower, greater;
    reg equal, lower, greater;


    always @(a or b)
     begin
      if (a<b) begin
        equal = 0;
        lower = 1;
        greater = 0;
      end
      else if (a==b) begin
        equal = 1;
        lower = 0;
        greater = 0;
      end
      else begin
        equal = 0;
        lower = 0;
        greater = 1;
      end
    end
endmodule
