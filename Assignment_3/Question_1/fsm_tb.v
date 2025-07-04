`timescale 1ns/1ps
`include "fsm.v"

module fsm_tb;

reg clk,reset;
wire out;
wire [2:0] ps,ns;

fsm ss(clk,reset,out,ps,ns);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    $monitor($time," ps = %b ,ns = %b, out = %b , clk = %b , reset = %b",ps,ns,out,clk,reset);
    reset = 1;
    #10;
    reset = 0;
    #200;
    $stop;
end

endmodule 