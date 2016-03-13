################################################################################

1. How to Build
	- get Toolchain
		From android git server , codesourcery and etc ..
		 - arm-eabi-4.9

	- edit fmp_hmac_skc.bin, fmp_hmac_ktc.bin, fmp_hmac_luc.bin to proper operator at root directory.
		EX) for SKC model : rename "fmp_hmac_skc.bin" to "fmp_hmac.bin"
		EX) for KTC model : rename "fmp_hmac_ktc.bin" to "fmp_hmac.bin"
		EX) for LUC model : rename "fmp_hmac_luc.bin" to "fmp_hmac.bin"
		
	- edit Makefile
		edit "CROSS_COMPILE" to right toolchain path(You downloaded).
		  EX)  CROSS_COMPILE= $(android platform directory you download)/android/prebuilts/gcc/linux-x86/arm/arm-eabi-4.9/bin/arm-eabi-
		  Ex)  CROSS_COMPILE=/usr/local/toolchain/arm-eabi-4.9/bin/arm-eabi-		// check the location of toolchain
  	
        - to Build (you can choice skc, ktc, luc defconfig )
          $ make ARCH=arm64 exynos7420-noblelte_kor_skc_defconfig
          $ make ARCH=arm64

2. Output files
	- Kernel : arch/arm/boot/zImage
	- module : drivers/*/*.ko

3. How to Clean	
		$ make clean
################################################################################
