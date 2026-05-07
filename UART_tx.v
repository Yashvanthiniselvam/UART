module uart_tx(input rst,clk,wr_en,en,
               input [7:0]d_in,
               output reg tx,
               output busy);
  reg [1:0]state;
  parameter idle_state=2'b00;
  parameter start_state=2'b01;
  parameter data_state=2'b10;
  parameter stop_state=2'b11;
  reg [7:0]data;
  reg [2:0]index;
  always @(posedge clk)
    begin
      if(rst==1)
        begin
          tx<=1'b1;
          state<=idle_state;
          index<=0;
        end
      else
        begin
          case(state)
            idle_state :
              begin
                tx<=1'b1;
                if(wr_en==1)
                  begin
                    data<=d_in;
                    index<=3'b000;
                    state<=start_state;
                  end
              end
            start_state : 
              begin
                if(en==1)
                  begin
                    tx<=1'b0;
                    state<=data_state;
                  end
              end
            data_state :
              begin
                if(en)
                  begin
                    tx<=data[index];
                    if(index==3'b111)
                      state<=stop_state;
                    else
                      index<=index+1;
                  end
              end
            stop_state :
              begin
                if(en==1)
                  begin
                    tx<=1'b1;
                    state<=idle_state;
                  end
              end
            default :
              begin
                tx<=1'b1;
                state<=idle_state;
              end
          endcase
        end
    end
  assign busy=(state != idle_state);
endmodule
