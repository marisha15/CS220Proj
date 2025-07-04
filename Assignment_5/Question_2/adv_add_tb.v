`timescale 1ns / 1ps
module mjolnir_tb;
    reg [127:0] A,B;
    reg Cin;
    wire [127:0] Sum;
    wire Cout;
 
    mjolnir uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
 
 
    initial begin
 
        $display("Time\tA\tB\tCin\tSum\tCout");
        $monitor("%b\t%b",Sum, Cout);
 
 
        A =128'b0;
        B = 128'b0;
        Cin = 0;
        #10; 
 
        A = 128'b1;
        B = 128'b0;
        Cin = 1;
        #10;
 
        A = 128'b11010;
        B = 128'b11011;
        Cin = 0;
        #10;
 
        A = 128'b11;
        B = 128'b11;
        Cin = 1;
        #10;
 
 
//        A = 1024'b1010101010101010101010;
//        B = 1024'b0101010101010101010101;
//        Cin = 1;
//        #10;
 
//        A = 1024'b101010;
//        B = 1024'b010101;
//        Cin = 0;
//        #10;
 
//        A = 1024'b1<<1023;
//        B = 1024'b1<<1023;
//        Cin = 0;
//        #10;
        $finish;
    end
endmodule