// Code generated by command: go run swap64_asm.go -pkg bswap -out ../bswap/swap64_amd64.s -stubs ../bswap/swap64_amd64.go. DO NOT EDIT.

//go:build !purego
// +build !purego

package bswap

// swap64 performs an in-place byte swap on each qword of the input buffer.
func swap64(b []byte)
