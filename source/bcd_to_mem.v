`timescale 1ns / 1ps

module bcd_to_mem(
    input clk,
    input [7:0] sec_bcd,
    input [7:0] min_bcd,
    input [7:0] hour_bcd,
    input [7:0] days_bcd,
    input [7:0] months_bcd,
    input [7:0] years_bcd,
    output reg [3:0] addr,
    output reg [7:0] data_out,
    output reg write_en
    );
    
    parameter seconds_register_addr = 0;
    parameter minutes_register_addr = 1;
    parameter hours_register_addr = 2;
    parameter days_register_addr = 3;
    parameter months_register_addr = 4;
    parameter years_register_addr = 5;
    
    integer clock_counter = 0;
    
    always @ (posedge clk) begin
        write_en = 0;
        case (clock_counter)
            0: begin
                    addr = seconds_register_addr;
                    data_out = sec_bcd;
                    write_en = 1;
                    clock_counter = clock_counter + 1;
                end
            1: begin
                   addr = minutes_register_addr;
                   data_out = min_bcd;
                   write_en = 1;
                   clock_counter = clock_counter + 1;
                end
            2: begin
                  addr = hours_register_addr;
                  data_out = hour_bcd;
                  write_en = 1;
                  clock_counter = clock_counter + 1;
                end
             3: begin
                    addr = days_register_addr;
                    data_out = days_bcd;
                    write_en = 1;
                    clock_counter = clock_counter + 1;
                end 
             4: begin
                   addr = months_register_addr;
                   data_out = months_bcd;
                   write_en = 1;
                   clock_counter = clock_counter + 1;
                end
             5: begin
                    addr = years_register_addr;
                    data_out = years_bcd;
                    write_en = 1;
                    clock_counter = clock_counter + 1;
                end
              6: begin
                    clock_counter = 0;  
                end
        endcase
    end
endmodule
