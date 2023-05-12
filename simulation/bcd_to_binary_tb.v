`timescale 1ns / 1ps

module bcd_to_binary_tb;

    reg clk;
    reg [7:0] i2c_data_in;
    wire [7:0] data_out;
    
    bcd_to_binary dut(
        .clk(clk),
        .i2c_data_in(i2c_data_in),
        .data_out(data_out)
    );
    
    initial begin
        clk = 0;
        i2c_data_in = 8'b0000_0000;
        #10;
        
        // Test case 1: BCD value of 0
        i2c_data_in = 8'b0000_0000;
        #10;        
        // Test case 2: BCD value of 9
        i2c_data_in = 8'b0000_1001;
        #10;
        
        // Test case 3: BCD value of 15
        i2c_data_in = 8'b0001_0101;
        #10;
        // Test case BCD value of 60
        i2c_data_in = 8'b0110_0000;
        #10;
        // Test case 4: BCD value of 99
        i2c_data_in = 8'b1001_1001;
        #10;
        // End simulation
        #10;
        $finish;
    end
    
    always #5 clk = ~clk;
    
endmodule