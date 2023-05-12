`timescale 1ns / 1ps

module register_file_tb;
  reg clk;
  reg [3:0] addr;
  reg [7:0] data_in;
  reg write_en;
  reg read_en;
  wire [7:0] data_out;

  register_file dut (
    .clk(clk),
    .addr(addr),
    .data_in(data_in),
    .write_en(write_en),
    .read_en(read_en),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    read_en = 0;
    // store 10 at address 0
    #5
    data_in = 10;
    addr = 0;
    write_en = 1;
    #10
    write_en = 0;

    // store 15 at address 1
    #10
    data_in = 15;
    addr = 1;
    write_en = 1;
    #10
    write_en = 0;
    #10

    // store 20 at address 2
    #10
    data_in = 20;
    addr = 2;
    write_en = 1;
    #10
    write_en = 0;
    #10
    
    // store 25 at address 3
    #10
    data_in = 25;
    addr = 3;
    write_en = 1;
    #10
    write_en = 0;
    #10    
    
    // store 30 at address 4
    #10
    data_in = 30;
    addr = 4;
    write_en = 1;
    #10
    write_en = 0;
    #10
    
    // read from written address
    #10 
    addr = 0;
    read_en = 1;
    #10
    read_en = 0;

    #10 
    addr = 1;
    read_en = 1;
    #10
    read_en = 0;
        
    #10 
    addr = 2;
    read_en = 1;
    #10
    read_en = 0;
    
    #10 
    addr = 3;
    read_en = 1;
    #10
    read_en = 0;
    
    #10 
    addr = 4;
    read_en = 1;
    #10
    read_en = 0;
    
    #100;
    $finish;
  end

  always #5 clk = ~clk;

endmodule
