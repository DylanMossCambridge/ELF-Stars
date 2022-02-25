section .data                                ; store string constants
  question db "How many lines?", 10
  star db "*"
  newline db "", 10

section .bss                                 ; store buffer area for user input 
  lines resb 1

section .text                                ; program start point 
  global _start

_start:
  call _printNewLine
  call _printQuestion
  call _getLines
  mov r8, r12                                ; r8 stores number of lines 
  mov r9, 0                                  ; r9 stores outer loop variable 
  cmp r8, r9
  jz _exit                 
  call _outerLoop

_exit:
  call _printNewLine
  mov rax, 60
  mov rdi, 0
  syscall

_outerLoop:
  call _printNewLine
  cmp r8, r9                                  ; checks if r8 = r9 
  jz _exit                                    ; jump to exit if the result is 0 (ie. they are equal) 
  add r9, 1
  mov r10, 0                                  ; r10 stores inner loop variable 
  jmp _innerLoop

_innerLoop: 
  cmp r9, r10
  jz _outerLoop
  add r10, 1
  call _printStar
  jmp _innerLoop

_printQuestion:
  mov rax, 1                                  ; sys_write 
  mov rdi, 1                                  ; stdout 
  mov rsi, question                           ; word to write 
  mov rdx, 16                                 ; number of bytes to write
  syscall                                     ; call system to write word to stdout
  ret

_printNewLine:
  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall
  ret

_printStar:
  mov rax, 1                                
  mov rdi, 1
  mov rsi, star
  mov rdx, 1
  syscall
  ret

_getLines: 
  mov rax, 0                                  ; sys_read
  mov rdi, 0                                  ; stdin 
  mov rsi, lines                              ; buffer space to read word 
  mov rdx, 1                                  ; number of bytes to read
  syscall                                     ; call system to read word from stdin 
  mov r12, [rsi]
  sub r12, 48                                 ; convert ascii string to int 
  ret                  
