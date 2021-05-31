// Code generated by command: go run copy_asm.go -pkg mem -out ../mem/copy_amd64.s -stubs ../mem/copy_amd64.go. DO NOT EDIT.

#include "textflag.h"

// func Copy(dst []byte, src []byte) int
// Requires: AVX, CMOV, SSE2
TEXT ·Copy(SB), NOSPLIT, $0-56
	MOVQ    dst_base+0(FP), AX
	MOVQ    src_base+24(FP), CX
	MOVQ    dst_len+8(FP), DX
	MOVQ    src_len+32(FP), BX
	CMPQ    BX, DX
	CMOVQLT BX, DX
	MOVQ    DX, ret+48(FP)

tail:
	CMPQ DX, $0x00
	JE   done
	CMPQ DX, $0x01
	JE   handle1
	CMPQ DX, $0x03
	JBE  handle2to3
	CMPQ DX, $0x04
	JE   handle4
	CMPQ DX, $0x08
	JB   handle5to7
	JE   handle8
	CMPQ DX, $0x10
	JBE  handle9to16
	CMPQ DX, $0x20
	JBE  handle17to32
	CMPQ DX, $0x40
	JBE  handle33to64
	BTL  $0x08, github·com∕segmentio∕asm∕cpu·X86+0(SB)
	JCC  generic
	CMPQ DX, $0x80
	JBE  avx2_tail
	JMP  avx2

generic:
	MOVQ (CX), BX
	MOVQ BX, (AX)
	ADDQ $0x08, CX
	ADDQ $0x08, AX
	SUBQ $0x08, DX
	CMPQ DX, $0x08
	JBE  tail
	JMP  generic

done:
	RET

handle1:
	MOVB (CX), CL
	MOVB CL, (AX)
	RET

handle2to3:
	MOVW (CX), BX
	MOVW -2(CX)(DX*1), CX
	MOVW BX, (AX)
	MOVW CX, -2(AX)(DX*1)
	RET

handle4:
	MOVL (CX), CX
	MOVL CX, (AX)
	RET

handle5to7:
	MOVL (CX), BX
	MOVL -4(CX)(DX*1), CX
	MOVL BX, (AX)
	MOVL CX, -4(AX)(DX*1)
	RET

handle8:
	MOVQ (CX), CX
	MOVQ CX, (AX)
	RET

handle9to16:
	MOVQ (CX), BX
	MOVQ -8(CX)(DX*1), CX
	MOVQ BX, (AX)
	MOVQ CX, -8(AX)(DX*1)
	RET

handle17to32:
	MOVOU (CX), X0
	MOVOU -16(CX)(DX*1), X1
	MOVOU X0, (AX)
	MOVOU X1, -16(AX)(DX*1)
	RET

handle33to64:
	MOVOU (CX), X0
	MOVOU 16(CX), X1
	MOVOU -32(CX)(DX*1), X2
	MOVOU -16(CX)(DX*1), X3
	MOVOU X0, (AX)
	MOVOU X1, 16(AX)
	MOVOU X2, -32(AX)(DX*1)
	MOVOU X3, -16(AX)(DX*1)
	RET

	// AVX optimized version for medium to large size inputs.
avx2:
	VMOVDQU (CX), Y0
	VMOVDQU 32(CX), Y1
	VMOVDQU 64(CX), Y2
	VMOVDQU 96(CX), Y3
	VMOVDQU Y0, (AX)
	VMOVDQU Y1, 32(AX)
	VMOVDQU Y2, 64(AX)
	VMOVDQU Y3, 96(AX)
	ADDQ    $0x80, CX
	ADDQ    $0x80, AX
	SUBQ    $0x80, DX
	CMPQ    DX, $0x80
	JAE     avx2
	JZ      avx2_done

avx2_tail:
	CMPQ    DX, $0x40
	JBE     avx2_tail_1to64
	VMOVDQU (CX), Y0
	VMOVDQU 32(CX), Y1
	VMOVDQU 64(CX), Y2
	VMOVDQU -32(CX)(DX*1), Y3
	VMOVDQU Y0, (AX)
	VMOVDQU Y1, 32(AX)
	VMOVDQU Y2, 64(AX)
	VMOVDQU Y3, -32(AX)(DX*1)
	JMP     avx2_done

avx2_tail_1to64:
	VMOVDQU -64(CX)(DX*1), Y0
	VMOVDQU -32(CX)(DX*1), Y1
	VMOVDQU Y0, -64(AX)(DX*1)
	VMOVDQU Y1, -32(AX)(DX*1)

avx2_done:
	VZEROUPPER
	RET
