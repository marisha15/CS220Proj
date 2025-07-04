# CS220  IITK-MIPS
Welcome to the readme file for the IITK-MIPS Processor, an implementation based on the MIPS architecture. This document aims to provide a comprehensive overview of the design and implementation of the processor. The Processor boasts a streamlined single-cycle approach, enabling efficient execution of instructions through the stages of fetching, decoding, and execution. By familiarizing yourself with this document, you will gain a deeper understanding of the inner workings and features of the MIPS Processor. Let's delve into the details of this impressive processor design.

# Contents
This Repo contains
1. Assignment - This file contains information about how instruction format are defined. 
2. Bubble_Sort - This is an .asm file containing the MIPS32 Assembly code for the bubble sort algorithm. This file can be simulated on QTSPIM.
3. Report - This contain the project report and information about implementation and design.
4. Code - This contain the Verilog code of the processor.
5. Test_bench - This contain the test_bench of the verilog code used while simulating the verilog code of processor.

# Design and Implementation
1. Single-cycle architecture: The processor follows a single-cycle approach, allowing for the fetch, decode, and execution of instructions to be completed within a single clock cycle.

2. Arithmetic Logic Unit (ALU): The processor incorporates an ALU that is capable of performing operations for different instruction types. It consists of modules dedicated to handling R-type, I-type, and J-type instructions, providing the necessary computational capabilities.

3. Finite State Machine (FSM): The processor utilizes a FSM to generate control signals that coordinate the flow of data and control within the system. The FSM ensures the proper sequencing and synchronization of the different stages of instruction execution.

4. MIPS-like Instruction Set Architecture (ISA): The processor supports an Instruction Set Architecture similar to MIPS. This means it can execute MIPS code translated into machine code following the specified ISA, enabling compatibility with existing MIPS programs and tools.

5. Execution of translated MIPS code: The CSE Bubble Processor is designed to execute machine code derived from MIPS code. By adhering to the MIPS ISA, it can accurately execute MIPS programs, leveraging the extensive software ecosystem and tools available for the MIPS architecture.

These points highlight the single-cycle nature, ALU capabilities, control signal generation through FSM, support for MIPS-like ISA, and the ability to execute translated MIPS code that define the features and functionality of the CSE Bubble Processor.

# How to use
To use the this Processor, follow these steps:

1. Set up the processor design by including the ALU, FSM, and other required components.
2. Load the MIPS code for the Bubble Sort algorithm into the processor.
3. Translate the MIPS code into machine code following the ISA of the MIPS processor.
4. Execute the machine code on the processor and observe the sorting operation.

# Conclusion
In summary, the IITK-MIPS Processor is a MIPS-based implementation featuring a single-cycle architecture for efficient instruction execution. It includes an ALU with modules for different instruction types, a FSM for control signal generation, and support for a MIPS-like ISA. This processor can execute translated MIPS code, making it a versatile and powerful solution for MIPS-based computing.
