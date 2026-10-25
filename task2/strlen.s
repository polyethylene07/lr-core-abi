#遇到\0就结束 推测需要用循环 条件跳转 如果不是某个东西 就回到某一行 使用while(1)吧

.text                               #切换到代码段。下面的指令都放到 .text 链接器会把 .text 映射到可执行内存。
.globl my_strlen                    #把 my_strlen 声明为全局符号，别的 .o 文件 或 main 能看见并调用它。不加 .globl 就是本文件私有。

my_strlen:
    pushq   %rbp
    movq    %rsp, %rbp
    #movq    %rdi, -40(%rbp)      #输入进来的字符串 此处直接使用rdi吧 不会被修改 这里删了
    #movq    $0,-56(%rbp)         #int i = 0 用不着保存 随用随扔 这里也删了 
    movq    $0,%rdx              #rdx = i
    movq    $0,%rax              #ret_int = 0
    jmp L1                       #while 1
L1:
    #movq  -40(%rbp), %rsi       #rsi = 字符串指针 不用rbp保存了 删了吧
    leaq    (%rdi,%rdx), %rcx    #rcx = 字符串首地址 + i
    #movq    (%rcx),%rsi          #rsi现在是字符 有问题 这样一次读八字节 删掉
    #cmp     $0, %rsi             #看看是不是\0 有问题 八字节很可能有\0但是误以为没有 删掉
    movzbl  (%rcx), %esi         #只读一个字节 esi = 第 i 个字符
    testb   %sil, %sil           #是否为 '\0' 用sil低八位寄存器
    je L2
    add     $1,%rax              #ret_int++
    add     $1,%rdx              #i++
    jmp L1
L2:
    movq    %rbp,%rsp
    popq    %rbp
    ret
