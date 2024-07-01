add s1, zero, zero
addi s2, zero, 2000

Loop: 
    lw t1, 1100(s2)
    lw t2, 2000(s2)
    sub s1, t1, t2
    slt t3, s1, zero
    bne t3, zero, L1
    sub s1, zero, s1

L1: 
    sw s1, 3100(s2)
    addi s2, s2, -4
    bne s2, zero, Loop