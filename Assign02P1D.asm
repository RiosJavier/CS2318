##########################################################################
#  Javier Rios, CS 2318-003, Assignment 2 Part 1 Program D
#
#  MIPS assembly program that lets user calculate weighted average score
#  as follows:
#  Prompt the user to enter the integer scores for Exam 1, Exam 2 and
#  Final Exam, read the scores, compute the weighted average score
#  (using the following formula), and display a labeled output about
#   the weighted average score.
# 
#  avgScore = (256/1109)e1Score + (277/1024)e2Score + (finScore/2)
#
#  IMPORTANT (for the purpose of this exercise, be sure to observe the
#  following):
#  You MUST perform (in the appropriate order, of course) ALL the
#  additions, multiplications and divisions shown in the given formula.
#  (You should NOT resort to simplifying the formula in some way, perhaps
#  to make the computation more efficient.)
#  You MUST use bit-shifting to effect multiplications and divisions
#  involving powers of 2.
#
#  Note that 2, 256 and 1024 correspond to some powers of 2 (but not 277
#  and 1109).
#
#  You are NOT to replace 277 and 1109 (that are not powers of 2) with
#  their "sum-of-powers-of-2" equivalents.
#  When evaluating the first and second terms on the right hand side
#  (i.e., the Exam 1 and Exam 2 contributions, respectively), assume it
#  is the intent to simply discard the fractional portion when a division
#  is performed.
#
#  However, you MUST perform (in each case) the division after 
#  (NOT before) the multiplication (otherwise, accuracy may be 
#  unnecessarily lost).
#
#  For any multiplication and division operation that cannot be effected
#  with simple (one-time) bit-shifting, you MUST use another "true"
#  instruction (NOT a pseudoinstruction) instead.
#
#  Note that mulo Rdest, Rsrc1, Rsrc2 and mulou Rdest, Rsrc1, Rsrc2 are
#  pseudoinstructions.
#  Note that div Rdest, Rsrc1, Rsrc2 and divu Rdest, Rsrc1, Rsrc2 are
#  pseudoinstructions.
#
#  CAUTION: 
#  Too many past students regretted having points taken off for not
#  labeling output.
##########################################################################
			.data
scorePrompt0:		.asciiz "Enter Interger Score for Exam 1: "
scorePrompt1:		.asciiz "Enter Interger Score for Exam 2: "
scorePrompt2:		.asciiz "Enter Interger Score for Final Exam: "
avgMsg:			.asciiz "The Weighted Average is: "

			.text
			.globl main
main:
			li $v0, 4
			la $a0, scorePrompt0
			syscall
			
			li $v0, 5
			syscall
			move $t0, $v0
			
			li $v0, 4
			la $a0, scorePrompt1
			syscall
			
			li $v0, 5
			syscall
			move $t1, $v0
			
			li $v0, 4
			la $a0, scorePrompt2
			syscall
			
			li $v0, 5
			syscall
			move $t2, $v0
			
			#multiplication of score 1
			sll $t0, $t0, 7
			#multiplication of score 2
			li $t5, 154
			mul $t1, $t1, $t5
			#division of score 1
			li $t5, 642
			div $t0, $t5
			mflo $t0
			#division of score 2
			sra $t1, $t1, 9
			
			#final exam division
			sra $t2, $t2, 1
			
			
			li $t4, 0
			add $t4, $t4, $t0
			add $t4, $t4, $t1
			add $t4, $t4, $t2
			
			li $v0, 4
			la $a0, avgMsg
			syscall
			
			li $v0, 1
			move $a0, $t4
			syscall
			
			li $v0, 10
			syscall
