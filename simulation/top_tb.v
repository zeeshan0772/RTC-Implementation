`timescale 1ns / 1ps

module top_tb;
// inputs
reg clk;
reg [3:0] i2c_addr;
reg [7:0] i2c_data_in;
reg i2c_write_en;
reg i2c_read_en;

// outputs
wire [7:0] reg_data_out;
// UUT
top uut(
    clk,
    i2c_addr,
    i2c_data_in,
    i2c_write_en,
    i2c_read_en,
    reg_data_out
    );
    
    initial begin
    // initialize inputs
        clk = 0;
        i2c_addr = 0;
        i2c_data_in = 0;
        i2c_write_en = 0;
        i2c_read_en = 0;
        
        #100;
        
        
        i2c_addr = 4;
        i2c_read_en = 1;
        #10
        i2c_read_en = 0;
        
        #100
        $finish;
    end
    
    always #5 clk = ~clk;
    
endmodule
