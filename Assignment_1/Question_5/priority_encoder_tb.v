`timescale 1ns/1ps
`include "priority_encoder.v"

module priority_encoder_tb;

reg [7:0]in;
wire valid;
wire [2:0] out;

priority_encoder ss(in,out,valid);

initial begin
    $monitor($time," in = %b,out = %b,valid = %b",in,out,valid);
    in = 8'b01111111;
    #20;
    in = 8'b00000000;
    #20;
    in = 8'b00001001;
    #20;
    in = 8'b00000001;
end
endmodule