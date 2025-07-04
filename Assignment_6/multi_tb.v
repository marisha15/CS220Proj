`timescale 1ns/1ps
`include "multi.v"

module multi_tb();

reg [31:0] a,b;
wire [31:0] out;
wire overflow;

multi mm(a,b,out,overflow);

initial begin
    $monitor($time,"a = %b, b = %b , out = %b , overflow = %b",a,b,out,overflow);
    a = 32'b10111111100011001100110011001101; b = 32'b11000001001000000000000000000000;
    #10;
end

endmodule
