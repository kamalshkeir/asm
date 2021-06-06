// Code generated by command: go run dedupe_asm.go -pkg sortedset -out ../sortedset/dedupe_amd64.s -stubs ../sortedset/dedupe_amd64.go. DO NOT EDIT.

#include "textflag.h"

// func dedupe1(dst []byte, src []byte) int
// Requires: CMOV
TEXT ·dedupe1(SB), NOSPLIT, $0-56
	MOVQ src_len+32(FP), AX
	CMPQ AX, $0x00
	JE   short
	MOVQ dst_base+0(FP), CX
	MOVQ src_base+24(FP), DX
	MOVQ DX, BX
	MOVQ CX, SI
	ADDQ $0x01, DX
	SUBQ $0x01, AX
	MOVB (BX), DI
	MOVB DI, (SI)
	ADDQ $0x01, SI
	CMPQ AX, $0x00
	JE   done

generic:
	MOVQ    SI, DI
	ADDQ    $0x01, DI
	MOVB    (BX), R8
	MOVB    (DX), R9
	MOVB    R9, (SI)
	CMPB    R8, R9
	CMOVQNE DI, SI
	ADDQ    $0x01, BX
	ADDQ    $0x01, DX
	SUBQ    $0x01, AX
	CMPQ    AX, $0x00
	JG      generic

done:
	SUBQ CX, SI
	MOVQ SI, ret+48(FP)
	RET

short:
	MOVQ AX, ret+48(FP)
	RET

// func dedupe2(dst []byte, src []byte) int
// Requires: CMOV
TEXT ·dedupe2(SB), NOSPLIT, $0-56
	MOVQ src_len+32(FP), AX
	CMPQ AX, $0x00
	JE   short
	MOVQ dst_base+0(FP), CX
	MOVQ src_base+24(FP), DX
	MOVQ DX, BX
	MOVQ CX, SI
	ADDQ $0x02, DX
	SUBQ $0x02, AX
	MOVW (BX), DI
	MOVW DI, (SI)
	ADDQ $0x02, SI
	CMPQ AX, $0x00
	JE   done

generic:
	MOVQ    SI, DI
	ADDQ    $0x02, DI
	MOVW    (BX), R8
	MOVW    (DX), R9
	MOVW    R9, (SI)
	CMPW    R8, R9
	CMOVQNE DI, SI
	ADDQ    $0x02, BX
	ADDQ    $0x02, DX
	SUBQ    $0x02, AX
	CMPQ    AX, $0x00
	JG      generic

done:
	SUBQ CX, SI
	MOVQ SI, ret+48(FP)
	RET

short:
	MOVQ AX, ret+48(FP)
	RET

// func dedupe4(dst []byte, src []byte) int
// Requires: CMOV
TEXT ·dedupe4(SB), NOSPLIT, $0-56
	MOVQ src_len+32(FP), AX
	CMPQ AX, $0x00
	JE   short
	MOVQ dst_base+0(FP), CX
	MOVQ src_base+24(FP), DX
	MOVQ DX, BX
	MOVQ CX, SI
	ADDQ $0x04, DX
	SUBQ $0x04, AX
	MOVL (BX), DI
	MOVL DI, (SI)
	ADDQ $0x04, SI
	CMPQ AX, $0x00
	JE   done

generic:
	MOVQ    SI, DI
	ADDQ    $0x04, DI
	MOVL    (BX), R8
	MOVL    (DX), R9
	MOVL    R9, (SI)
	CMPL    R8, R9
	CMOVQNE DI, SI
	ADDQ    $0x04, BX
	ADDQ    $0x04, DX
	SUBQ    $0x04, AX
	CMPQ    AX, $0x00
	JG      generic

done:
	SUBQ CX, SI
	MOVQ SI, ret+48(FP)
	RET

short:
	MOVQ AX, ret+48(FP)
	RET

// func dedupe8(dst []byte, src []byte) int
// Requires: CMOV
TEXT ·dedupe8(SB), NOSPLIT, $0-56
	MOVQ src_len+32(FP), AX
	CMPQ AX, $0x00
	JE   short
	MOVQ dst_base+0(FP), CX
	MOVQ src_base+24(FP), DX
	MOVQ DX, BX
	MOVQ CX, SI
	ADDQ $0x08, DX
	SUBQ $0x08, AX
	MOVQ (BX), DI
	MOVQ DI, (SI)
	ADDQ $0x08, SI
	CMPQ AX, $0x00
	JE   done

generic:
	MOVQ    SI, DI
	ADDQ    $0x08, DI
	MOVQ    (BX), R8
	MOVQ    (DX), R9
	MOVQ    R9, (SI)
	CMPQ    R8, R9
	CMOVQNE DI, SI
	ADDQ    $0x08, BX
	ADDQ    $0x08, DX
	SUBQ    $0x08, AX
	CMPQ    AX, $0x00
	JG      generic

done:
	SUBQ CX, SI
	MOVQ SI, ret+48(FP)
	RET

short:
	MOVQ AX, ret+48(FP)
	RET

// func dedupe16(dst []byte, src []byte) int
// Requires: AVX, CMOV, SSE2, SSE4.1
TEXT ·dedupe16(SB), NOSPLIT, $8-56
	MOVQ src_len+32(FP), AX
	CMPQ AX, $0x00
	JE   short
	MOVQ dst_base+0(FP), CX
	MOVQ src_base+24(FP), DX
	MOVQ DX, BX
	MOVQ CX, SI
	ADDQ $0x10, DX
	SUBQ $0x10, AX
	CMPQ AX, $0x20
	JL   init
	BTL  $0x08, github·com∕segmentio∕asm∕cpu·X86+0(SB)
	JCS  avx2

init:
	MOVOU (BX), X0
	MOVOU X0, (SI)
	ADDQ  $0x10, SI

tail:
	CMPQ AX, $0x00
	JE   done

generic:
	MOVQ     SI, DI
	ADDQ     $0x10, DI
	MOVOU    (BX), X0
	MOVOU    (DX), X1
	MOVOU    X1, (SI)
	PCMPEQQ  X0, X1
	PMOVMSKB X1, R8
	CMPL     R8, $0x0000ffff
	CMOVQNE  DI, SI
	ADDQ     $0x10, BX
	ADDQ     $0x10, DX
	SUBQ     $0x10, AX
	CMPQ     AX, $0x00
	JG       generic

done:
	SUBQ CX, SI
	MOVQ SI, ret+48(FP)
	RET

short:
	MOVQ AX, ret+48(FP)
	RET

avx2:
	VMOVDQU (BX), X0
	VMOVDQU X0, (SI)
	XORQ    R15, R15
	MOVQ    $0x0000000000000010, BP
	ADDQ    $0x10, SI
	CMPQ    AX, $0x00000080
	JL      avx2_tail64

avx2_loop128:
	VMOVDQU   (BX), X0
	VMOVDQU   16(BX), X2
	VMOVDQU   32(BX), X4
	VMOVDQU   48(BX), X6
	VMOVDQU   64(BX), X8
	VMOVDQU   80(BX), X10
	VMOVDQU   96(BX), X12
	VMOVDQU   112(BX), X14
	VMOVDQU   (DX), X1
	VMOVDQU   16(DX), X3
	VMOVDQU   32(DX), X5
	VMOVDQU   48(DX), X7
	VMOVDQU   64(DX), X9
	VMOVDQU   80(DX), X11
	VMOVDQU   96(DX), X13
	VMOVDQU   112(DX), X15
	VPCMPEQQ  X1, X0, X0
	VMOVMSKPD X0, DI
	CMPQ      DI, $0x03
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VPCMPEQQ  X3, X2, X2
	VMOVMSKPD X2, R8
	CMPQ      R8, $0x03
	CMOVQEQ   R15, R8
	CMOVQNE   BP, R8
	VPCMPEQQ  X5, X4, X4
	VMOVMSKPD X4, R9
	CMPQ      R9, $0x03
	CMOVQEQ   R15, R9
	CMOVQNE   BP, R9
	VPCMPEQQ  X7, X6, X6
	VMOVMSKPD X6, R10
	CMPQ      R10, $0x03
	CMOVQEQ   R15, R10
	CMOVQNE   BP, R10
	VPCMPEQQ  X9, X8, X8
	VMOVMSKPD X8, R11
	CMPQ      R11, $0x03
	CMOVQEQ   R15, R11
	CMOVQNE   BP, R11
	VPCMPEQQ  X11, X10, X10
	VMOVMSKPD X10, R12
	CMPQ      R12, $0x03
	CMOVQEQ   R15, R12
	CMOVQNE   BP, R12
	VPCMPEQQ  X13, X12, X12
	VMOVMSKPD X12, R13
	CMPQ      R13, $0x03
	CMOVQEQ   R15, R13
	CMOVQNE   BP, R13
	VPCMPEQQ  X15, X14, X14
	VMOVMSKPD X14, R14
	CMPQ      R14, $0x03
	CMOVQEQ   R15, R14
	CMOVQNE   BP, R14
	ADDQ      DI, R8
	ADDQ      R8, R9
	ADDQ      R9, R10
	ADDQ      R10, R11
	ADDQ      R11, R12
	ADDQ      R12, R13
	ADDQ      R13, R14
	VMOVDQU   X1, (SI)
	VMOVDQU   X3, (SI)(DI*1)
	VMOVDQU   X5, (SI)(R8*1)
	VMOVDQU   X7, (SI)(R9*1)
	VMOVDQU   X9, (SI)(R10*1)
	VMOVDQU   X11, (SI)(R11*1)
	VMOVDQU   X13, (SI)(R12*1)
	VMOVDQU   X15, (SI)(R13*1)
	ADDQ      R14, SI
	ADDQ      $0x00000080, BX
	ADDQ      $0x00000080, DX
	SUBQ      $0x00000080, AX
	CMPQ      AX, $0x00000080
	JGE       avx2_loop128

avx2_tail64:
	CMPQ      AX, $0x40
	JL        avx2_tail32
	VMOVDQU   (BX), X0
	VMOVDQU   16(BX), X2
	VMOVDQU   32(BX), X4
	VMOVDQU   48(BX), X6
	VMOVDQU   (DX), X1
	VMOVDQU   16(DX), X3
	VMOVDQU   32(DX), X5
	VMOVDQU   48(DX), X7
	VPCMPEQQ  X1, X0, X0
	VMOVMSKPD X0, DI
	CMPQ      DI, $0x03
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VPCMPEQQ  X3, X2, X2
	VMOVMSKPD X2, R8
	CMPQ      R8, $0x03
	CMOVQEQ   R15, R8
	CMOVQNE   BP, R8
	VPCMPEQQ  X5, X4, X4
	VMOVMSKPD X4, R9
	CMPQ      R9, $0x03
	CMOVQEQ   R15, R9
	CMOVQNE   BP, R9
	VPCMPEQQ  X7, X6, X6
	VMOVMSKPD X6, R10
	CMPQ      R10, $0x03
	CMOVQEQ   R15, R10
	CMOVQNE   BP, R10
	ADDQ      DI, R8
	ADDQ      R8, R9
	ADDQ      R9, R10
	VMOVDQU   X1, (SI)
	VMOVDQU   X3, (SI)(DI*1)
	VMOVDQU   X5, (SI)(R8*1)
	VMOVDQU   X7, (SI)(R9*1)
	ADDQ      R10, SI
	ADDQ      $0x40, BX
	ADDQ      $0x40, DX
	SUBQ      $0x40, AX

avx2_tail32:
	CMPQ      AX, $0x20
	JL        avx2_tail16
	VMOVDQU   (BX), X0
	VMOVDQU   16(BX), X2
	VMOVDQU   (DX), X1
	VMOVDQU   16(DX), X3
	VPCMPEQQ  X1, X0, X0
	VMOVMSKPD X0, DI
	CMPQ      DI, $0x03
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VPCMPEQQ  X3, X2, X2
	VMOVMSKPD X2, R8
	CMPQ      R8, $0x03
	CMOVQEQ   R15, R8
	CMOVQNE   BP, R8
	ADDQ      DI, R8
	VMOVDQU   X1, (SI)
	VMOVDQU   X3, (SI)(DI*1)
	ADDQ      R8, SI
	ADDQ      $0x20, BX
	ADDQ      $0x20, DX
	SUBQ      $0x20, AX

avx2_tail16:
	CMPQ      AX, $0x10
	JL        avx2_tail
	VMOVDQU   (BX), X0
	VMOVDQU   (DX), X1
	VPCMPEQQ  X1, X0, X0
	VMOVMSKPD X0, DI
	CMPQ      DI, $0x03
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VMOVDQU   X1, (SI)
	ADDQ      DI, SI
	ADDQ      $0x10, BX
	ADDQ      $0x10, DX
	SUBQ      $0x10, AX

avx2_tail:
	VZEROUPPER
	JMP tail

// func dedupe32(dst []byte, src []byte) int
// Requires: AVX, AVX2, CMOV, SSE2, SSE4.1
TEXT ·dedupe32(SB), NOSPLIT, $8-56
	MOVQ src_len+32(FP), AX
	CMPQ AX, $0x00
	JE   short
	MOVQ dst_base+0(FP), CX
	MOVQ src_base+24(FP), DX
	MOVQ DX, BX
	MOVQ CX, SI
	ADDQ $0x20, DX
	SUBQ $0x20, AX
	CMPQ AX, $0x20
	JL   init
	BTL  $0x08, github·com∕segmentio∕asm∕cpu·X86+0(SB)
	JCS  avx2

init:
	MOVOU (BX), X0
	MOVOU 16(BX), X1
	MOVOU X0, (SI)
	MOVOU X1, 16(SI)
	ADDQ  $0x20, SI

tail:
	CMPQ AX, $0x00
	JE   done

generic:
	MOVQ     SI, DI
	ADDQ     $0x20, DI
	MOVOU    (DX), X2
	MOVOU    16(DX), X3
	MOVOU    (BX), X0
	MOVOU    16(BX), X1
	MOVOU    X2, (SI)
	MOVOU    X3, 16(SI)
	PCMPEQQ  X0, X2
	PCMPEQQ  X1, X3
	PMOVMSKB X2, R8
	PMOVMSKB X3, R9
	ANDL     R9, R8
	CMPL     R8, $0x0000ffff
	CMOVQNE  DI, SI
	ADDQ     $0x20, BX
	ADDQ     $0x20, DX
	SUBQ     $0x20, AX
	CMPQ     AX, $0x00
	JG       generic

done:
	SUBQ CX, SI
	MOVQ SI, ret+48(FP)
	RET

short:
	MOVQ AX, ret+48(FP)
	RET

avx2:
	VMOVDQU (BX), Y0
	VMOVDQU Y0, (SI)
	XORQ    R15, R15
	MOVQ    $0x0000000000000020, BP
	ADDQ    $0x20, SI
	CMPQ    AX, $0x00000100
	JL      avx2_tail128

avx2_loop256:
	VMOVDQU   (BX), Y0
	VMOVDQU   32(BX), Y2
	VMOVDQU   64(BX), Y4
	VMOVDQU   96(BX), Y6
	VMOVDQU   128(BX), Y8
	VMOVDQU   160(BX), Y10
	VMOVDQU   192(BX), Y12
	VMOVDQU   224(BX), Y14
	VMOVDQU   (DX), Y1
	VMOVDQU   32(DX), Y3
	VMOVDQU   64(DX), Y5
	VMOVDQU   96(DX), Y7
	VMOVDQU   128(DX), Y9
	VMOVDQU   160(DX), Y11
	VMOVDQU   192(DX), Y13
	VMOVDQU   224(DX), Y15
	VPCMPEQQ  Y1, Y0, Y0
	VMOVMSKPD Y0, DI
	CMPQ      DI, $0x0f
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VPCMPEQQ  Y3, Y2, Y2
	VMOVMSKPD Y2, R8
	CMPQ      R8, $0x0f
	CMOVQEQ   R15, R8
	CMOVQNE   BP, R8
	VPCMPEQQ  Y5, Y4, Y4
	VMOVMSKPD Y4, R9
	CMPQ      R9, $0x0f
	CMOVQEQ   R15, R9
	CMOVQNE   BP, R9
	VPCMPEQQ  Y7, Y6, Y6
	VMOVMSKPD Y6, R10
	CMPQ      R10, $0x0f
	CMOVQEQ   R15, R10
	CMOVQNE   BP, R10
	VPCMPEQQ  Y9, Y8, Y8
	VMOVMSKPD Y8, R11
	CMPQ      R11, $0x0f
	CMOVQEQ   R15, R11
	CMOVQNE   BP, R11
	VPCMPEQQ  Y11, Y10, Y10
	VMOVMSKPD Y10, R12
	CMPQ      R12, $0x0f
	CMOVQEQ   R15, R12
	CMOVQNE   BP, R12
	VPCMPEQQ  Y13, Y12, Y12
	VMOVMSKPD Y12, R13
	CMPQ      R13, $0x0f
	CMOVQEQ   R15, R13
	CMOVQNE   BP, R13
	VPCMPEQQ  Y15, Y14, Y14
	VMOVMSKPD Y14, R14
	CMPQ      R14, $0x0f
	CMOVQEQ   R15, R14
	CMOVQNE   BP, R14
	ADDQ      DI, R8
	ADDQ      R8, R9
	ADDQ      R9, R10
	ADDQ      R10, R11
	ADDQ      R11, R12
	ADDQ      R12, R13
	ADDQ      R13, R14
	VMOVDQU   Y1, (SI)
	VMOVDQU   Y3, (SI)(DI*1)
	VMOVDQU   Y5, (SI)(R8*1)
	VMOVDQU   Y7, (SI)(R9*1)
	VMOVDQU   Y9, (SI)(R10*1)
	VMOVDQU   Y11, (SI)(R11*1)
	VMOVDQU   Y13, (SI)(R12*1)
	VMOVDQU   Y15, (SI)(R13*1)
	ADDQ      R14, SI
	ADDQ      $0x00000100, BX
	ADDQ      $0x00000100, DX
	SUBQ      $0x00000100, AX
	CMPQ      AX, $0x00000100
	JGE       avx2_loop256

avx2_tail128:
	CMPQ      AX, $0x80
	JL        avx2_tail64
	VMOVDQU   (BX), Y0
	VMOVDQU   32(BX), Y2
	VMOVDQU   64(BX), Y4
	VMOVDQU   96(BX), Y6
	VMOVDQU   (DX), Y1
	VMOVDQU   32(DX), Y3
	VMOVDQU   64(DX), Y5
	VMOVDQU   96(DX), Y7
	VPCMPEQQ  Y1, Y0, Y0
	VMOVMSKPD Y0, DI
	CMPQ      DI, $0x0f
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VPCMPEQQ  Y3, Y2, Y2
	VMOVMSKPD Y2, R8
	CMPQ      R8, $0x0f
	CMOVQEQ   R15, R8
	CMOVQNE   BP, R8
	VPCMPEQQ  Y5, Y4, Y4
	VMOVMSKPD Y4, R9
	CMPQ      R9, $0x0f
	CMOVQEQ   R15, R9
	CMOVQNE   BP, R9
	VPCMPEQQ  Y7, Y6, Y6
	VMOVMSKPD Y6, R10
	CMPQ      R10, $0x0f
	CMOVQEQ   R15, R10
	CMOVQNE   BP, R10
	ADDQ      DI, R8
	ADDQ      R8, R9
	ADDQ      R9, R10
	VMOVDQU   Y1, (SI)
	VMOVDQU   Y3, (SI)(DI*1)
	VMOVDQU   Y5, (SI)(R8*1)
	VMOVDQU   Y7, (SI)(R9*1)
	ADDQ      R10, SI
	ADDQ      $0x80, BX
	ADDQ      $0x80, DX
	SUBQ      $0x80, AX

avx2_tail64:
	CMPQ      AX, $0x40
	JL        avx2_tail32
	VMOVDQU   (BX), Y0
	VMOVDQU   32(BX), Y2
	VMOVDQU   (DX), Y1
	VMOVDQU   32(DX), Y3
	VPCMPEQQ  Y1, Y0, Y0
	VMOVMSKPD Y0, DI
	CMPQ      DI, $0x0f
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VPCMPEQQ  Y3, Y2, Y2
	VMOVMSKPD Y2, R8
	CMPQ      R8, $0x0f
	CMOVQEQ   R15, R8
	CMOVQNE   BP, R8
	ADDQ      DI, R8
	VMOVDQU   Y1, (SI)
	VMOVDQU   Y3, (SI)(DI*1)
	ADDQ      R8, SI
	ADDQ      $0x40, BX
	ADDQ      $0x40, DX
	SUBQ      $0x40, AX

avx2_tail32:
	CMPQ      AX, $0x20
	JL        avx2_tail
	VMOVDQU   (BX), Y0
	VMOVDQU   (DX), Y1
	VPCMPEQQ  Y1, Y0, Y0
	VMOVMSKPD Y0, DI
	CMPQ      DI, $0x0f
	CMOVQEQ   R15, DI
	CMOVQNE   BP, DI
	VMOVDQU   Y1, (SI)
	ADDQ      DI, SI
	ADDQ      $0x20, BX
	ADDQ      $0x20, DX
	SUBQ      $0x20, AX

avx2_tail:
	VZEROUPPER
	JMP tail
