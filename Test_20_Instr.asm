L0:	lui   $s1,0x1000
	ori $s1,$s1,0x2211   
	lui   $s2,0x1000
	ori $s2,$s2,0x4433  
	lui  $s3,0x3000
	ori $s3,$s3,0x5566  
	addu $s4, $s2, $s1
	subu $s6, $s3, $s2
     	sw $s4, 0($0)
      	sw $s6, 4($0)
      	lw $s5, 0($0)
     	slt $t0,$s4,$s6
      	beq $t0, $0, L2
L1:   	lw $s3, 4($0)
       	j  L3
L2:  	slt $t1,$s5,$s2
     	beq $t1, $0, L1
L3:  	ori $s1,$0,0x10  
      	sll $s2, $s1, 4 
      	srl $s2, $s1, 4 
      	j  L0
  