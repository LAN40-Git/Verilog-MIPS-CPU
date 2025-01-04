# 初始化寄存器
addi $k1, $zero, 2 # 预测结果：regi[27] = 00000002
addi $gp, $zero, 6 # 预测结果：regi[28] = 00000006
addi $sp, $zero, 5 # 预测结果：regi[29] = 00000005
addi $fp, $zero, 2 # 预测结果：regi[30] = 00000002
addi $ra, $zero, 4 # 预测结果：regi[31] = 00000004

BNE_TO_J:
bne $k1, $fp, J

# ADDI,ADDIU,SLTI,SLTIU
addi $at, $gp, 1 # 预测结果：regi[1] = 00000001
addiu $v0, $sp, 2 # 预测结果：regi[2] = 00000007
slti $v1, $fp, 3 # 预测结果：regi[3] = 00000001
sltiu $a0, $ra, 5 # 预测结果：regi[4] = 00000001
# ANDI,ORI,XORI
andi $a1, $at, 4 # 预测结果：regi[5] = 00000004
ori $a2, $v0, 5 # 预测结果：regi[6] = 00000007
xori $a3, $v1, 6 # 预测结果：regi[7] = 00000007
# SW,LW
sw $gp, 0($zero) # 预测结果：mem[0] = 00000006
lw $t0, 0($zero) # 预测结果：regi[8] = 00000006
addi $fp, $zero, 1 # 预测结果：regi[30] = 00000001，为跳转作准备
# BEQ,BNE,J
beq $a1, $ra, BNE_TO_J
J:
j J # 预测会进入死循环