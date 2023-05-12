`timescale 1ns / 1ps

module binary_to_bcd(
    input clk,
    input [7:0] sec,
    input [7:0] min,
    input [7:0] hour,
    input [7:0] days,
    input [7:0] months,
    input [7:0] years,
    output [7:0] sec_bcd,
    output [7:0] min_bcd,
    output [7:0] hour_bcd,
    output [7:0] days_bcd,
    output [7:0] months_bcd,
    output [7:0] years_bcd
    );
    
    double_dabble sec_inst(clk, sec, sec_bcd);
    double_dabble min_inst(clk, min, min_bcd);
    double_dabble hour_inst(clk, hour, hour_bcd);
    double_dabble days_inst(clk, days, days_bcd);
    double_dabble months_inst(clk, months, months_bcd);
    double_dabble years_inst(clk, years, years_bcd);
    
    always @ (posedge clk) begin
    
    end    
endmodule

// Double dabble algorithm for conversion from binary to bcd
module double_dabble(
    input clk,
    input [7:0] bin,
    output reg [7:0] bcd
   );
   
    integer i;
    
    always @(posedge clk) begin
        bcd=0;		 	
        for (i=0;i<8;i=i+1) begin					//Iterate once for each bit in input number
            if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
            if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
            bcd = {bcd[7:0],bin[7-i]};				//Shift one bit, and shift in proper bit from input 
        end
    end

endmodule
