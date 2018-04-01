	ori $1 $0 0x0
	nop
	nop
	beq $1 $0 zero
	nop
	nop
	lui $3 0xfcab
	ori $3 $0 0xcabc
zero:	ori $4 $0 0xffff
	nop
	nop
	nop
	break