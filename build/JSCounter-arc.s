
build/JSCounter-arc.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <JSCounter_eval>:
   0:	8a 0f                	mov    (%rdi),%cl
   2:	8a 47 03             	mov    0x3(%rdi),%al
   5:	88 4f 03             	mov    %cl,0x3(%rdi)
   8:	80 f9 01             	cmp    $0x1,%cl
   b:	75 28                	jne    35 <JSCounter_eval+0x35>
   d:	a8 01                	test   $0x1,%al
   f:	75 24                	jne    35 <JSCounter_eval+0x35>
  11:	8a 47 02             	mov    0x2(%rdi),%al
  14:	89 c1                	mov    %eax,%ecx
  16:	f6 d1                	not    %cl
  18:	c0 e0 04             	shl    $0x4,%al
  1b:	c0 e8 05             	shr    $0x5,%al
  1e:	c0 e1 03             	shl    $0x3,%cl
  21:	08 c1                	or     %al,%cl
  23:	0f b6 c1             	movzbl %cl,%eax
  26:	31 c9                	xor    %ecx,%ecx
  28:	80 7f 01 00          	cmpb   $0x0,0x1(%rdi)
  2c:	0f 45 c8             	cmovne %eax,%ecx
  2f:	80 e1 0f             	and    $0xf,%cl
  32:	88 4f 02             	mov    %cl,0x2(%rdi)
  35:	8a 47 02             	mov    0x2(%rdi),%al
  38:	88 47 04             	mov    %al,0x4(%rdi)
  3b:	c3                   	ret    
