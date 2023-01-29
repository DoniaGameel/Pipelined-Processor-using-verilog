# Pipelined-Processor-using-verilog

In this project, we design, implement and test a **Harvard (separate memories for data and instructions), RISC-like, five-stages pipeline** processor, with the specifications as described in the following sections.

## 5-Stages pipeline processor

namely (Fetch -Decode-Execute-Memory-Write Back). We will simulate a pipeline that issues new instruction after 5-time steps. In every time step, the instruction passes through one of the stages. Each instruction should walk through the complete 5 stages even if it doesn’t need to do anything in some of the stages.

## Memory units and registers description

In this project, we apply a Harvard architecture with two memory units; **Instructions’ memory** and **Data memory.**

The processor in this project has a RISC-like instruction set architecture. There are eight 2-bytes general purpose registers[ R0 to R7]. These registers are separate from the program counter and the stack pointer registers.

The program counter **PC** spans the instructions memory address space that has a total size of **2 Megabytes.** Each memory address has a **16-bit width** (i.e., is word addressable). The instructions memory **starts with the interrupts area** (the very first address space from [0 down to 2^5-1]), **followed by the instructions area** (starting from [2^5 and down to 2^20]) as shown in Figure.1. By default, **the PC is initialized with a value of (2^5)** where the program code starts.

The other memory unit is the **data memory,** which has a total size of **4 Kilobytes** for its own, **16-bit in width** (i.e., is word addressable). The processor can **access both memory units at the same time** without having a memory access hazard.

The **data memory** starts with the data area (the very first address space and down), followed by the stack area (starting from [2^11 − 1 and up]) as shown in Figure.1. By default, **the stack pointer (SP) pointer points to the top of the stack** (the next free address available in the stack), and is initialized by a value of (2^1-1).

## Interrupts

interrupts area is in the very first address space from [0 down to 2^5-1]

When an **interrupt occurs,** the processor **finishes the currently fetched instructions** (instructions that have already entered the pipeline), **save the processor state** (Flags), then **the address of the next instruction (in PC) is saved on top of the stack,** and **PC is loaded from address 0** of the memory where the interrupt code resides.

We have **only one interrupt program,** the one which starts at the top of the instruction’s memory

To **return from an interrupt,** an RTI instruction **loads the PC from the top of stack,** **restores the processor state (Flags),** and the flow of the program resumes from the instruction that was supposed to be fetched in-order before handling the interrupted instruction.

![My Image](Figures/figure1.png)

## ISA specifications

**A) Registers:**

○ R[0:7]<15:0> : Eight 16-bit general purpose registers

○ PC<31:0> : 32-bit program counter

○ SP<31:0> : 32-bit stack pointer

○ CCR<3:0> : condition code register that can be divided to

○ Z<0>:=CCR<0> : zero flag, change after arithmetic, logical, or shift operations

○ N<0>:=CCR<1> : negative flag, change after arithmetic, logical, or shift operations

○ C<0>:=CCR<2> : carry flag, change after arithmetic or shift operations.

**B) Input-Output**

○ IN.PORT<15:0> : 16-bit data input port

○ OUT.PORT<15:0> : 16-bit data output port

○ INTR.IN<0> : a single, non-maskable interrupt

○ RESET.IN<0> : reset signal

**C) Other registers to hold the operands and opcodes of the instructions**

○ Rsrc : 1st operand register

○ Rdst : 2nd operand register and result register field

○ Imm : Immediate Value

**D) Instructions (some instructions will occupy more than one memory location)**

![My Image](Figures/One_Operand.png)

![My Image](Figures/two_Operands.png)

![My Image](Figures/Memory,Branch&Signals.png)

## Design

**The whole design**

![My Image](Figures/Memory,The_Whole_Design.png)

**Fetch Stage**

![My Image](Figures/Memory,Fetch_Stage.png)

**Decode Stage**

![My Image](Figures/Memory,Decode_Stage.png)

**Execute Stage**

![My Image](Figures/Memory,Execute_Stage.png)

**Memory Stage**

![My Image](Figures/Memory,Memory_Stage_1.png)

![My Image](Figures/Memory,Memory_Stage_2.png)

![My Image](Figures/Memory,Memory_Stage_3.png)

**Write Back Stage**

![My Image](Figures/Memory,Write_Back_Stage.png)

**Interrupt,Call,RET & RTI controllers**

![My Image](Figures/Memory,Interrupt_Controller_1.png)

![My Image](Figures/Memory,Interrupt_Controller_2.png)

**Hazard detection unit and forwarding unit**

![My Image](Figures/Memory,HDU&FU.png)

**Flush Controller**

![My Image](Figures/Memory,Flush_Controller.png)

To See more details you can open **'design.drawio'** file in [This Site](https://app.diagrams.net/)

## Instructions format

## PC control unit

## Entered Instruction in IF/IE buffer:

1-If PC is freezed or the instruction needs Immediate value PC is freezed , Nop is Entered.

2-else it will be the output of instructions memory.

## ALU OpCodes (from decoding stage to ALU)

## Full forwarding unit truth table

## Handled Hazards

## Branch predicion

We used **static branch predicion**

## Assembler

## Test Cases

## Files Structure

##  How to simulate it?

## Contributors
