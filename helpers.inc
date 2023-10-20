%macro pcall 2
    push %2
    call %1
    add esp, 4
%endmacro
%macro pcall 3
    push %3
    push %2
    call %1
    add esp, 8
%endmacro
%macro pcall 4
    push %4
    push %3
    push %2
    call %1
    add esp, 12
%endmacro
%macro pcall 5
    push %5
    push %4
    push %3
    push %2
    call %1
    add esp, 16
%endmacro

%define arg1 ebp+8
%define arg2 ebp+12
%define arg3 ebp+16
%define arg4 ebp+20
%define arg5 ebp+24
%define arg6 ebp+28
%define local1 ebp-4
%define local2 ebp-8
%define local3 ebp-12
%define local4 ebp-16
%define local5 ebp-20
%define local6 ebp-24

%define arg(n) ebp+(4*n)+4
%define local(n) ebp-(4*n)