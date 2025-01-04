# bubbleSort
init: # 初始化寄存器
    addi $v0, $zero, 100 # 外循环最大次数
    addi $v1, $zero, 100 # 内循环最大次数
    addi $a0, $zero, 0 # 外循环进行的下标i
    addi $a1, $zero, 0 # 内循环进行的下标j
    addi $t0, $zero, 0 # 临时变量array[i]
    addi $t1, $zero, 0 # 临时变量array[j]
    addi $t2, $zero, 0 # 临时变量temp，用于交换
    addi $t3, $zero, 0 # 临时变量cmp，用于存储比较结果
    addi $k0, $zero, 0 # 临时变量，用于存储下标i与外循环最大次数比较的结果
    addi $k1, $zero, 0 # 临时变量，用于存储下标j与内循环最大次数比较的结果

# 外层循环
out_loop:
# 读取数据存储器中的array[i]
    lw $t0, 0($a0) # 读取数据存储器中的array[i]
# 内层循环
inter_loop:
    addi $a1, $a0, 0 # j = i
# j++
j_increment:
    addi $a1, $a1, 1 # j++
    # 检测j是否超出范围
    slt $k1, $a1, $v1 # 比较j和内循环最大次数，比较结果存入k1寄存器
    beq $k1, $zero, i_increment # 如果$k1=0，说明j>=内循环最大次数，跳出内循环
    # 执行比较和交换
    lw $t1, 0($a1) # 读取数据存储器中的array[j]
    slt $t3, $t1, $t0 # ($t1<$t0)?1:0 比较array[i]和array[j]，结果存入t3
    beq $t3, $zero, j_increment # 如果$t3=0，说明array[j]>=array[i]，此时跳出内循环，否则执行交换
    addi $t2, $t0, 0 # 将array[i]写入临时变量temp
    addi $t0, $t1, 0 # 将array[j]写入array[i]
    addi $t1, $t2, 0 # 取回临时变量temp中的array[i]，写入array[j]
    sw $t1, 0($a1) # 将新的array[j]写入对应的数据存储器单元中
    j j_increment # 继续执行内循环

# i++
i_increment: # 24
    # 将新的array[i]写入对应的数据存储器单元中
    sw $t0, 0($a0)
    addi $a0, $a0, 1 # i++
    # 检测i是否超出范围
    slt $k0, $a0, $v0 # 比较i和外循环最大次数，比较结果存入k0寄存器
    beq $k0, $zero, end # 如果$k0=0，说明i>=外循环最大次数，跳出外循环，程序结束
    j out_loop # 否则重新执行外循环

end: # 排序结束
    j end