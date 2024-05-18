main: 
    addi sp, sp, -120
    addi s0, sp, 0

    addi t1, zero, 20
    sw t1, 0(s0)
    addi t1, zero, 19
    sw t1, 4(s0)
    addi t1, zero, 18
    sw t1, 8(s0)
    addi t1, zero, 17
    sw t1, 12(s0)
    addi t1, zero, 16
    sw t1, 16(s0)
    addi t1, zero, 15
    sw t1, 20(s0)
    addi t1, zero, 14
    sw t1, 24(s0)
    addi t1, zero, 13
    sw t1, 28(s0)
    addi t1, zero, 12
    sw t1, 32(s0)
    addi t1, zero, 11
    sw t1, 36(s0)
    addi t1, zero, 10
    sw t1, 40(s0)
    addi t1, zero, 9
    sw t1, 44(s0)
    addi t1, zero, 8
    sw t1, 48(s0)
    addi t1, zero, 7
    sw t1, 52(s0)
    addi t1, zero, 6
    sw t1, 56(s0)
    addi t1, zero, 5
    sw t1, 60(s0)
    addi t1, zero, 4
    sw t1, 64(s0)
    addi t1, zero, 3
    sw t1, 68(s0)
    addi t1, zero, 2
    sw t1, 72(s0)
    addi t1, zero, 1
    sw t1, 76(s0)

    addi t3, zero, 20

    addi s1, zero, 0
    addi t1, s0, 0

    L1:
        bge s1, t3, END_L1 

        addi s2, s1, 1

        addi t2, t1, 4
        jal zero, L2 

        L2:
            bge s2, t3, L1Add 

            lw t4, 0(t1) 
            lw t5, 0(t2) 
            bge t5, t4, L2Add 

            sw t4, 0(t2) 
            sw t5, 0(t1) 

        L2Add:
            addi s2, s2, 1 
            addi t2, t2, 4
            jal zero, L2 

        L1Add:
            addi s1, s1, 1 
            addi t1, t1, 4
            jal zero, L1 

    END_L1:
