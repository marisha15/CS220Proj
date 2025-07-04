`timescale 1ns/1ps
`include "sram512_8.v"

module sram_tb;

reg clk,reset,we;
reg [7:0] din;
reg [8:0] add;

wire [7:0] dout;


sram512_8 sss(dout,din,we,add,clk,reset);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    $monitor($time," add = %b , dout = %b , clk = %b , reset = %b, we = %b",add,dout,clk,reset,we);
    reset = 1;
    #10;
    reset = 0;
    add = 9'b000000000;
    #10;
    we = 1;
    din = 8'b10110000;
    #10;
    we = 0;
    add = 9'b000000001;
    #10;
    add = 9'b000000000;
    #10
    $finish;
end

endmodule 