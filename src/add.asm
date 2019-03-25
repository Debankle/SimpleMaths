bits 64

global _add


section .text

    _add:
        push rbp
        mov rbp, rsp

        add rdi, rsi
        mov rax, rdi

        pop rbp
        ret