	ori $6 $0 0x5000
	ori $2 $0 0x6000
	slt $3 $1 $2
	beq $0 $3 big
small: 	ori $5 $0 0x1212
	j end
big:	ori $5 $0 0x3434
end:	ori $7 $0 0x5
	ori $8 $0 0xffffffff
	sra $9 $8 4
	srl $10 $8 4
	


