`timescale 1ns / 1ps

module single_slice_carry_gen_old_init(a,b,c_in,c_out);

input [7:0] a,b;
input c_in;
output [3:0] c_out;

wire [3:0] prop,gen;

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_1 (
.O6(prop[0]), // LUT general output
.O5(gen[0]),
.I0(a[0]), // LUT input
.I1(b[0]), // LUT input
.I2(a[1]), // LUT input
.I3(b[1]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_2 (
.O6(prop[1]), // LUT general output
.O5(gen[1]),
.I0(a[2]), // LUT input
.I1(b[2]), // LUT input
.I2(a[3]), // LUT input
.I3(b[3]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_3 (
.O6(prop[2]), // LUT general output
.O5(gen[2]),
.I0(a[4]), // LUT input
.I1(b[4]), // LUT input
.I2(a[5]), // LUT input
.I3(b[5]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_4 (
.O6(prop[3]), // LUT general output
.O5(gen[3]),
.I0(a[6]), // LUT input
.I1(b[6]), // LUT input
.I2(a[7]), // LUT input
.I3(b[7]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);



CARRY4 CARRY4_inst (
.CO(c_out), // 4-bit carry out
.O(), // 4-bit carry chain XOR data out
.CI(1'd0), // 1-bit carry cascade input
.CYINIT(c_in), // 1-bit carry initialization
.DI(gen), // 4-bit carry-MUX data in
.S(prop) // 4-bit carry-MUX select input
);



endmodule
