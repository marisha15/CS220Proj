module testbench();

reg clock;
always #5 clock = ~clock;
reg reset;
wire [31:0] a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14;

IITK_MIPS dd (clock,reset,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11);
  
initial begin $dumpfile("full_tb.vcd");$dumpvars(); end

initial begin
  $monitor($time," array = %d %d %d %d %d %d %d %d %d %d\n array_size=%d\n" ,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11);
    clock = 0;
    reset = 1;
  #5 reset=0;
    #20000 $finish;

end

endmodule

