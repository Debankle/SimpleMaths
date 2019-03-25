bits 64

global _main

extern _sub
extern _exit
extern _printf

section .data
    num1: equ 4
    num2: equ 5
    intFmt: db "%d", 0xa, 0

section .text

    _main:
        push rbp
        mov rbp, rsp

        mov rdi, num1
        mov rsi, num2
        call _sub

        lea rdi, [ rel intFmt ]
        mov rsi, rax
        call _printf

        mov rdi, 0
        call _exit