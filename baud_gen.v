module uart_br(input clk,rst,
               output tx_en,rx_en);
  reg [12:0] tx_counter;
  reg [9:0] rx_counter;
  always @(posedge clk)
    begin
      if(rst==1)
        tx_counter<=0;
      else
        begin
          if(tx_counter==527)
            tx_counter<=0;
          else
            tx_counter<=tx_counter+1;
        end
    end
  always @(posedge clk)
    begin
      if(rst==1)
        rx_counter<=0;
      else
        begin
          if(rx_counter==527)
            rx_counter<=0;
          else
            rx_counter<=rx_counter+1;
        end
    end
  assign tx_en=(tx_counter==0) ? 1'b1 : 1'b0;
  assign rx_en=(rx_counter==0) ? 1'b1 : 1'b0;
endmodule
