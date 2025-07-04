`timescale 1ns/1ps
`include "gray_code.v"

module gray_code_tb;

reg clk,reset;
wire [3:0] a;

gray_code ss(a,clk,reset);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    $monitor($time," out = %b, clk = %b , reset = %b",a,clk,reset);
    reset = 1;
    #10;
    reset = 0;
    #200;
    $stop;
end

endmodule