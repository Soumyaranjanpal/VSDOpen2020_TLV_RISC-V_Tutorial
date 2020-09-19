\m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/VSDOpen2020_TLV_RISC-V_Tutorial
   
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/VSDOpen2020_TLV_RISC-V_Tutorial/da942f09ddf780e5da5ee0466c72a610f07aa73f/lib/shell.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   /* verilator lint_on WIDTH */

\TLV

   
   // ------------------------------------------------------------
   //
   // /====================\
   // | Sum 1 to 9 Program |
   // \====================/
   //
   // Program for MYTH Workshop to test RV32I
   // Add 1,2,3,...,9 (in that order).
   //
   // Regs:
   //  r10 (a0): In: 0, Out: final sum
   //  r12 (a2): 10
   //  r13 (a3): 1..10
   //  r14 (a4): Sum
   // 
   // External to function:
   m4_asm(ADD, r10, r0, r0)             // Initialize x10 to 0.
   // Function:
   m4_asm(ADD, r14, r10, r0)            // Initialize sum register x14 with 0x0
   m4_asm(ADDI, r12, r10, 1010)         // Store count of 10 in register x12.
   m4_asm(ADD, r13, r10, r0)            // Initialize intermediate sum register x13 with 0
   // Loop:
   m4_asm(ADD, r14, r13, r14)           // Incremental addition
   m4_asm(ADDI, r13, r13, 1)            // Increment intermediate register by 1
   m4_asm(BLT, r13, r12, 1111111111000) // If x13 is less than x12, branch to <loop>
   m4_asm(ADD, r10, r14, r0)            // Store final result to register x10 so that it can be read by main program
   //
   // ------------------------------------------------------------
   
   
   // Lab: PC
   $pc[31:0] = >>1$reset        ? 32'0 :
               >>1$taken_branch ? >>1$br_target_pc :    // (initially $taken_branch == 0)
                                  >>1$pc + 32'b100;
   
   
   // Lab: Fetch
   $imem_rd_addr[2:0] = TBD;
   $instr[31:0] = TBD;
   
   
   // Lab: Instruction Types Decode
   $is_i_instr = $instr[6:5] == 2'b00;
   $is_r_instr = TBD;
   $is_b_instr = TBD;
   
   
   // Lab: Instruction Immediate Decode
   $imm[31:0]  = $is_i_instr ? { {21{$instr[31]}}, $instr[30:20] } :   // I-type
                 //TBD    // B-type
                 32'b0;   // Default (unused)
   
   
   // Lab: Instruction Field Decode
   $rs2[4:0]    = $instr[24:20];
   $rs1[4:0]    = TBD;
   $funct3[2:0] = TBD;
   $rd[4:0]     = TBD;
   $opcode[6:0] = TBD;
   
   
   // Lab: Register Validity Decode
   $rs1_valid = $is_r_instr || $is_i_instr || $is_b_instr;
   $rs2_valid = TBD;
   $rd_valid  = TBD;
   
   
   // Lab: Instruction Decode
   $dec_bits[9:0] = {$funct3, $opcode};
   $is_blt  = $dec_bits == 10'b100_1100011;
   $is_addi = TBD;
   $is_add  = TBD;
   
   
   // Lab: Register File Read
   $rf_rd_en1         = TBD;
   $rf_rd_en2         = TBD;
   $rf_rd_index1[4:0] = TBD;
   $rf_rd_index2[4:0] = TBD;
   
   $src1_value[31:0] = TBD;
   $src2_value[31:0] = TBD;
   
   
   // Lab: ALU
   $result[31:0] = $is_addi ? $src1_value + $imm :    // ADDI: src1 + imm
                   //TBD   // ADD: src1 + src2
                              32'b0;   // Default (unused)
   
   
   // Lab: Register File Write
   $rf_wr_en         = TBD;
   $rf_wr_index[4:0] = TBD;
   $rf_wr_data[31:0] = TBD;
   
   
   // Lab: Branch Condition
   $taken_branch = TBD;
   
   
   // Lab: Branch Target
   $br_target_pc[31:0] = TBD;
   // $taken_branch and $br_target_pc control the PC mux.
   
   
   
   m4+shell()


\SV
   endmodule
