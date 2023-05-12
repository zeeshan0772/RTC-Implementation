`timescale 1ns / 1ps

// if write_en is asserted then the data should be written to the reg file
module register_file(
    input wire clk,            // clock input
    input wire [3:0] addr,     // address input
    input wire [7:0] data_in,  // data input
    input wire write_en,       // write enable input
    input wire read_en,
    output reg [7:0] data_out  // data output
);

    reg [7:0] mem [0:7];      // 8-address memory array
    
    always @(posedge clk) begin
        if (write_en == 1) begin      // write to memory if write enable is high
            mem[addr] = data_in;
        end
     
        if (read_en == 1) begin
            data_out = mem[addr];   // read from memory
        end
    end
endmodule