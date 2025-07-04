`timescale 1ns/1ps
`include "full_subtractor.v"

module full_subtractor_tb;

reg a,b,bin;
wire d,bout;
full_subtractor ss(a,b,bin,d,bout);
initial begin
    $monitor($time,"a = %d ,b = %d ,bin = %d ,d = %d ,bout = %d",a,b,bin,d,bout);
    a = 1;b = 1;bin = 1;
    #20;
    a = 1;b = 1;bin = 0;
    #20
    a = 0;b= 0;bin = 1;
    #20
    a = 0;b = 0;bin = 0;
end

endmodule