section .data
  question db "How many lines?", 10
  star db "*"
  newline db "", 10

section .bss 
  lines resb 1

section .text
  global _start

_start:
  call _printNewLine
  call _printQuestion
  call _getLines
  mov r8, r12
  mov r9, 0
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
  cmp r8, r9
  jz _exit
  add r9, 1
  mov r10, 0
  jmp _innerLoop

_innerLoop: 
  cmp r9, r10
  jz _outerLoop
  add r10, 1
  call _printStar
  jmp _innerLoop

_printQuestion:
  mov rax, 1
  mov rdi, 1
  mov rsi, question
  mov rdx, 16
  syscall
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
  mov rax, 0 
  mov rdi, 0
  mov rsi, lines
  mov rdx, 1
  syscall
  mov r12, [rsi]
  sub r12, 48
  ret                  