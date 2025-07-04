`timescale 1ns/1ps
`include "mod_counter.v"

module mod_counter_tb;

reg clk,reset;
wire [3:0]count;

counter ss(count,clk,reset);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end


initial begin
    $monitor($time," count = %d,clk = %d , reset = %d",count,clk,reset);
    reset = 1;
    #10;
    reset = 0;
    #200;
    $finish;
end

endmodule
