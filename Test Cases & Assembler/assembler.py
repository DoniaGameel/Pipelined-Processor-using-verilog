#Not sensetive to spaces before/after operand and opcodes
#Not case sensetive
#No brackets are allowed ==> remove brackets before you run the assembler
#Put the input text file in the the path of the assembler
#Set file_name with input file name
#The Interrupt service routine which starts at Org0 till RTI will be in isrMEM.txt file
#The instructions will be in instructionMem.txt
#Instructions starts with .ORG in our test cases
#We don't use first ORG as the project says that instruction memory starts in 2**5 memory location
#Any ORG we insert NOP instructions with the number if ORG
#Comments starts with #

import os

registers = {
    "r0": "000",
    "r1": "001",
    "r2": "010",
    "r3": "011",
    "r4": "100",
    "r5": "101",
    "r6": "110",
    "r7": "111",
}

opcodes = {
    "mov":  '00000',
    "add":  '00001',
    "sub":  '00010',
    "or":   '00011',
    "and":  '00100',
    "inc":  '00101',
    "dec":  '00110',
    "not":  '00111',

    "out":  '01000',
    "in":  '01001',
    "nop":  '01010',
    "reset":   '01011',
    "interrupt":  '01100',
    "setc":  '01101',
    "clrc":  '01110',

    "push":  '10000',
    "pop":  '10001',
    "ldm":  '10010',
    "ldd":   '10011',
    "std":  '10100',
    "shl":  '10101',
    "shr":  '10110',

    "jz":  '11000',
    "jn":  '11001',
    "jc":  '11010',
    "jmp":   '11011',
    "call":  '11100',
    "ret":  '11101',
    "rti":  '11110',
}

def isImmediate(dst):
    return False if dst.lower() in registers else True
my_path=os.path.dirname(__file__)
file_name="/branchInterrupt.txt"
input_file=my_path+file_name

assembly_file = open(input_file, "r")
Lines = assembly_file.readlines()
assembly_file.close()

#ISR code lines
ISR_lines=[]
#program code lines
code_lines=[]
first_Org=False
first_interrupt_instruction_index=0
rti_instruction_index=0
#first non interrupt instructions
first_instruction_index=0

for index,line in enumerate(Lines):
    if(line[0:6]=='.ORG 0'):
        first_interrupt_instruction_index=index+1
    else:
        if(line[0:4]=='.ORG' and first_Org==False):
            first_instruction_index=index+1
            first_Org=True
        elif(line[0:3]=='RTI'):
                rti_instruction_index=index
for index,line in enumerate(Lines):
    #get non comment lines of the ISR
    if(index>=first_interrupt_instruction_index and index<=rti_instruction_index and line[0]!='#'):
        ISR_lines.append(line)
    #get non comment lines of the program
    elif(index>=first_instruction_index and line[0]!='#'):
            code_lines.append(line)

#opcodes list of ISR
Isr_instructions=[]
#opcodes list of program
program_instructions=[]
def get_instructions(lines,type):
    opcode=""
    Rsrc=""
    Rdst=""
    Rs="" #concatinated Ri,Rj string
    isImm=False
    immediateValue=""
    instruction=""
    for line in lines:
        #remove inline comments
        comment_split=line.split('#')
        #split the non comment part on ' '
        first_split = comment_split[0].split()
        if(first_split[0]=='.ORG'):
            numLines=int(first_split[1])
            for i in range (numLines):
                program_instructions.append("0101000000000000\n")
        else:

            
            #the instruction opcode is the first part of the splitted list of strings
            opcode=opcodes[first_split[0].lower()]
            
            
            if(len(first_split)==1 ):
                isImm=False
                #no operand instruction
                Rsrc="000"
                Rdst="000"
            else:
                #operands instructions
                if(len(first_split)>2):
                    Rs=''
                    #to remove spaces from Ri,Rj string
                    for i in range(1,len(first_split)):
                        Rs+=first_split[i]
                else:
                    #if there is no space and Ri,Rj is one string
                    Rs=first_split[1]
                if(len(Rs)==2):
                    isImm=False
                    #one operand instruction
                    Rsrc=registers[first_split[1].lower()]
                    Rdst=registers[first_split[1].lower()]
                else:
                    if(len(Rs)>2):
                        #two operands instructions
                        second_split = Rs.split(",")
                        Rsrc=registers[second_split[0].lower()]
                        dst=second_split[1]
                        if(isImmediate(dst)==False):
                            Rdst=registers[second_split[1].lower()]
                            isImm=False
                        else:
                            #Rdst = Rsrc
                            Rdst=registers[second_split[0].lower()]
                            isImm=True
                            #convert immediate number to 16 bits binary
                            immediateValue=bin(int(dst))[2:].zfill(16) + "\n"
        instruction= opcode+ Rsrc+ Rdst + "00000" + "\n" 
        if(type==1):
            Isr_instructions.append(instruction) 
            if(isImm):
                Isr_instructions.append(immediateValue)  
        if(type==2):
            program_instructions.append(instruction) 
            if(isImm):
                program_instructions.append(immediateValue)  
            

get_instructions(ISR_lines,1)
get_instructions(code_lines,2)

outputPath1=my_path+"/instructionMem.txt"
InstructionsOutputFile = open(outputPath1, 'w')
InstructionsOutputFile.writelines(program_instructions)
InstructionsOutputFile.close()

outputPath2=my_path+"/isrMem.txt"
ISROutputFile = open(outputPath2, 'w')
ISROutputFile.writelines(Isr_instructions)
ISROutputFile.close()

