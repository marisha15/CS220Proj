`timescale 1ns/1ps
`include "ripple_subtractor.v"

module ripple_subtractor_tb;

reg [63:0] a,b;
wire [63:0] ans;
wire borrow;

ripple_subtractor #(.W(64))ss(a,b,ans,borrow);

initial begin
    $monitor($time," a = %d , b = %d , ans = %d , borrow = %d",a,b,ans,borrow);
    a = 4'b1100;b = 3'b111;
    #20
    a = 32'd100;b = 32'd11;
    #20
    a = 32'd100;b = 32'd101;
    #20
    a = 32'd0;b = 32'd0;
    #20
    a = 32'd45;b = 32'd45;
    #20
    a = 32'd1344;b = 32'd3212;

end

endmodule