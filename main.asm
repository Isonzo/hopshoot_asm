format ELF64

section '.text' executable

public _start
extrn InitWindow
extrn SetTargetFPS
extrn WindowShouldClose
extrn BeginDrawing
extrn EndDrawing
extrn ClearBackground
extrn DrawText
extrn CloseWindow
extrn _exit

RAYWHITE = 0xFFF5F5F5
LIGHTGRAY = 0xFFC8C8C8
BLACK = 0xFF000000
BLUE = 0xFFFF0000

screenWidth = 800
screenHeight = 450
targetFPS = 60

_start:
    ; Initialize window
    mov rdi, screenWidth
    mov rsi, screenHeight
    mov rdx, title
    call InitWindow
    ; Set Target FPS
    mov rdi, targetFPS
    call SetTargetFPS

    main_loop:
    ; Check if we need to exit
    call WindowShouldClose
    cmp rax, 1
    je exit
    ; Begin rendering cycle
    call BeginDrawing

    ; Draw base background
    mov rdi, BLACK
    call ClearBackground

    ; Message drawing
    mov rdi, message
    mov rsi, 190    ; x
    mov rdx, 200    ; y
    mov rcx, 20     ; font size
    mov qword r8, LIGHTGRAY
    call DrawText

    ; End rendering cycle
    call EndDrawing

    jmp main_loop

exit:
    ; Exit gracefully
    call CloseWindow
    mov rax, 60
    mov rdi, 0
    syscall

section '.data' writeable
title db "Raylib, now in assembly!", 0
message db "A window from assembly, on the shoulders of libC", 0 
