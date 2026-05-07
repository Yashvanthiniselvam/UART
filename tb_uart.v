module tb_uart;
  reg clk,rst,wr_en;
  reg [7:0] d_in;
  wire [7:0] d_out;
  wire done;
  wire tx;    
  uart_top dut(.clk(clk),.rst(rst),.wr_en(wr_en),.d_in(d_in),.d_out(d_out),
        .done(done),.tx(tx));
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    rst   = 1;
    wr_en = 0;
    d_in  = 8'h00;
    #20 rst=0;
    #20 d_in  = 8'hA5;wr_en = 1;
    #10 wr_en = 0;
    #70000 $finish;
  end
  initial begin
    $monitor("time=%0t rst=%b wr_en=%b d_in=%h tx=%b d_out=%h done=%b",
                  $time,rst,wr_en,d_in,tx,d_out,done);
  end
  initial begin
    $dumpfile("uart.vcd");
    $dumpvars(0,tb_uart);
  end
endmodule
