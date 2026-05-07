module uart_top(input clk,rst,wr_en,
                input [7:0] d_in,
                output [7:0] d_out,
                output done,tx);
  wire tx_en;
  wire rx_en;
  wire tx_line;
  uart_br br1(.clk(clk),.rst(rst),.tx_en(tx_en),.rx_en(rx_en));
  uart_tx tx1(.rst(rst),.clk(clk),.wr_en(wr_en),.en(tx_en),.d_in(d_in),
              .tx(tx_line),.busy());
  uart_rx rx1(.rst(rst),.clk(clk),.en(rx_en),.rx(tx_line),.d_out(d_out),
              .done(done));
  assign tx = tx_line;
endmodule
            
  
  
