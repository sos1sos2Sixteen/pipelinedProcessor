	lui $1 0xfafa
	ori $1 $1 0xcccc
	ori $2 $1 0xeeee
	lui $3 0xecef
	nop
	nop
	bne $0 $1 zero
	ori $10 $0 0xcccc
	ori $8 $0 0x1111
	addu $10 $8 $2
	nop
	nop
zero:	lui $15 0xf000
	ori $15 $15 0xcccc
	sra $15 $15 5
	nop
	nop
	nop
	break
	