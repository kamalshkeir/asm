// Code generated by command: go run encode_asm.go -pkg base64 -out ../base64/encode_amd64.s -stubs ../base64/encode_amd64.go. DO NOT EDIT.

//go:build !purego
// +build !purego

package base64

func encodeAVX2(dst []byte, src []byte, lut [16]int8) (int, int)
