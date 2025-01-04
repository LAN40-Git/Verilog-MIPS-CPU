# 初始化寄存器
addi $gp, $zero, 6 # 预测结果：regi[28] = 00000006
addi $sp, $zero, 5 # 预测结果：regi[29] = 00000005
addi $fp, $zero, 2 # 预测结果：regi[30] = 00000002
addi $ra, $zero, 4 # 预测结果：regi[31] = 00000004

# ADD,ADDU,SUB,SUBU
add $at, $gp, $sp # 预测结果：regi[1] = 0000000B
addu $v0, $gp, $sp # 预测结果：regi[2] = 0000000B
sub $v1, $gp, $sp # 预测结果：regi[3] = 00000001
subu $a0, $gp, $sp # 预测结果：regi[4] = 00000001
# SLT,SLTU
slt $a1, $gp, $sp # 预测结果：regi[5] = 00000000
sltu $a2, $fp, $ra # 预测结果：regi[6] = 00000001
# AND,OR,XOR,NOR
and $a3, $gp, $sp # 预测结果：regi[7] = 00000004
or $t0, $gp, $sp # 预测结果：regi[8] = 00000007
xor $t1, $gp, $sp # 预测结果：regi[9] = 00000003
nor $t2, $gp, $sp # 预测结果：regi[10] = FFFFFFF8
# SLL,SRL,SRA
sll $t3, $gp, 2 # 预测结果：regi[11] = 00000018
srl $t4, $gp, 2 # 预测结果：regi[12] = 00000001
sra $t5, $gp, 2 # 预测结果：regi[13] = 00000001
# SLLV,SRLV,SRAV
sllv $t6, $gp, $sp # 预测结果：regi[14] = 000000c0
srlv $t7, $gp, $sp # 预测结果：regi[15] = 00000000
srav $s0, $gp, $sp # 预测结果：regi[16] = 00000000
# JR
jr $ra # 预测结果：PC = 00000004