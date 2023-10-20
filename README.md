## COMPILE
```
nasm -f elf -g <filename>.asm
```

## LINK
```
ld -m elf_i386  <filename>.o -o <filename>
```

or use make (it's kinda works. Maybe some issues)
