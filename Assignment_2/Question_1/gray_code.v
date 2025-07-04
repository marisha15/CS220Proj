`include "t_ff.v"
module gray_code(a,clk,reset);

input clk,reset;
output [3:0] a;


t_ff ss1(a[0],(~a[3]&~a[2]&~a[1]&~a[0])|(~a[3]&~a[2]&a[1]&a[0])|(~a[3]&a[2]&a[1]&~a[0])|(~a[3]&a[2]&~a[1]&a[0])|(a[3]&a[2]&~a[1]),clk,reset);
t_ff ss2(a[1],(~a[3]&~a[2]&~a[1]&a[0])|(~a[3]&a[2]&a[1]&a[0]),clk,reset);
t_ff ss3(a[2],(~a[3]&~a[2]&a[1]&~a[0])|(a[3]&a[2]&~a[1]&a[0]),clk,reset);
t_ff ss4(a[3],(~a[3]&a[2]&~a[1]&~a[0])|(a[3]&a[2]&~a[1]&a[0]),clk,reset);

endmodule