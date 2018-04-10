	ori $1 $0 0x234
	nop
	nop
	
	beq $1 $0 zero
	lui $3 0xfcab
	ori $3 $3 0xcabc
	nop
	nop
	nop
	nop
zero:	ori $4 $0 0xffff
	nop
	nop
	nop
	nop
	break
