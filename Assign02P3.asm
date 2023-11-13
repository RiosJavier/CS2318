###############################################################################
# Title: Assign02P3                   Author: Javier Rios
# Class: CS 2318-003, Fall 2022       Submitted: 11/17/22
###############################################################################
# Program: MIPS translation of a given C++ program
###############################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
###############################################################################
			.data
array1:			.space 50
array2:			.space 50
array3:			.space 50
begA1Str:		.asciiz "\nbeginning a1: "
proA1Str:		.asciiz "processed a1: "
comA2Str:		.asciiz "          a2: "
comA3Str:		.asciiz "          a3: "
einStr:			.asciiz "Enter integer #"
moStr:			.asciiz "Max of "
ieStr:			.asciiz " ints entered..."
emiStr:			.asciiz "Enter more ints? (n or N = no, others = yes) "
dacStr:			.asciiz "Do another case? (n or N = no, others = yes) "
dlStr:			.asciiz "================================"
byeStr:			.asciiz "bye..."
colSpace:		.asciiz ": "
newLine:		.asciiz "\n"

			.text
			.globl main
# 	     		//do 
main:
begDW1:
#               	used1 = 0;
			li $t1, 0
#               	hopPtrU = a1;
			la $t4, array1 
#            		//do
begDW2:
#               	cout << einStr;
			li $v0, 4
			la $a0, einStr
			syscall
#               	cout << (used1 + 1);
			li $v0, 1
			addi $a0, $t0, 1
			syscall
#               	cout << ':' << ' ';
			li $v0, 4
			la $a0, colSpace
			syscall
#               	cin >> *hopPtrU;
			li $v0, 5
			syscall
			move $t4, $v0
#			++used1;
			addi $t1, $t1, 1
#			++hopPtrU;
			addi $t4, $t4, 1		
#               	//if (used1 == 12)
#               	if (used1 != 12) goto else1;
			li $t0, 12
			bne $t1, $t0, else1	
begI1:
#               	cout << moStr;
			li $v0, 4
			la $a0, moStr
			syscall
#               	cout << 12;
			li $v0, 1
			li $a0, 12
			syscall		 
#               	cout << ieStr;
			li $v0, 4
			la $a0, einStr
			syscall
#               	cout << endl;
			li $v0, 4
			la $a0, newLine
			syscall
#               	reply = 'n';
			li $t8, 'n'
#               	goto endI1;
			j endI1
else1:
#             		//else
#			cout << emiStr;
			li $v0, 4
			la $a0, emiStr
			syscall
#              		cin >> reply;
			li $v0, 12
			syscall
			move $t8, $v0
endI1:	
DWTest2:
#             //while (reply != 'n' && reply != 'N');
#             //if (reply != 'n' && reply != 'N')goto begDW2;
#               if (reply == 'n') goto xitDW2;
                	li $t5, 'n'
                	beq $v1, $t5, xitDW2
#               	if (reply != 'N')goto begDW2;
			li $t5, 'N'
			beq $v1, $t5, begDW2
xitDW2:
#               	cout << begA1Str;
			li $v0, 4
			la $a0, begA1Str
			syscall
#               	hopPtrU = a1;
			la $t4, array1
#               	endPtrU = a1 + used1;
			la $t9, array1
			sll $a1, $t1, 2
			add $a1, $a1, $t9 
#//             	while (hopPtrU < endPtrU)
#               	goto WTest1;
			j WTest1
begW1:
#             		//if (hopPtrU == endPtrU - 1)
#               	if (hopPtrU != endPtrU - 1) goto else2;
			addi $t9, $a2, -4
			bne $t4, $t9, else2
begI2:
#               	cout << *hopPtrU << endl;
			li $v0, 1
			lw $a0, 0($t4)
			syscall
			li $v0, 4
			la $a0, newLine
			syscall
#               	goto endI2;
			j endI2
else2:
#//           		else
#               	cout << *hopPtrU << ' ';
			li $v0, 1
			lw $a0, 0($t4)
			syscall
			li $v0, 4
			la $a0, colSpace
			syscall
		
endI2:
#             	  	++hopPtrU;
                	addi $t5, $t5, 4
WTest1:
#               	if (hopPtrU < endPtrU) goto begW1;
			ble $t5, $a2, begF6
#//             for (hopPtrU = a1, hopPtrD = a2, used2 = 0; // multiple initializations
#//             hopPtrU < endPtrU;                          // loop test
#//             	++hopPtrU, ++hopPtrD, ++used2)      // multiple updates
#               	hopPtrU = a1;
                	la $t4, array1
#               	hopPtrD = a2;
			la $t5, array2
#               	used2 = 0; // multiple initializations
			li $t2, 0
#               	goto FTest1;
			j FTest1
begF1:
#               	*hopPtrD = *hopPtrU;
                	lw $t0, 0($t5)
                	sw $t0, 0($t4) 
#               	++hopPtrU;
                	addi $t4, $t4, 4
#               	++hopPtrD;
			addi $t5, $t5, 4
#               	++used2;         // multiple updates
			addi $t1, $t1, 4
FTest1:
#               if (hopPtrD < endPtrU) goto begF1;                     // loop test
			ble $t4, $a2, begF6
#               	hopPtrD = a2;
                	la $t5, array2
#               	endPtrD = a2 + used2;
			la $a2, array2
			sll $t9, $t2, 2
			add $a2, $a2, $t9
#             		//while (hopPtrD < endPtrD)
#               	goto WTest2;
			j WTest2
begW2:
#               	pivot = *hopPtrD;
			lw $t8, 0($t5) 
#             //for (hopPtrD2 = hopPtrD + 1; hopPtrD2 < endPtrD; ++hopPtrD2)
#               hopPtrD2 = hopPtrD + 1;
			addi $t6, $t5, 4
#               	goto FTest2;
                	j FTest2
begF2:
#             		//if (*hopPtrD2 == pivot)
#               	if (*hopPtrD2 != pivot) goto endI3;
			lw $t9, 0($t6)
			bne $t9, $t8, endI3
befI3:
#             //for (hopPtrD3 = hopPtrD2 + 1; hopPtrD3 < endPtrD; ++hopPtrD3)
#               hopPtrD3 = hopPtrD2 + 1
                	addi $t7, $t6, 4
#               	goto FTest3;
                	j FTest3
begF3:
#               	*(hopPtrD3 - 1) = *hopPtrD3;
			lw $t0, 0($t7)
			sw $t0, -4($t7)
#               	++hopPtrD3;
                	addi $t7, $t7, 4
FTest3:
#               	if (hopPtrD3 < endPtrD) goto begF3;
			blt $t7, $a2, begF3              
#               	--used2;
			addi $t2, $t2, -4
#               	--endPtrD;
			addi $a2, $a2, -4
#               	--hopPtrD2;
			addi $t6, $t6, -4
endI3:
#               	++hopPtrD2;
                	addi $t6, $t6, 4
FTest2:
#               	if (hopPtrD2 < endPtrD) goto begF2;
			blt $t6, $a2, begF2 
#               	++hopPtrD;
			addi $t5, $t5, 4
WTest2:
#               	if (hopPtrD < endPtrD) goto begW2;
			blt $t5, $a2, begW2
#               	used3 = 0;
			li $t3, 0
#               	hopPtrT = a3;
			la $t7, array3
#               	hopPtrU = a1;
                	la $t4, array1
#             		//while (hopPtrU < endPtrU)
#              		goto WTest3;
			j WTest3
begW3:
#               	*hopPtrT = *hopPtrU;
			lw $t9, 0($t7)
			sw $t9, 0($t4)
#               	++used3;
			addi $t2, $t2, 4
#               	++hopPtrT;
			addi $t7, $t7, 4
#               	pivot = *hopPtrU;
			lw $t8, 0($t4)
#               	tally = 0;
			li $t5, 0
#             //for (hopPtrU1 = hopPtrU + 1; hopPtrU1 < endPtrU; ++hopPtrU1)
#               hopPtrU1 = hopPtrU + 1;
                	addi $t6, $t4, 4
#               	goto FTest4;
                	j FTest4
begF4:
#//             	if (*hopPtrU1 == pivot)
#               	if (*hopPtrU1 != pivot) goto else4;
			lw $t0, 0($t6)
			bne $t0, $t8, else4
begI4:
#               	++tally;
			addi $t5, $t5, 4
#               	goto endI4;
			j endI4
else4:
#//             	else
#               	*(hopPtrU1 - tally) = *hopPtrU1;
			sll $t9, $t5, 2
			sub $v1, $t6, $t9
			lw $t0, 0($v1)
			sw $t0, 0($t6)
endI4:
#               	++hopPtrU1;
                	addi $t6, $t6, 4
FTest4:
#               	if (hopPtrU1 < endPtrU) goto begF4;
			blt $t6, $a1, begF4
#               	used1 -= tally;
			sub $t1, $t1, $t5
#               	endPtrU -= tally;
			sub $a1, $a1, $t5
#               	++hopPtrU;
			addi $t4, $t4, 4
WTest3:
#               	if (hopPtrU < endPtrU) goto begW3;
			blt $t4, $a1, begW3
#               	cout << proA1Str;
			li $v0, 4
			la $a0, proA1Str
			syscall
#             //for (hopPtrU = a1; hopPtrU < endPtrU; ++hopPtrU)
#               hopPtrU = a1;
                	la $t4, array1
#               	goto FTest5;
			j FTest5
begF5:
#             		//if (hopPtrU == endPtrU - 1)
#               	if (hopPtrU != endPtrU - 1) goto else5;
			addi $t9, $a1, -4
			bne $t4, $t9, else5
begI5:
#               	cout << *hopPtrU << endl;
			li $v0, 1
			lw $a0, 0($t4)
			syscall
			li $v0, 4
			la $a0, newLine
			syscall
#               	goto endI5;
			j endI5
else5:
#             		//else
#               	cout << *hopPtrU << ' ';
			li $v0, 1
			lw $a0, 0($t4)
			syscall
			li $v0, 4
			la $a0, colSpace
			syscall
endI5:
#               	++hopPtrU;
                	addi $t4, $t4, 4
FTest5:
#               	if (hopPtrU < endPtrU) goto begF5;
			blt $t4, $a1, begF5 
#               	cout << comA2Str;
			li $v0, 4
			la $a0, comA2Str
			syscall
#             		//for (hopPtrD = a2; hopPtrD < endPtrD; ++hopPtrD)
#               	hopPtrD = a2;
			la $t5, array2
#               	goto FTest6;
			j FTest6
begF6:
#             		//if (hopPtrD == endPtrD - 1)
#               	if (hopPtrD != endPtrD - 1) goto else6;
			addi $t9, $a2, -4
			bne $t5, $t9, else6
		
begI6:
#             		cout << *hopPtrD << endl;
			li $v0, 1
			lw $a0, 0($t5)
			syscall
			li $v0, 4
			la $a0, newLine
			syscall
#               	goto endI6;
			j endI6
else6:
#             		//else
#               	cout << *hopPtrD << ' ';
			li $v0, 1
			lw $a0, 0($t5)
			syscall
			li $v0, 4
			la $a0, colSpace
			syscall
endI6:
#               	++hopPtrD;
			addi $t5, $t5, 4
FTest6:
#               	if (hopPtrD < endPtrD) goto begF6;
			ble $t5, $a2, begF6
#               	cout << comA3Str;
			li $v0, 4
			la $a0, comA3Str
			syscall
#               	hopPtrT = a3;
                	la $t7, array3
#               	endPtrT = a3 + used3;
			la $t9, array3
			sll $a3, $t3, 2
			add $a3, $a3, $t9 
#             		//while (hopPtrT < endPtrT)
#               	goto WTest4;
                	j WTest4
begW4:
#             		//if (hopPtrT == endPtrT - 1)
#             		if (hopPtrT != endPtrT - 1) goto else7;
			addi $t9, $a3, -4
			bne $t7, $t9, else7	
begI7:
#              		cout << *hopPtrT << endl;
			li $v0, 1
			lw $a0, 0($t7)
			syscall
			li $v0, 4
			la $a0, newLine
			syscall
		
#             		goto endI7;
			j endI7
else7:
#			cout << *hopPtrT << ' ';
			li $v0, 1
			lw $a0, 0($t7)
			syscall
			li $v0, 4
			la $a0, colSpace
			syscall
		
endI7:
#               	++hopPtrT;
			addi $t7, $t7, 4
WTest4:
#               	if (hopPtrT < endPtrT) goto begW4;
			blt $t7, $a3, begW4
#               	cout << endl;
			li $v0, 4
			la $a0, newLine
			syscall
#               	cout << dacStr;
			li $v0, 4
			la $a0, dacStr
			syscall
#               	cin >> reply;
			li $v0, 12
			syscall
			move $t8, $v0
#               	cout << endl;
			li $v0, 4
			la $a0, newLine
			syscall
DWTest1:
#             //while (reply != 'n' && reply != 'N');
#             //if (reply != 'n' && reply != 'N') goto begDW1;
#             	if (reply == 'n') goto xitDW1;
			li $t5, 'n'
			beq $v1, $t5, xitDW1
#             		if (reply != 'N') goto begDW1;
			li $t5, 'N'
			bne $v1, $t5, begDW1
xitDW1:
#			cout << dlStr;
			li $v0, 4
			la $a0, dlStr
			syscall
#			cout << '\n';
			li $v0, 4
			la $a0, newLine
			syscall
#			cout << byeStr;
			li $v0, 4
			la $a0, byeStr
			syscall
#			cout << '\n';
			li $v0, 4
			la $a0, newLine
			syscall
#			cout << dlStr;
			li $v0, 4
			la $a0, dlStr
			syscall
#			cout << '\n';
			li $v0, 4
			la $a0, newLine
			syscall
#             		return 0;
			li $v0, 10
			syscall