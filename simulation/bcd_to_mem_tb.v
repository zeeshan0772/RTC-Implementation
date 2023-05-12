`timescale 1ns/1ps

module bcd_to_mem_tb;

    // Inputs
    reg clk;
    reg [7:0] sec_bcd;
    reg [7:0] min_bcd;
    reg [7:0] hour_bcd;
    reg [7:0] days_bcd;
    reg [7:0] months_bcd;
    reg [7:0] years_bcd;
    
    // Outputs
    wire [3:0] addr;
    wire [7:0] data_out;
    wire write_en;
    
    // Instantiate the Unit Under Test (UUT)
    bcd_to_mem uut (
        .clk(clk),
        .sec_bcd(sec_bcd),
        .min_bcd(min_bcd),
        .hour_bcd(hour_bcd),
        .days_bcd(days_bcd),
        .months_bcd(months_bcd),
        .years_bcd(years_bcd),
        .addr(addr),
        .data_out(data_out),
        .write_en(write_en)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialize inputs
        clk = 0;
        sec_bcd = 0;
        min_bcd = 0;
        hour_bcd = 0;
        days_bcd = 0;
        months_bcd = 0;
        years_bcd = 0;
        #5;
        
        // Testcase 1
        sec_bcd = 32;
        min_bcd = 45;
        hour_bcd = 12;
        days_bcd = 7;
        months_bcd = 2;
        years_bcd = 21;
        // Wait for some more time to allow the DUT to stabilize
        #150;
        
        $finish;
    end
endmodule
