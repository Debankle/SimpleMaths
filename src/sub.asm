bits 64

global _sub


section .text

    _sub:
        push rbp
        mov rbp, rsp

        sub rdi, rsi
        mov rax, rdi

        pop rbp
        ret