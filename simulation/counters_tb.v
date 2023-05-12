`timescale 1ns / 1ps

module counters_tb;
    
    // Inputs
    reg clk;
    reg [3:0] i2c_addr;
    reg [15:0] data_out;
    reg i2c_write_en;
    
    // Outputs
    wire [7:0] sec;
    wire [7:0] min;
    wire [7:0] hour;
    wire [7:0] days;
    wire [7:0] months;
    wire [7:0] years;
        
    
    // Instantiate the Unit Under Test (UUT)
    counters uut (
        .clk(clk), 
        .i2c_addr(i2c_addr), 
        .data_out(data_out), 
        .i2c_write_en(i2c_write_en), 
        .sec(sec),
        .min(min),
        .hour(hour),
        .days(days),
        .months(months),
        .years(years)
    );
    
    parameter base_clock = 1;
    parameter clk_delay = 1;
    parameter delay = 10;
    initial begin
        // Initialize Inputs
        clk = 0;
        i2c_addr = 0;
        data_out = 0;
        i2c_write_en = 0;
        
        #500;
        // *** TEST: PASSED ***
        // test the i2c overwrites 
        // write the second counting register 
        i2c_addr = 0;   // address of second countign register
        data_out = 33;  // write 33 to second counting register
        i2c_write_en = 1;
        #3;
        i2c_write_en = 0;
        
        // *** TEST ENDS **
        
        // *** TEST: PASSED***
        #200
        // Write to min count register
        i2c_addr = 1;
        data_out = 58;  // write 58 to min counting reg
        i2c_write_en = 1;
        #3;
        i2c_write_en = 0;
        // *** TEST ENDS ***
        
        // *** TEST: Passed ***
        #200
        // Write to hour count register
        i2c_addr = 2;
        data_out = 5;  // write 5 to hour counting reg
        i2c_write_en = 1;
        #3;
        i2c_write_en = 0;
        // *** TEST ENDS ***

        // *** TEST: PASSED***
        #200
        // Write to day count register
        i2c_addr = 3;
        data_out = 21;  // write 5 to hour counting reg
        i2c_write_en = 1;
        #3;
        i2c_write_en = 0;
        // *** TEST ENDS ***

        // *** TEST: PASSED ***
        #200
        // Write to month count register
        i2c_addr = 4;
        data_out = 11;  // write 11 to month counting reg
        i2c_write_en = 1;
        #3;
        i2c_write_en = 0;
        // *** TEST ENDS ***

        // *** TEST:  ***
        #200
        // Write to year count register
        i2c_addr = 5;
        data_out = 2030;  // write 2030 to month counting reg
        i2c_write_en = 1;
        #3;
        i2c_write_en = 0;
        // *** TEST ENDS ***
        #200;
        $finish;
    end

    // Clock generator
    always #clk_delay clk = ~clk;
    
endmodule
