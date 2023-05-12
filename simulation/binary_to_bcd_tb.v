`timescale 1ns / 1ps

module binary_to_bcd_tb;
    reg clk;
    reg [7:0] sec;
    reg [7:0] min;
    reg [7:0] hour;
    reg [7:0] days;
    reg [7:0] months;
    reg [7:0] years;
    
    wire [7:0] sec_bcd;
    wire [7:0] min_bcd;
    wire [7:0] hour_bcd;
    wire [7:0] days_bcd;
    wire [7:0] months_bcd;
    wire [7:0] years_bcd;
    
    binary_to_bcd dut(.clk(clk), 
            .sec(sec),
            .min(min),
            .hour(hour),
            .days(days),
            .months(months),
            .years(years), 
            .sec_bcd(sec_bcd),
            .min_bcd(min_bcd),
            .hour_bcd(hour_bcd),
            .days_bcd(days_bcd),
            .months_bcd(months_bcd),
            .years_bcd(years_bcd)
            );

    integer temp;
    initial begin
        // initialize inputs
        clk = 0;
        sec = 0;
        min = 0;
        hour = 0;
        days = 0;
        months = 0;
        years = 0;
        
        #10
        temp = 1; 
        sec = temp;
        min = temp;
        hour = temp;
        days = temp;
        months = temp;
        years = temp;

        
        #10
        temp = 2; 
        sec = temp;
        min = temp;
        hour = temp;
        days = temp;
        months = temp;
        years = temp;

        
        #10
        temp = 4; 
        sec = temp;
        min = temp;
        hour = temp;
        days = temp;
        months = temp;
        years = temp;
        
        
        #10
        temp = 25; 
        sec = temp;
        min = temp;
        hour = temp;
        days = temp;
        months = temp;
        years = temp;
        
        #10
        temp = 40; 
        sec = temp;
        min = temp;
        hour = temp;
        days = temp;
        months = temp;
        years = temp;
        
        #10
        temp = 50; 
        sec = temp;
        min = temp;
        hour = temp;
        days = temp;
        months = temp;
        years = temp;
        
        #10
        temp = 59; 
        sec = temp;
        min = temp;
        hour = temp;
        days = temp;
        months = temp;
        years = temp;
        
        #10 $finish;
    end

    always #5 clk = ~clk;
endmodule
