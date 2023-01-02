; to flash
; ~/stcgal-patched/stcgal.py -p COM3 -b 19200 isp_blink.hex

; linker help from https://hackaday.io/project/167952/logs
; attempts to execute code from eeprom space on stc15

;.module blink

.area RSEG (ABS,DATA)
.org 0x0000
IAP_CONTR	=	0x00C7

.area INTV (ABS)
.org 0x0000

_int_reset:
	ljmp main

.area CSEG (ABS, CODE)
.org 0x0090

main:

; number of times to blink
    mov r0, #0x0A
led_cycles:

;   led on
	clr P3.1

    mov r1, #0x02
led_on_delay:
    acall delay
    djnz r1, led_on_delay
    
;   led off
    setb P3.1

    mov r1, #0x02
led_off_delay:
    acall delay
    djnz r1, led_off_delay
    
; outer loop
    djnz r0, led_cycles
    
    
;   set ISP boot bit and reset processor
;   reset will cause a blink too so be aware
    mov IAP_CONTR, #0x60
    
    sjmp main

delay:
	mov r2, #0x00	
	mov r3, #0x00	
wait:
	djnz r2, wait
	djnz r3, wait
	ret