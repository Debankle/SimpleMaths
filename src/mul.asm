bits 64

global _mul
extern _abs
extern _add


section .bss
    num1: resb 1
    num2: resb 1


section .data
    negCount: equ 0


section .text

    _mul:
        push rbp
        mov rbp, rsp

        mov [ rel num1 ], rdi
        mov [ rel num2 ], rsi

        cmp qword[ rel num1 ], 0
        jle num1Neg

        cmp qword[ rel num2 ], 0
        jle num2Neg

        cmp qword[ rel num1 ], 0
        je zero

        cmp qword[ rel num2 ], 0
        je zero

        mov rdx, 0
        mov rcx, 0

    loop:
        cmp rdx, qword[ rel num2 ]
        je done

        inc rdx
        mov rdi, [ rel num1 ]
        mov rsi, rcx
        call _add
        mov rcx, rax

        jmp loop

    num1Neg:
        inc qword[ negCount ]
        mov rdi, [ rel num1 ]
        call _abs
        mov qword[ rel num1 ], rax
        ret

    num2Neg:
        inc qword[ negCount ]
        mov rdi, [ rel num1 ]
        call _abs
        mov qword[ rel num2 ], rax
        ret

    zero:
        mov rax, 0

        pop rbp
        ret

    done:
        pop rbp
        ret