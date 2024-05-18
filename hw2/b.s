	.file	"b.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -108(%rbp)
	movl	$0, -104(%rbp)
	movl	$0, -100(%rbp)
	jmp	.L2
.L6:
	movl	-108(%rbp), %eax
	movl	%eax, -104(%rbp)
	jmp	.L3
.L5:
	movl	-108(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %edx
	movl	-104(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %eax
	cmpl	%eax, %edx
	jle	.L4
	movl	-104(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %eax
	movl	%eax, -100(%rbp)
	movl	-108(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %edx
	movl	-104(%rbp), %eax
	cltq
	movl	%edx, -96(%rbp,%rax,4)
	movl	-108(%rbp), %eax
	cltq
	movl	-100(%rbp), %edx
	movl	%edx, -96(%rbp,%rax,4)
.L4:
	addl	$1, -104(%rbp)
.L3:
	cmpl	$19, -104(%rbp)
	jle	.L5
	addl	$1, -108(%rbp)
.L2:
	cmpl	$19, -108(%rbp)
	jle	.L6
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 13.2.1 20230801"
	.section	.note.GNU-stack,"",@progbits
