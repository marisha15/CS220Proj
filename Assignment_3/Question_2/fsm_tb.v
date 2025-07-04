`timescale 1ns/1ps
`include "fsm.v"

module fsm_tb;

reg clk,reset,bit;
wire out;
wire [2:0] ns,ps;

fsm ss(clk,reset,bit,out,ns,ps);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    $monitor($time," ps = %b , ns = %b, out = %b, bit = %b , clk = %b , reset = %b",ps,ns,out,bit,clk,reset);
    reset = 1;
    #5;
    reset = 1;
    #10;
    reset = 0;
    bit = 1;
    #10;
    bit = 0;
    #10;
    bit = 0;
    #10;
    bit = 1;
    #10;
    bit = 1;
    #10;
    $finish;
end

endmodule 