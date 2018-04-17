	lui $1 0xfafa
	ori $1 $1 0xcccc
	ori $2 $1 0xeeee
	lui $3 0xecef
	nop
	ori $4 $3 0xdfdf
	nop
	nop
	sw $4 0($0)
	lw $11 0($0)
	nop
	nop
	nop
	break
	