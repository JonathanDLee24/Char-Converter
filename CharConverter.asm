#practicelab.asm
#Jonathan Lee
#CSC35
#Professor Devin Cook

.intel_syntax noprefix
.data # does not have section like intels website

userMsg:
	.ascii "---> Please enter a Character: \0"

Greeting:
	.ascii "Hello, World!\n\0"

Name:
	.ascii "My Name Is Jonathan David Lee\n\0"

NewLine:
	.ascii "\n\0"

Entered:
	.ascii "You entered: \0"

Hex:
	.ascii "In Hex: \0"

Binary:
	.ascii "In Binary: \0"

Decimal:
	.ascii "In Dec: \0"

Zero:
	.ascii "0\0"

One:
	.ascii "1\0"

runagain:
	.ascii "Run More (y/n)? \0"

goodbye:
	.ascii "Sacramento State Stingers UP!!!!\n\0"
.text

.global _start

_start:
	run:
	mov rax, 0
	mov rdi, 0
	lea rdi, Greeting
	call WriteString

	lea rdi, Name
	call WriteString
	
	lea rdi, userMsg
	call WriteString
	call ReadChar #get char from user
	mov  al, dil #store in al

	lea rdi, Entered
	call WriteString
	mov dil, al
	call WriteChar #show what user entered
	
	lea rdi, NewLine
	call WriteString
	lea rdi, Hex
	call WriteString
	mov dil, al
	call WriteHexByte #show what user entered in hex
	
	lea rdi, NewLine
	call WriteString			 
	#call WriteRegisters
	lea rdi, Decimal
	call WriteString
	mov rdi, rax
	call WriteInt    #show what user entered in decimal
	
	lea rdi, NewLine
	call WriteString
	lea rdi, Binary
	call WriteString
	lea rdi, Zero
	call WriteString
	mov rdx, 64 #loop starts with 64 not 128 and 64,32,16,8,4,2,1
	mov ecx, 7 #loop iterator uses ecx and will loop 7 times drecrements 1 time each iteration
	mov r8, rax #for use with loop so div works

	loopBinary:
		cmp r8, rdx # compare rax to 64 stored at rdx
		jl printZero # if it is less than < goto printZero
		printOne:
			sub r8, rdx
                        lea rdi, One
                        call WriteString
			jmp end #must skip printZero togo end
	
		printZero:
                      	lea rdi, Zero
                	call WriteString
		end:			
			mov al,dl
			mov bl,2
			div bl
			mov rdx,rax
			#call WriteRegisters #testpoint
			loop loopBinary
	
	lea rdi, NewLine
	call WriteString
	lea rdi, runagain
	call WriteString
	call ReadChar
	mov al,'y'
	cmp al,dil
		je run
	lea rdi, goodbye
	call WriteString
	#rol rdi, 2 #rotate left
	#ror rdi, 2 #rotate right
	#call WriteString
	call Exit
