#####################################################################
#
# CSC258H Winter 2021 Assembly Final Project
# University of Toronto, St. George
#
# Student: Yanxiang (Jimmy) Lan, 1005463240
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4
# - Unit height in pixels: 4
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the project handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the project handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

.data
    # Display
    displayAddress:	 .word 0x10008000
    screenHeight: .word 21
    screenWeight: .word 21
    unitWidth: .word 12

    # Colors
    backgroundColor: .word 0x00000000
    centipedeColor: .word 0x00ff0000

    # Objects
    centipedeLocations: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9

.globl main
.text


##############################################
# # Initialization
##############################################

main:
    lw			$t0, displayAddress     #
    lw			$s7, unitWidth			# 
    

##############################################
# # Game Loop
##############################################

game_loop_main:
    # Do something
    lw			$t2, centipedeColor				# $t2 = centipedeColor
    sw			$t2, 0($t0)			# 

    add 		$t0, $t0, $s7			# $t0 = $t0 + $t9

    jal			sleep				# jump to sleep and save position to $ra
    
    j			game_loop_main				# jump to game_loop_main


############################################################################################
	
program_exit:
	li $v0, 10 # terminate the program gracefully
	syscall

############################################################################################

##############################################
# # Utilities
##############################################

# FUN sleep
sleep:
    addi		$sp, $sp, -20			# $sp -= 20
    sw			$ra, 0($sp)

    li			$v0, 32				# $v0 = 32
    li			$a0, 50				# $a0 = 50
    syscall

    lw			$ra, 0($sp)
    addi		$sp, $sp, 20			# $sp += 20

    move 		$v0, $zero			# $v0 = $zero
    jr			$ra					# jump to $ra

# END FUN sleep

