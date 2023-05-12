`timescale 1ns / 1ps

module counters(
    input wire clk,
    input [3:0] i2c_addr,
    input [7:0] data_out,   // data from bcd to binary converter
    input i2c_write_en,
    output wire [7:0] sec,
    output wire [7:0] min,
    output wire [7:0] hour,
    output wire [7:0] days,
    output wire [7:0] months,
    output wire [7:0] years
    );
    
    reg [7:0] sec_count_reg = 0;    // register for storing seconds
    reg [7:0] min_count_reg = 0;    // register for storing minutes
    reg [7:0] hour_count_reg = 0;    // register for storing hours
    reg [7:0] day_count_reg = 1;    // register for storing days
    reg [7:0] month_count_reg = 1;    // register for storing months
    reg [15:0] year_count_reg = 2023;    // register for storing years
            
    parameter sec_register_addr = 0;    // address of seconds register
    parameter min_register_addr = 1;    // address of minutes register
    parameter hour_register_addr = 2;   // address of hours register    * hours are in 24-hour format
    parameter day_register_addr = 3;   // address of days register
    parameter month_register_addr = 4;   // address of months register
    parameter year_register_addr = 5;   // address of years register
    
    // "A year is a leap year if it is divisible by 4, except for years that are divisible by 100 but not by 400. 
    // Years that are divisible by 400 are always leap years."
    // Here are some examples to illustrate this rule:
    // The year 2000 was a leap year, because it was divisible by 4 and by 400.
    // The year 1900 was not a leap year, because it was divisible by 4 and by 100 but not by 400.
    // The year 2024 will be a leap year, because it is divisible by 4 and is not divisible by 100 (or 400).
    // The year 2100 will not be a leap year, because it is divisible by 4 and by 100 but not by 400.

    reg is_leap_year;   // it's value is 1 if the year is a leap year otherwise 0.
    parameter base_clock = 1;   // base clock
    integer div = 0;    // clock divider. it divides the base clock into 1 second
    
    // constants indicating the months number
    // later used in case statement
    parameter jan = 1;
    parameter feb = 2;
    parameter mar = 3;
    parameter april = 4;
    parameter may = 5;
    parameter june = 6;
    parameter july = 7;
    parameter aug = 8;
    parameter sep = 9;
    parameter oct = 10;
    parameter nov = 11;
    parameter dec = 12;
    
    // counter
    // it triggers on every clock tick
    always @ (posedge clk) begin
    // if the write signal from i2c is asserted then overwrite the register
        if (i2c_write_en == 1) begin
            case (i2c_addr)
            sec_register_addr: begin 
                sec_count_reg = data_out; 
                div = 0;
             end
            // overwrite the minutes register if it's address is on addr bus
            min_register_addr: begin 
                min_count_reg = data_out;
            end
            // overwrite the hour register if it's address is on addr bus
            hour_register_addr: begin
                hour_count_reg = data_out;
            end
            
            // overwrite the day register if it's address is on addr bus
            day_register_addr: begin
                day_count_reg = data_out;
            end

            // overwrite the month register if it's address is on addr bus
            month_register_addr: begin
                month_count_reg = data_out;
            end
            
            // overwrite the year register
            year_register_addr: begin
                year_count_reg = data_out + 2000;
            end
                
            // if the address was invalid, then increment the second counter register
            // because we don't want invalid addresses to halt counter register increments
            default: begin
                    if (div == base_clock) begin
                        div = 0;
                        // number of seconds should be 00-59
                        if (sec_count_reg < 59) begin
                            sec_count_reg = sec_count_reg + 1;
                        end else begin
                            sec_count_reg = 0;
                        end

                        // increment minutes counter
                        // keep the counter value in between 00-59
                        if (sec_count_reg == 59) begin
                            // increment the minute counter if minutes are in this range 00-59
                            if (min_count_reg < 59) begin
                                min_count_reg = min_count_reg + 1;
                            end else begin
                                min_count_reg = 0;
                            end
                        end 

                        // increment hour register
                        // keep check on register value
                        // value should not exceed 00-23
                        
                        // counter format : min: sec, 0:0,
                        if (sec_count_reg == 0) begin
                            if (min_count_reg == 0) begin
                                if (hour_count_reg < 23) begin
                                    hour_count_reg = hour_count_reg + 1;    
                                end else begin
                                    hour_count_reg = 0;
                                end
                            end
                        end 
                                                                    
                // increment days and months
                        if (sec_count_reg == 0) begin
                            if (min_count_reg == 0) begin
                                if (hour_count_reg == 0) begin
                                
                                    case (month_count_reg)
                                        jan: begin
                                            if (day_count_reg < 31) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end
                                        end
                                        
                                        feb: begin
                                            // leaps years
                                            // compensate for leap years
                                            if (year_count_reg % 4 == 0 && (year_count_reg % 100 != 0 || year_count_reg % 400 == 0)) begin
                                                is_leap_year = 1; // write 1 to leap_year if year is a leap year
                                            end 
                                            else begin
                                                is_leap_year = 0; // write 0 to leap_year if year is not a leap year
                                            end
                                                  
                                            case(is_leap_year)
                                                // if it's not a leap year
                                                0: begin 
                                                    if (day_count_reg < 28) begin
                                                        day_count_reg = day_count_reg + 1;    
                                                    end else begin
                                                        day_count_reg = 1;
                                                        month_count_reg = month_count_reg + 1;
                                                    end 
                                                end
                                                
                                                // if it's a leap year
                                                1: begin
                                                    if (day_count_reg < 29) begin
                                                        day_count_reg = day_count_reg + 1;    
                                                    end else begin
                                                        day_count_reg = 1;
                                                        month_count_reg = month_count_reg + 1;
                                                    end 
                                                end
                                            endcase
                                        end
                                        
                                        mar: begin
                                            if (day_count_reg < 31) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
        
                                        april: begin
                                            if (day_count_reg < 30) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
        
                                        may: begin
                                            if (day_count_reg < 31) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                                                       
                                        june: begin
                                            if (day_count_reg < 30) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                        
                                        july: begin
                                            if (day_count_reg < 31) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
        
                                        aug: begin
                                            if (day_count_reg < 31) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                                      
                                        sep: begin
                                            if (day_count_reg < 30) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                        
                                        oct: begin
                                            if (day_count_reg < 31) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                        
                                        nov: begin
                                            if (day_count_reg < 30) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                        
                                        dec: begin
                                            if (day_count_reg < 31) begin
                                                day_count_reg = day_count_reg + 1;
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = 1;    // reset the month register back to jan (1)
                                                // increment the year counting register after december have passed
                                                year_count_reg = year_count_reg + 1;
                                                
                                            end 
                                        end
        
                                        default: begin end
                                    endcase
                                end
                            end
                        end


                    end else if (div < base_clock) begin
                        div = div + 1;
                    end  
                end
            endcase
            
        end else if (i2c_write_en == 0) begin
            // base clock divider conditional
            // this if code block is only triggered when one complete second have passed
            if (div == base_clock) begin
                div = 0;
                
                // number of seconds should be 00-59
                if (sec_count_reg < 59) begin
                    sec_count_reg = sec_count_reg + 1;
                end else begin
                    sec_count_reg = 0;
                end
                
                // increment minutes counter
                // keep the counter value in between 00-59
                if (sec_count_reg == 0) begin
                    // increment the minute counter if minutes are in this range 00-59
                    if (min_count_reg < 59) begin
                        min_count_reg = min_count_reg + 1;
                    end else begin
                        min_count_reg = 0;
                    end
                end
                
                // increment hour register
                // keep check on register value
                // value should not exceed 00-23
                
                // counter format : min: sec, 0:0,
                if (sec_count_reg == 0) begin
                    if (min_count_reg == 0) begin
                        if (hour_count_reg < 23) begin
                            hour_count_reg = hour_count_reg + 1;    
                        end else begin
                            hour_count_reg = 0;
                        end
                    end
                end
                
                // increment days and months
                if (sec_count_reg == 0) begin
                    if (min_count_reg == 0) begin
                        if (hour_count_reg == 0) begin
                        
                            case (month_count_reg)
                                jan: begin
                                    if (day_count_reg < 31) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end
                                end
                                
                                feb: begin
                                    // leaps years
                                    // compensate for leap years
                                    if (year_count_reg % 4 == 0 && (year_count_reg % 100 != 0 || year_count_reg % 400 == 0)) begin
                                        is_leap_year = 1; // write 1 to leap_year if year is a leap year
                                    end 
                                    else begin
                                        is_leap_year = 0; // write 0 to leap_year if year is not a leap year
                                    end
                                          
                                    case(is_leap_year)
                                        // if it's not a leap year
                                        0: begin 
                                            if (day_count_reg < 28) begin
                                                day_count_reg = day_count_reg + 1;    
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                        
                                        // if it's a leap year
                                        1: begin
                                            if (day_count_reg < 29) begin
                                                day_count_reg = day_count_reg + 1;    
                                            end else begin
                                                day_count_reg = 1;
                                                month_count_reg = month_count_reg + 1;
                                            end 
                                        end
                                    endcase
                                end
                                
                                mar: begin
                                    if (day_count_reg < 31) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end

                                april: begin
                                    if (day_count_reg < 30) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end

                                may: begin
                                    if (day_count_reg < 31) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end
                                                               
                                june: begin
                                    if (day_count_reg < 30) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end
                                
                                july: begin
                                    if (day_count_reg < 31) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end

                                aug: begin
                                    if (day_count_reg < 31) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end
                                              
                                sep: begin
                                    if (day_count_reg < 30) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end
                                
                                oct: begin
                                    if (day_count_reg < 31) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end
                                
                                nov: begin
                                    if (day_count_reg < 30) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = month_count_reg + 1;
                                    end 
                                end
                                
                                dec: begin
                                    if (day_count_reg < 31) begin
                                        day_count_reg = day_count_reg + 1;
                                    end else begin
                                        day_count_reg = 1;
                                        month_count_reg = 1;    // reset the month register back to jan (1)
                                        // increment the year counting register after december have passed
                                        year_count_reg = year_count_reg + 1;
                                        
                                    end 
                                end

                                default: begin end
                            endcase
                        end
                    end
                end
                
            end else if (div < base_clock) begin
                div = div + 1;
            end
        end
    end    
    
    assign sec = sec_count_reg;
    assign min = min_count_reg;
    assign hour = hour_count_reg;
    assign days = day_count_reg;
    assign months = month_count_reg;
    assign years = year_count_reg - 2000;
    
endmodule
