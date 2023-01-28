module control_unit (family,opcode,alu_op,register_write,alu_src,mem_write,mem_to_register,mem_read,unconditional_jump,jump_type,in_port,stack_or_data,pc_to_stack,inc_dec_sp,imm,ldd_or_std,ret,rti,call,reset);
  input wire[1:0] family;
  input wire[2:0] opcode;
  input reset;
  output reg [3:0] alu_op;    
  output reg register_write;  // 0: disable reg write, 1: enable reg write
  output reg alu_src;         // 0: reg data,          1: immdediate value
  output reg mem_write;       // 0: disable mem write, 1: enable mem write
  output reg mem_to_register; // 0: ALU to reg,        1: mem to reg
  output reg mem_read;        // 0: disable mem read,  1: enable mem read
  output reg [1:0] jump_type; //00: jn,  01: jz,  00: jc,  01: jump
  output reg in_port;         // 0: not in port,       1: in port
  output reg stack_or_data;   // 0: stack,             1: data
  output reg pc_to_stack;     // 0: dnt push pc in stk,1: push pc in stk
  output reg inc_dec_sp;      // 0: inc sp,            1: dec sp
  output reg imm;             // 0: no immediate value,1: immediate value
  output reg ldd_or_std;      // 0: ldd,               1: std             
  output reg unconditional_jump;// 0: conditional jump,1: unconditional jump
  output reg ret;
  output reg rti;
  output reg call;   
always@(posedge reset)
	imm=1'b0;
always@(*)
begin
  case(family)
    2'b00: begin //ALU operations
        register_write = 1'b1;
        alu_src = 1'b0;
        mem_write = 1'b0;
        mem_to_register = 1'b0;
        mem_read = 1'b0;
        jump_type = 2'b00;
        in_port = 1'b0;
        stack_or_data = 1'b1;
        pc_to_stack = 1'b0;
        inc_dec_sp = 1'b0;
        imm = 1'b0;
        ldd_or_std = 1'b0;
        unconditional_jump = 1'b0;
        ret = 1'b0;
        rti = 1'b0;
        call = 1'b0; 
       case(opcode)
          3'b000: //MOV 
            alu_op = 4'b1000;
          
          3'b001: //ADD 
            alu_op = 4'b0000;
          
          3'b010: //SUB 
            alu_op = 4'b0010;
          
          3'b011: //OR 
            alu_op = 4'b0100;
            
          3'b100: //AND
            alu_op = 4'b0011;
            
          3'b101: //INC
            alu_op = 4'b0101;
            
          3'b110: //DEC
            alu_op = 4'b0110;
            
          3'b111: //NOT
            alu_op = 4'b0111;
        endcase 
      end   
        
          
          
        
    2'b01: begin // not ALU operations
       ldd_or_std = 1'b0;
       alu_src = 1'b0;
       mem_write = 1'b0;
       mem_to_register = 1'b0;
       mem_read = 1'b0;
       jump_type = 2'b00;
       stack_or_data = 1'b1;
       pc_to_stack = 1'b0;
       inc_dec_sp = 1'b0;
       imm = 1'b0;
       unconditional_jump = 1'b0;
       ret = 1'b0;
       rti = 1'b0;
       call = 1'b0; 
       case(opcode)
          3'b000: begin //OUT 
            alu_op = 4'b1000;     /////////////////////NOP
            register_write = 1'b0;
            in_port = 1'b0;
          end
          
          3'b001: begin //IN 
            alu_op = 4'b1000;     /////////////////////NOP
            register_write = 1'b1;
            in_port = 1'b1;
          end
          
          3'b010: begin //NOP 
            alu_op = 4'b1000;     /////////////////////NOP
            register_write = 1'b0;
            in_port = 1'b0;
          end
          
          3'b101: begin //SETC 
            alu_op = 4'b1001;     /////////////////////SETC
            register_write = 1'b0;
            in_port = 1'b0;
          end
          
          3'b110: begin //CLRC 
            alu_op = 4'b1010;     /////////////////////CLRC
            register_write = 1'b0;
            in_port = 1'b0;
          end
        endcase
    end
    
    
    
    2'b10: begin  //heap memory and imm intruction
      pc_to_stack = 1'b0;
      in_port = 1'b0;
      jump_type = 2'b00;
      unconditional_jump = 1'b0;
      ret = 1'b0;
      rti = 1'b0;
      call = 1'b0; 
      case(opcode)
          3'b000: begin //PUSH Rdst   X[SP--] ? R[ Rdst ]; 
            alu_op = 4'b1000;     ////////////////NOP
            register_write = 1'b0;
            alu_src = 1'b0;
            mem_write = 1'b1;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            stack_or_data = 1'b0;
            inc_dec_sp = 1'b1;
            imm = 1'b0;
            ldd_or_std = 1'b1;
        end
        
          3'b001: begin //POP Rdst   R[ Rdst ] ? X[++SP];
            alu_op = 4'b1000;     ////////////////NOP
            register_write = 1'b1;
            alu_src = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b1;
            mem_read = 1'b1;
            stack_or_data = 1'b0;
            inc_dec_sp = 1'b0;
            imm = 1'b0;
            ldd_or_std = 1'b0;
        end
        
          3'b011: begin //LDD Rsrc, Rdst    Load value from memory address Rdst to register Rdst     R[ Rdst ] ? M[Rsrc];
            alu_op = 4'b1000;     ////////////////NOP
            register_write = 1'b1;
            alu_src = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b1;
            mem_read = 1'b1;
            stack_or_data = 1'b1;
            inc_dec_sp = 1'b0;
            imm = 1'b0;
            ldd_or_std = 1'b0;
        end
        
          3'b100: begin //STD Rsrc, Rdst      Store value in register Rsrc to memory location Rdst      M[Rdst] ?R[Rsrc];
            alu_op = 4'b1000;     ////////////////NOP
            register_write = 1'b0;
            alu_src = 1'b0;
            mem_write = 1'b1;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            stack_or_data = 1'b1;
            inc_dec_sp = 1'b0;
            imm = 1'b0;
            ldd_or_std = 1'b1;
        end
        
          3'b010: begin //LDM Rdst, Imm Load      immediate value (16 bit) to register Rdst             R[ Rdst ] ? Imm<15:0>
            alu_op = 4'b1000;     ////////////////NOP
            register_write = 1'b1;
            alu_src = 1'b1;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            stack_or_data = 1'b1;
            inc_dec_sp = 1'b0;
            imm = 1'b1;
            ldd_or_std = 1'b0;
        end
        
          3'b101: begin //SHL Rsrc, Imm            Shift left Rsrc by #Imm bits and store result in same register
            alu_op = 4'b1011;     ////////////////SHL
            register_write = 1'b1;
            alu_src = 1'b1;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            stack_or_data = 1'b1;
            inc_dec_sp = 1'b0;
            imm = 1'b1;
            ldd_or_std = 1'b0;
        end
        
          3'b110: begin //SHR Rsrc, Imm             Shift right Rsrc by #Imm bits and store result in same register
            alu_op = 4'b1100;     ////////////////SHR
            register_write = 1'b1;
            alu_src = 1'b1;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            stack_or_data = 1'b1;
            inc_dec_sp = 1'b0;
            imm = 1'b1;
            ldd_or_std = 1'b0;
        end                         
  endcase
end
    2'b11: begin //jump and stack instructions
      alu_op = 4'b1000;     ////////////////NOP
      alu_src = 1'b0;
      in_port = 1'b0;
      imm = 1'b0;
      case(opcode)
          3'b000: begin //JZ Rdst                  Jump if zero           If (Z=1): PC ?R[ Rdst ]; (Z=0)
            register_write = 1'b1;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            jump_type = 2'b01;
            stack_or_data = 1'b1;
            pc_to_stack = 1'b0;
            inc_dec_sp = 1'b0;
            ldd_or_std = 1'b0;
            unconditional_jump = 1'b0;
            ret = 1'b0;
          	 rti = 1'b0;
            call = 1'b0;  
        end
        
          3'b001: begin //JN Rdst                  Jump if negative        If (N=1): PC ?R[ Rdst ]; (N=0)
            register_write = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            jump_type = 2'b00;
            stack_or_data = 1'b1;
            pc_to_stack = 1'b0;
            inc_dec_sp = 1'b0;
            ldd_or_std = 1'b0;
            unconditional_jump = 1'b0;
            ret = 1'b0;
          	 rti = 1'b0;
            call = 1'b0;
        end
        
          3'b010: begin //JC Rdst                   Jump if carry      If (C=1): PC ?R[ Rdst ]; (C=0)
            register_write = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            jump_type = 2'b10;
            stack_or_data = 1'b1;
            pc_to_stack = 1'b0;
            inc_dec_sp = 1'b0;
            ldd_or_std = 1'b0;
            unconditional_jump = 1'b0;
            ret = 1'b0;
          	 rti = 1'b0;
            call = 1'b0; 
        end
        
          3'b011: begin //JMP Rdst                   Jump                 PC ?R[ Rdst ]

            register_write = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            jump_type = 2'b11;
            stack_or_data = 1'b1;
            pc_to_stack = 1'b0;
            inc_dec_sp = 1'b0;
            ldd_or_std = 1'b0;
            unconditional_jump = 1'b1;
            ret = 1'b0;
          	 rti = 1'b0;
            call = 1'b0; 
        end
        
          3'b100: begin //CALL Rdst           (X[SP] ? PC + 1; sp-2; PC ? R[ Rdst ])
            register_write = 1'b0;
            mem_write = 1'b1;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            jump_type = 2'b00;
            stack_or_data = 1'b0;
            pc_to_stack = 1'b1;
            inc_dec_sp = 1'b1;
            ldd_or_std = 1'b1;
            unconditional_jump = 1'b0;
            ret = 1'b0;
          	 rti = 1'b0;
            call = 1'b1; 
        end   
        
          3'b101: begin //RET sp+2, PC ?X[SP]
            register_write = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b1;
            jump_type = 2'b00;
            stack_or_data = 1'b0;
            pc_to_stack = 1'b1;
            inc_dec_sp = 1'b0;
            ldd_or_std = 1'b0;
            unconditional_jump = 1'b0;
            ret = 1'b1;
          	 rti = 1'b0;
            call = 1'b0; 
        end 
        
          3'b110: begin //RTI sp+2; PC ? X[SP]; Flags restored
            register_write = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b1;
            jump_type = 2'b00;
            stack_or_data = 1'b0;
            pc_to_stack = 1'b1;
            inc_dec_sp = 1'b0;
            ldd_or_std = 1'b0;
            unconditional_jump = 1'b0;
            ret = 1'b0;
          	 rti = 1'b1;
            call = 1'b0;
        end                                                  
    endcase
    end
	default: 
	begin
	    register_write = 1'b0;
            alu_src = 1'b0;
            mem_write = 1'b0;
            mem_to_register = 1'b0;
            mem_read = 1'b0;
            jump_type = 2'b00;
            in_port = 1'b0;
            stack_or_data = 1'b0;
            pc_to_stack = 1'b0;
            inc_dec_sp = 1'b0;
            imm = 1'b0;
            ldd_or_std = 1'b0;
            unconditional_jump = 1'b0;    
            alu_op = 4'b1000;
            ret = 1'b0;
          	 rti = 1'b0;
            call = 1'b0; 
	end      
endcase 
end
endmodule