`timescale 1ns / 1ps

module bcd_to_binary(
    input clk,
    input [7:0] i2c_data_in,
    output reg [7:0] data_out
    );
    
    
    always @(posedge clk) begin
        case (i2c_data_in)
        8'b0000_0000: data_out = 0;     
        8'b0000_0001: data_out = 1;       
        8'b0000_0010: data_out = 2;     
        8'b0000_0011: data_out = 3;     
        8'b0000_0100: data_out = 4;     
        8'b0000_0101: data_out = 5;     
        8'b0000_0110: data_out = 6;     
        8'b0000_0111: data_out = 7;     
        8'b0000_1000: data_out = 8;     
        8'b0000_1001: data_out = 9;     
        
        8'b0001_0000: data_out = 10;    
        8'b0001_0001: data_out = 11;      
        8'b0001_0010: data_out = 12;    
        8'b0001_0011: data_out = 13;    
        8'b0001_0100: data_out = 14;    
        8'b0001_0101: data_out = 15;    
        8'b0001_0110: data_out = 16;    
        8'b0001_0111: data_out = 17;    
        8'b0001_1000: data_out = 18;    
        8'b0001_1001: data_out = 19;    

        8'b0010_0000: data_out = 20;     
        8'b0010_0001: data_out = 21;       
        8'b0010_0010: data_out = 22;     
        8'b0010_0011: data_out = 23;     
        8'b0010_0100: data_out = 24;     
        8'b0010_0101: data_out = 25;     
        8'b0010_0110: data_out = 26;     
        8'b0010_0111: data_out = 27;     
        8'b0010_1000: data_out = 28;     
        8'b0010_1001: data_out = 29;
                        
        8'b0011_0000: data_out = 30;     
        8'b0011_0001: data_out = 31;       
        8'b0011_0010: data_out = 32;     
        8'b0011_0011: data_out = 33;     
        8'b0011_0100: data_out = 34;     
        8'b0011_0101: data_out = 35;     
        8'b0011_0110: data_out = 36;     
        8'b0011_0111: data_out = 37;     
        8'b0011_1000: data_out = 38;     
        8'b0011_1001: data_out = 39;
        
        8'b0100_0000: data_out = 40;     
        8'b0100_0001: data_out = 41;       
        8'b0100_0010: data_out = 42;     
        8'b0100_0011: data_out = 43;     
        8'b0100_0100: data_out = 44;     
        8'b0100_0101: data_out = 45;     
        8'b0100_0110: data_out = 46;     
        8'b0100_0111: data_out = 47;     
        8'b0100_1000: data_out = 48;     
        8'b0100_1001: data_out = 49;

        8'b0101_0000: data_out = 50;     
        8'b0101_0001: data_out = 51;       
        8'b0101_0010: data_out = 52;     
        8'b0101_0011: data_out = 53;     
        8'b0101_0100: data_out = 54;     
        8'b0101_0101: data_out = 55;     
        8'b0101_0110: data_out = 56;     
        8'b0101_0111: data_out = 57;     
        8'b0101_1000: data_out = 58;     
        8'b0101_1001: data_out = 59;        
        
        8'b0110_0000: data_out = 60;     
        8'b0110_0001: data_out = 61;       
        8'b0110_0010: data_out = 62;     
        8'b0110_0011: data_out = 63;     
        8'b0110_0100: data_out = 64;     
        8'b0110_0101: data_out = 65;     
        8'b0110_0110: data_out = 66;     
        8'b0110_0111: data_out = 67;     
        8'b0110_1000: data_out = 68;     
        8'b0110_1001: data_out = 69;

        8'b0111_0000: data_out = 70;     
        8'b0111_0001: data_out = 71;       
        8'b0111_0010: data_out = 72;     
        8'b0111_0011: data_out = 73;     
        8'b0111_0100: data_out = 74;     
        8'b0111_0101: data_out = 75;     
        8'b0111_0110: data_out = 76;     
        8'b0111_0111: data_out = 77;     
        8'b0111_1000: data_out = 78;     
        8'b0111_1001: data_out = 79;        

        8'b1000_0000: data_out = 80;     
        8'b1000_0001: data_out = 81;       
        8'b1000_0010: data_out = 82;     
        8'b1000_0011: data_out = 83;     
        8'b1000_0100: data_out = 84;     
        8'b1000_0101: data_out = 85;     
        8'b1000_0110: data_out = 86;     
        8'b1000_0111: data_out = 87;     
        8'b1000_1000: data_out = 88;     
        8'b1000_1001: data_out = 89;        
        
        8'b1001_0000: data_out = 90;     
        8'b1001_0001: data_out = 91;       
        8'b1001_0010: data_out = 92;     
        8'b1001_0011: data_out = 93;     
        8'b1001_0100: data_out = 94;     
        8'b1001_0101: data_out = 95;     
        8'b1001_0110: data_out = 96;     
        8'b1001_0111: data_out = 97;     
        8'b1001_1000: data_out = 98;     
        8'b1001_1001: data_out = 99;        
                                              
        default: data_out = 0;
        endcase    
    end
endmodule
