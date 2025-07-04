# CS220-MIPS-Processor

[If you want to see the IITK-MIPS Processor, click here](./IITK-MIPS%20Processor)

## Assignment 1:
- **Full Subtractor Architecture:**  
  Created a full subtractor using AND, OR, XOR, and NOT gates in a structural style to connect components for bit subtraction with a borrow.
- **32-bit Subtractor:**  
  Instantiated the full subtractor 32 times to build a scalable 32-bit design, ensuring correct borrow propagation between stages.
- **3-to-8 Opcode Decoder:**  
  Implemented a decoder to convert a 3-bit input into eight distinct outputs using a clear structural approach.
- **Mod 10 Counter:**  
  Developed a counter that cycles through 0 to 9 using combinational logic to detect terminal count and reset at 10.
- **Generic Priority Encoder:**  
  Wrote a parameterized Verilog module that adapts to any input dimension and prioritizes the highest-order active input.

## Assignment 2:
- **Mod-10 Gray Code Counter:**  
  Designed a mod-10 Gray code counter with T flip-flops and a synchronous reset, verified through test bench simulations.
- **FPGA Adder:**  
  Built a 1024-bit adder using shared LUT6_2 and CARRY4 primitives to achieve n/2 carry delay, and compared its path delay with that of a ripple carry adder.

## Assignment 3: 
- **3-bit Gray Code Counter:**  
  Designed a 3-bit gray code counter with reset and clock inputs and a “z” output high every 8th cycle. Implemented using a behavioral FSM and verified in Vivado.
- **Sequential Circuit for Specific Input Sequences:**  
  Developed a synchronous sequential circuit that outputs “1” when input sequences “1100”, “1010”, or “1001” occur, resetting upon output. Verified through Vivado simulation.

## Assignment 4: 
- **SRAM Architecture:**  
  Created a 16×32 SRAM using D flip-flops, decoders, and multiplexers with two-level decoding and scaled it to a 512×8 memory. Verified using Vivado post-implementation simulation.
- **Multi-port Register File:**  
  Implemented a register file with two read ports and four write ports using structural code; write conflicts were prioritized (a > b > c > d) and verified on FPGA.

## Assignment 5: 
- **DRAM Architecture:**  
  Designed a 64 KB DRAM using one 64-bit channel, 16 Kb ×4 DRAM chips, 16 rows, 16 banks, and a burst length of 8. Implemented each bank using two-level decoding and verified via Vivado simulation.
- **"Mjolnir" Adder:**  
  Implemented a parameterized k-bit adder (k = 16, 32, 64, 128) using a k/2-bit fast adder from Assignment 2. For k = 128, its timing and area were compared with a ripple carry adder through FPGA IP verification.

## Assignment 6: 
- **Floating-Point Adder:**  
  Computed the 32-bit IEEE single-precision floating-point addition in Verilog, created FPGA IP, interfaced it with the Zynq processor, and verified the design on FPGA.
- **Floating-Point Multiplier:**  
  Implemented a 32-bit IEEE single-precision floating-point multiplier using Verilog (using the “*” operator for integer multiplication), packaged as FPGA IP, and integrated with Zynq for on-board verification.

## Assignment 7: 
- **Second Max and Second Min:**  
  Wrote a MIPS program that scans an array of 10 elements (provided in the data segment) to determine the second maximum and second minimum values.
- **Running Sum of Integers:**  
  Developed a MIPS code that repeatedly reads integers, adds them to a running sum, and stops to output the sum when a 0 is encountered.
- **Digit Name Printer:**  
  Created a MIPS program that reads a positive integer and prints the names of its digits with a single space delimiter, or displays “Invalid Entry” if the input is non-positive.
- **Factorial Computation:**  
  Implemented and tested a MIPS code to compute the factorial of a given number.

## Assignment 8: 
- **Exponentiation (x^y):**  
  Developed a MIPS program that computes x^y for 32-bit integers using the multiply and squaring method, with x and y as inputs.
- **Tower of Hanoi:**  
  Wrote a MIPS code implementing the recursive Tower of Hanoi algorithm, accepting the number of disks as input and moving disks across rods A, B, and C according to the puzzle rules.
