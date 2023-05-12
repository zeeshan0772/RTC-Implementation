`timescale 1ns / 1ps

module mem_mux_tb;
    // Inputs
    reg clk;
    reg [3:0] addr;
    reg [7:0] data_out;
    reg write_en;
    reg [3:0] i2c_addr;
    reg i2c_read_en;
    
    // Outputs
    wire [3:0] reg_addr;
    wire [7:0] data_in;
    wire reg_write_en;

    // Instantiate the Unit Under Test (UUT)
    mem_mux uut (
        .clk(clk),
        .addr(addr),
        .data_out(data_out),
        .write_en(write_en),
        .i2c_addr(i2c_addr),
        .i2c_read_en(i2c_read_en),
        .reg_addr(reg_addr),
        .data_in(data_in),
        .reg_write_en(reg_write_en)
    );

    // Clock
    always #5 clk = ~clk; // 200 MHz clock

    // Test case 1 - write to register file
    initial begin
        clk = 0;
        
        #5
        addr = 0;
        data_out = 10;
        write_en = 1;
        i2c_addr = 0;
        i2c_read_en = 0;
        #10;
        write_en = 0;
        
        #10
        addr = 1;
        data_out = 15;
        write_en = 1;
        i2c_addr = 0;
        i2c_read_en = 0;
        #10;
        write_en = 0;
        
        // Read from written addresses
        #10
        addr = 2;
        data_out = 0;
        write_en = 0;
        i2c_addr = 0;
        i2c_read_en = 1;
        #10;
        i2c_read_en = 0;
        
        #50
        $finish;        
    end
endmodule
