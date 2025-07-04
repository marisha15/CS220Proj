`include "sram16_32.v"

module sram512_8(dout,din,we,add,clk,reset);

input [7:0] din;
input we,clk,reset;
input [8:0] add;
output [7:0] dout;

wire [3:0]row;
wire [4:0]col;

assign row = add[8:5];
assign col = add[4:0];

wire [511 : 0] memory [7:0];

reg [31:0] temp[7:0];

integer j;

always @(*)begin
    for(j = 0;j<8;j = j + 1)begin
        temp[j] = memory[j][32*row];
        temp[j][col] = din[j];
    end
end


genvar i;
generate
    for(i = 0;i<8;i= i + 1)begin
        sram16_32 ssss(memory[i],temp[i],we,row,clk,reset);
    end
endgenerate

assign dout = {memory[7][32*row + col],memory[6][32*row + col],memory[5][32*row + col],memory[4][32*row + col],
memory[3][32*row + col],memory[2][32*row + col],memory[1][32*row + col],memory[0][32*row + col]};

endmodule 














// input we,clk,reset;
// input [7:0] din;
// input [8:0] add;

// output [7:0] dout;

// wire [3:0] row;
// wire [4:0] col;

// assign row = add[8:5];
// assign col = add[4:0];

// reg [511:0] mem[7:0];
// wire [511:0] mem_wire[7:0];
// reg [31:0] temp_din[7:0];

// integer j;
// always @(*)begin
//     for(j = 0;j<8;j = j + 1)begin
//         temp_din[j] = mem[j][32*row + col];
//         temp_din[j][col] = din[j];
//     end
// end

// genvar i;
// generate
//     for(i = 0;i<8;i = i + 1)begin
//         sram16_32 ss(mem_wire[i],temp_din[i],we,row,clk,reset);
//     end
// endgenerate

// always @(*)begin
//     for(j = 0;j<8;j++)begin
//         mem[j] = mem_wire[j];
//     end
// end

// assign dout = {mem[7][32*row + col],mem[6][32*row + col],mem[5][32*row + col],mem[4][32*row + col],
// mem[3][32*row + col],mem[2][32*row + col],mem[1][32*row + col],mem[0][32*row + col]};
