`timescale 1ns/1ps
`include "file.v"

module file_tb;

reg [4:0] add_a,add_b,add_c,add_d;
reg [31:0] din_a,din_b,din_c,din_d;
reg clk,reset,we;

wire [31:0] dout_a,dout_b;

file ss(add_a,add_b,add_c,add_d,din_a,din_b,din_c,din_d,we,clk,reset,dout_a,dout_b);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin

    $monitor($time, "add_a = %b , add_b = %b ,add_c = %b , add_d = %b,dout_a = %b, dout_b = %b, clk = %b , reset = %b , we = %b ",add_a,add_b,add_c,add_d,dout_a,dout_b,clk,reset,we);
    reset = 1;
    #10;
    reset = 0;
    we = 1;
    add_a = 5'b00001;
    din_a = 32'hAAAAAAAA;
    add_b = 5'b10001;
    din_b = 32'hFFFFFFFF;
    #10;
    we = 0;
    add_b = 5'b00000;
    #10;
    $finish;
end

endmodule