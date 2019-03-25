bits 64

global _abs
extern _mul

section .text

    _abs:
        push rbp
        mov rbp, rsp

        mov rcx, rdi
        sar rdx, 30
        or rdx, 01H

        mov rdi, rcx
        mov rsi, rdx
        call _mul

        mov rax, rax

        pop rbp
        ret