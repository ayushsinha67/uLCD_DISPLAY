#include <avr/io.h>
#include <avr/interrupt.h>
#include "init.h"

/************************************************************************
 *	INITIALIZE GPIO
 */
void GPIO_Init ( void )
{	
	/* Define ADC Input Pins */
	DDRA = 0x00;						
							
}

/************************************************************************
 *	INITIALIZE TIMER
 *  
 *  TIMER2 - CTC MODE, F_CPU: 16Mhz, PS: 64, Frequency: 1 KHz, Period: 1 ms 
 */
void Timer_Init(void)
{
    TCCR2 |= ( 1<<WGM21 ) | ( 1<<CS22 );				/* CTC, PS: 64 */
    TIMSK |= ( 1<<OCIE2 );								/* Enable Interrupt */
    OCR2 = 249;
}

/************************************************************************
 *	EXTERNAL INTERRUPT INTITIALIZATION
 */
void INT_Init (void)
{	
	/* INT0 and INT1 */
	GICR = ( ( 1<<INT0 ) | ( 1<<INT1 ) );					
	
	/* INT0 and INT1 on rising edge */
	MCUCR = ( ( 1<<ISC01 ) | ( 1<<ISC00 ) | ( 1<<ISC10 ) | ( 1<<ISC11) );
}
