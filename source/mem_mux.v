`timescale 1ns / 1ps

module mem_mux(
    input clk,
    input [3:0] addr,
    input [7:0] data_out,
    input write_en,
    input [3:0] i2c_addr,
    input i2c_read_en,
    output reg [3:0] reg_addr,
    output reg [7:0] data_in,
    output reg reg_write_en,
    output reg reg_read_en
    );
    
    always @ (posedge clk) begin
        reg_read_en = 0;
        reg_write_en = 0;
        if (i2c_read_en == 1) begin   // if read signal by i2c is asserted
            // let the i2c read the data pointed by i2c_addr
            reg_addr = i2c_addr;
            data_in = 0;
            reg_read_en = 1;
            reg_write_en = 0;
            
        end else if (write_en == 1) begin
            // let the data from other bcd_to_mem module to pass through
            reg_addr = addr;    // address from bcd_to_mem module
            data_in = data_out; // data_out is form bcd_to_mem module
            reg_write_en = 1;
            reg_read_en = 0;
        end
    end
endmodule
