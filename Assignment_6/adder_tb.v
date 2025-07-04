`timescale 1ns / 1ps
`include "adder.v"
module top_adder;

    reg signa, signb;
    reg [22:0] fraca, fracb;
    reg [7:0] expa, expb;
    wire signout;
    wire [22:0] fracout;
    wire [7:0] expout;

    wire [23:0] tempa, tempb;
    wire [23:0] tempout;

    assign tempa = {1'b1, fraca};
    assign tempb = {1'b1, fracb};
    assign tempout = {1'b1, fracout};

    adder mult(.a({signa, expa[7:0], fraca[22:0]}), .b({signb, expb[7:0], fracb[22:0]}), .out({signout, expout, fracout[22:0]}));

    initial begin
        $monitor($time, "a: %d %d %b, b: %d %d %b, out: %d, %d, %b", signa, expa, tempa, signb, expb, tempb, signout, expout, tempout);
        #5
        signa = 1; expa = 126; fraca = 0;
        signb = 0; expb = 126; fracb = {1'b1, {(22){1'b0}}};
        #5
        signa = 1; expa = 128; fraca = 0;
        signb = 1; expb = 125; fracb = {1'b1,1'b1, {(21){1'b0}}};
    end

endmodule