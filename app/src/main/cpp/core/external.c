/*
 *   external.c
 *
 *   This file is part of Emu48
 *
 *   Copyright (C) 1995 Sebastien Carlier
 *
 */
#include "pch.h"
#include "emu48.h"
#include "ops.h"

#define SAMPLES_PER_SEC		44100			// sound sampling rate

//| 38G  | 39G  | 40G  | 48SX | 48GX | 49G  | Name
//#F0E4F #80F0F #80F0F #706D2 #80850 #80F0F =SFLAG53_56

// memory address for flags -53 to -56
 // CdB for HP: add apples beep management
#define SFLAG53_56	(  (cCurrentRomType=='6')								\
					 ? 0xE0E4F												\
					 : (  (cCurrentRomType=='A')							\
						? 0xF0E4F											\
						: (  (cCurrentRomType!='E' && cCurrentRomType!='X' && cCurrentRomType!='P' && cCurrentRomType!='2' && cCurrentRomType!='Q')	\
						   ? (  (cCurrentRomType=='S')						\
							  ? 0x706D2										\
							  : 0x80850										\
							 )												\
						   : 0x80F0F										\
						  )													\
					   )													\
					)

VOID External(CHIPSET* w)					// Beep patch
{
	BYTE  fbeep;
	DWORD freq,dur;

	freq = Npack(w->D,5);					// frequency in Hz
	dur = Npack(w->C,5);					// duration in ms
	Nread(&fbeep,SFLAG53_56,1);				// fetch system flags -53 to -56

	w->carry = TRUE;						// setting of no beep
	if (!(fbeep & 0x8) && freq)				// bit -56 clear and frequency > 0 Hz
	{
		if (freq > 4400) freq = 4400;		// high limit of HP (SX)

		SoundBeep(freq,dur);				// beeping

		// estimate cpu cycles for beeping time (2MHz / 4MHz)
		w->cycles += dur * ((cCurrentRomType=='S') ? 2000 : 4000);

		// original routine return with...
		w->P = 0;							// P=0
		w->intk = TRUE;						// INTON
		w->carry = FALSE;					// RTNCC
	}
	w->pc = rstkpop();
	return;
}

VOID RCKBp(CHIPSET* w)						// ROM Check Beep patch
{
	DWORD dw2F,dwCpuFreq;
	DWORD freq,dur;
	BYTE f,d;

	f = w->C[1];							// f = freq ctl
	d = w->C[0];							// d = duration ctl
	
	if (cCurrentRomType == 'S')				// Clarke chip with 48S ROM
	{	
		// CPU strobe frequency @ RATE 14 = 1.97MHz
		dwCpuFreq = ((14 + 1) * 524288) >> 2;

		dw2F = f * 126 + 262;				// F=f*63+131
	}
	else									// York chip with 48G and later ROM
	{
		// CPU strobe frequency @ RATE 27 = 3.67MHz
		// CPU strobe frequency @ RATE 29 = 3.93MHz
		dwCpuFreq = ((27 + 1) * 524288) >> 2;

		dw2F = f * 180 + 367;				// F=f*90+183.5
	}

	freq = dwCpuFreq / dw2F;
	dur = (dw2F * (256 - 16 * d)) * 1000 / 2 / dwCpuFreq;

	if (freq > 4400) freq = 4400;			// high limit of HP

	SoundBeep(freq,dur);					// beeping

	// estimate cpu cycles for beeping time (2MHz / 4MHz)
	w->cycles += dur * ((cCurrentRomType=='S') ? 2000 : 4000);           

	w->P = 0;								// P=0
	w->carry = FALSE;						// RTNCC
	w->pc = rstkpop();
	return;
}
