#送来一个结构体变量 存着可以放寄存器状态的东西 这个函数的目的是 假装再发生一次同样的函数 并且返回不同的值
    .text
    .globl set_ctx
    .type set_ctx,@function
set_ctx:
    movq %rbx, 0(%rdi)     #记录这个函数发生后的状态
    movq %rbp, 8(%rdi)
    movq %r12, 16(%rdi)
    movq %r13, 24(%rdi)
    movq %r14, 32(%rdi)
    movq %r15, 40(%rdi)

    movq %rsp, 48(%rdi)    #保存当前的rsp栈顶指针 是这个set_ctx函数自己的东西
    movq (%rsp), %rax
    movq %rax, 56(%rdi)    #因为函数没有push 所以现在栈顶是原本的返回地址

    xorq %rax, %rax        #返回0
    ret

    .globl jmp_to
    .type jmp_to,@function
jmp_to:                    #这个函数自己的返回地址不用管了 
    movq 56(%rdi), %r11    #r11 = 保存的返回地址
    movq 48(%rdi), %r10    #r10 = 保存的栈顶指针

    movq 0(%rdi), %rbx
    movq 8(%rdi), %rbp
    movq 16(%rdi), %r12
    movq 24(%rdi), %r13
    movq 32(%rdi), %r14
    movq 40(%rdi), %r15

    movl %esi, %eax        #set_ctx的“第二次返回值” = value

    movq %r10, %rsp        #让栈顶指针变成set的栈顶指针 这个函数自己的栈顶地址自动作废
    addq $8, %rsp          #pop操作
    jmp *%r11              #跳到返回地址
