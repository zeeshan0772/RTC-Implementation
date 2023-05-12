`timescale 1ns / 1ps

module top(
    input clk,  // input clock, 32768 Hz
    input [3:0] i2c_addr,
    input [7:0] i2c_data_in,
    input i2c_write_en,
    input i2c_read_en,
    output [7:0] reg_data_out

    );
    
    wire [7:0] bcd_to_binary_converted_data;
    wire [7:0] sec;
    wire [7:0] min;
    wire [7:0] hour;
    wire [7:0] days;
    wire [7:0] months;
    wire [7:0] years;
    wire [7:0] sec_bcd;
    wire [7:0] min_bcd;
    wire [7:0] hour_bcd;
    wire [7:0] days_bcd;
    wire [7:0] months_bcd;
    wire [7:0] years_bcd;
    
    wire [3:0] addr;    // output address from bcd_to_mem module
    wire [7:0] data_out;    // data output in bcd tom bcd_to_mem module
    wire write_en;  // write signal from bcd_to_mem module
    
    wire [3:0] reg_addr;
    wire [7:0] data_in;
    wire reg_write_en;
    wire reg_read_en;
    
    // instantiate the bcd_to_binary module here
    bcd_to_binary inst_1(
        clk, 
        i2c_data_in, 
        bcd_to_binary_converted_data
        );
    
    // instantiate counters module
    // all the outputs of counter module are in **binary**
    counters counter_inst_1(
        clk, 
        i2c_addr,
        bcd_to_binary_converted_data,
        i2c_write_en,
        sec,
        min,
        hour,
        days,
        months,
        years
        );
    
    // instantiate binary_to_bcd module
    binary_to_bcd to_bcd_inst(
        clk,
        sec,
        min,
        hour,
        days,
        months,
        years,
        sec_bcd,
        min_bcd,
        hour_bcd,
        days_bcd,
        months_bcd,
        years_bcd
        );
    
    // instantiate bcd_to_mem module
    bcd_to_mem bcd_to_mem_inst(
        clk,
        sec_bcd,
        min_bcd,
        hour_bcd,
        days_bcd,
        months_bcd,
        years_bcd,
        addr,
        data_out,
        write_en
        );
     // instantiate the mem_mux module here
     mem_mux mem_mux_inst(
        clk,
        addr,
        data_out,
        write_en,
        i2c_addr,
        i2c_read_en,
        reg_addr,
        data_in,
        reg_write_en,
        reg_read_en
        );
    
        
    register_file register_file_inst(
        clk,
        reg_addr,
        data_in,
        reg_write_en,
        reg_read_en,
        reg_data_out
        );
        
    always @ (posedge clk) begin 
    
    end

endmodule
