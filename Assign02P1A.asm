##########################################################################
# Javier Rios, CS 2318-003, Assignment 2 Part 1 Program A
#
# Program Description
# Program to do the following (in the order described):
#
# Prompt the user to enter an integer, read the user's input, and
# display a labeled output about the user's input.
#
# Prompt the user to enter a string of up to 80 characters long, read
# the user's input, and display a labeled output about the user's input.
# - String entered MUST be stored in separate storage space (i.e., not
# overwriting the storage space used by prompt and label strings)
# allocated just enough (no more, no less) to accommodate up to the
# maximum number of characters indicated.
# Prompt the user to enter a character, read the user's input, and
# display a labeled output about the user's input.
# - Note that it involves a character, NOT a one-charater string. You
# will get no credits if you do it using a one-character string
# even though the same output is obtained.
#
# The exact strings to use for user-prompting and output-labeling are
#  left to your discretion - do keep each reasonably
#  short/crisp/meaningful, however.
# Also, be sure to introduce appropriate spaces and newlines to make what
# appears on the Run I/O window (of MARS) reasonably readable.
#
#  CAUTION:
# Too many past students regretted having points taken off for failing
# to do one or more of these:
# - not separately "prompt then read then display" each type of data
# -- e.g.: "prompt then read all 3 types" followed by
#    "display all 3 types"
# - not appropriately "introduce spaces and newlines" to make interative
#   I/O (what appears on the Run I/O window) reasonably readable
#   (e.g.: items "not-logically-belonging-together" appear in one line,
#    perhaps also running together)
##########################################################################

			.data
promptInt:		.asciiz "\nSection ID (2 or 3): "
promptStr:		.asciiz "\nHalloween costume (up to 25 characters): "
promptChar:		.asciiz "One-character nikcname: "	
msgInt:			.asciiz "Hey you of CS2318.00"
msgStr:			.asciiz "LOL! "
msgChar:		.asciiz "\nYippee! "
str:			.space 26
			.text
			.globl main
main:
			li $v0, 4
			la $a0, promptInt
			syscall	
			
			li $v0, 5
			syscall
			move $t0, $v0
			
			li $v0, 4
			la $a0, msgInt
			syscall
			
			li $v0, 1
			move $a0, $t0
			syscall
			
			li $v0, 4
			la $a0, promptStr
			syscall
			
			li $v0, 8
			la $a0, str
			li $a1, 81
			
			syscall
			
			li $v0, 4
			la $a0, msgStr
			syscall
			
			li $v0, 4
			la $a0, str
			syscall
			
			li $v0, 4
			la $a0, promptChar
			syscall
			
			li $v0, 12
			syscall
			
			move $t1, $v0
			
			li $v0, 4
			la $a0, msgChar
			syscall
			
			li $v0, 11
			move $a0, $t1
			syscall
			
			li $v0, 10
			syscall
