; start of eeprom on stc15w101
.area BOOTISP (CODE)

boot_isp:

;   set led on permanently to indicate successful isp boot after restart
	clr P3.1

	sjmp boot_isp