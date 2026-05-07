module uart_rx(input rst,clk,en,rx,
               output reg [7:0] d_out,
               output reg done);
  reg [1:0] state;
  parameter idle_state  = 2'b00;
  parameter start_state = 2'b01;
  parameter data_state  = 2'b10;
  parameter stop_state  = 2'b11;
  reg [2:0] index;
  always @(posedge clk)
    begin
      if(rst)
        begin
          state <= idle_state;
          index <= 0;
          d_out <= 8'b0;
          done  <= 0;
        end
      else
        begin
          case(state)
            idle_state :
              begin
                done <= 0;
                if(rx == 0)
                  state <= start_state;
              end
            start_state :
              begin
                if(en)
                  begin
                    index <= 0;
                    state <= data_state;
                  end
              end
            data_state :
              begin
                if(en)
                  begin
                    d_out[index] <= rx;
                    if(index == 3'b111)
                      state <= stop_state;
                    else
                      index <= index + 1;
                  end
              end
            stop_state :
              begin
                if(en)
                  begin
                    done  <= 1;
                    state <= idle_state;
                  end
              end
            default :
              begin
                state <= idle_state;
              end
          endcase
        end
    end
endmodule
