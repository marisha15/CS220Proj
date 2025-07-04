`timescale 1ns / 1ps
module week4_1_tb;

// Inputs
reg [17:0] address;
reg clk;
reg we;
reg [63:0] din;

// Outputs
wire [63:0] busout;

// Instantiate the Unit Under Test (UUT)
week4_1 uut (
    .address(address), 
    .clk(clk), 
    .we(we), 
    .din(din), 
    .busout(busout)
);

initial begin
    // Initialize Inputs
    clk = 0;
    address = 18'b0;
    we = 0;
    din = 64'b0;
    
    // Apply reset or initialization logic if needed here
    
    // Start with write operations for 8 cycles
    #5 address = 18'b000000000000000000; din = 64'hA5A5A5A5A5A5A5A5; we = 1; // Example write address and data
    #10 address = 18'b000000000000010000; din = 64'hB5B5B5B5B5B5B5B5;
    #10 address = 18'b000000000000100000; din = 64'hC5C5C5C5C5C5C5C5;
    #10 address = 18'b000000000000110000; din = 64'hD5D5D5D5D5D5D5D5;
    #10 address = 18'b000000000001000000; din = 64'hE5E5E5E5E5E5E5E5;
    #10 address = 18'b000000000001010000; din = 64'hF5F5F5F5F5F5F5F5;
    #10 address = 18'b000000000001100000; din = 64'h1010101010101010;
    #10 address = 18'b000000000001110000; din = 64'h2020202020202020;

    // Change to read operations for the next 8 cycles
    #10 we = 0; // Disable write
    
    // Start with read operations for 8 cycles
    #10 address = 18'b000000000000000000;
    #10 address = 18'b000000000000010000;
    #10 address = 18'b000000000000100000;
    #10 address = 18'b000000000000110000;
    #10 address = 18'b000000000001000000;
    #10 address = 18'b000000000001010000;
    #10 address = 18'b000000000001100000;
    #10 address = 18'b000000000001110000;
    
    // End the simulation after completing all operations
    #10;
    $finish;  // This will stop the simulation
end

// Clock generation
always #5 clk = ~clk;

// Display the values during the simulation
initial begin
    $display("Time\tclk\taddress\twe\tdin\tbusout");
    $monitor("%0t\t%b\t%h\t%b\t%h\t%h", $time, clk, address, we, din, busout);
end

endmodule