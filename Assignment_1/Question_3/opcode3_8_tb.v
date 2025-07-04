`timescale 1ns/1ps
`include "opcode3_8.v"

module opcode3_8_tb();

reg [2:0] in;
reg clk;
wire [7:0] out;

opcode3_8 ss(in,out,clk);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    $monitor($time,"in = %b , clk = %b , out = %b",in,clk,out);
    in = 3'b000;
    #10;
    in = 3'b001;
    #10;
    in = 3'b111;
    #10;
    $finish;
end

endmodule