    bits 64
    
    ; MOV cr/dr encoded with memory simply forces the r/m to register. No memory is interpreted.
    db 0x0F, 0x20, 0xC0                             ; MOV       rax, cr0
    db 0x0F, 0x20, 0x00                             ; MOV       rax, cr0
    db 0x0F, 0x20, 0x40, 0x90                       ; MOV       rax, cr0 followed by NOP
    db 0x0F, 0x20, 0x80, 0x90, 0x90, 0x90, 0x90     ; MOV       rax, cr0 followed by 4 x NOP
    db 0x0F, 0x21, 0xC0                             
    db 0x0F, 0x21, 0x00                             
    db 0x0F, 0x21, 0x40, 0x90                       
    db 0x0F, 0x21, 0x80, 0x90, 0x90, 0x90, 0x90    
    db 0x0F, 0x22, 0xC0                                 
    db 0x0F, 0x22, 0x00                             
    db 0x0F, 0x22, 0x40, 0x90                       
    db 0x0F, 0x22, 0x80, 0x90, 0x90, 0x90, 0x90    
    db 0x0F, 0x23, 0xC0                                 
    db 0x0F, 0x23, 0x00                             
    db 0x0F, 0x23, 0x40, 0x90                       
    db 0x0F, 0x23, 0x80, 0x90, 0x90, 0x90, 0x90     