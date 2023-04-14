%include "asm_io.inc"

section .data
msg1: db "out of range!", 10, 0
msg2: db "unexpected operator!", 10, 0
msg3: db "division by zero!", 10, 0

section .text
    global asm_main
asm_main:
    enter 0, 0
    pusha

    call read_int
    mov ebx, eax
    call read_char
    mov ecx, eax
    call read_int

    cmp ecx, "+"
    je res1
    cmp ecx, "-"
    je res2
    cmp ecx, "*"
    je res3
    cmp ecx, "/"
    je res4
    cmp ecx, "%"
    je res5
    
    mov eax, msg2
    call print_string
    jmp end3

res1:
    add eax, ebx
    jmp end1

res2:
    sub eax, ebx
    neg eax
    jmp end1

res3:
    mov edx, 0
    imul ebx
    cmp edx, 0
    jne end2
    jmp end1

res4:
    mov edx, 0
    xchg eax, ebx
    cmp ebx, 0
    jz diverr
    cdq ; cdq is how you get the equivalent signed 64-bit dividend needed by IDIV
    idiv ebx
    jmp end1

res5:
    mov edx, 0
    xchg eax, ebx
    cmp ebx, 0
    jz diverr
    cdq
    idiv ebx
    mov eax, edx
    cmp edx, 0
    js mkrm
    jmp end1


diverr:
    mov eax, msg3
    call print_string
    jmp end3

mkrm:
    add eax, ebx ; make the remaining positive

end1:
    call print_int
    call print_nl
    jmp end3

end2:
    neg edx
    dec edx
    cmp edx, 0
    je end1
    mov eax, msg1
    call print_string

end3:
    popa
    leave
    ret