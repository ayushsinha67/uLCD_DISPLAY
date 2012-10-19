/*
 * uLCD.c
 *
 * Created: 19-10-2012 PM 7:30:12
 *  Author: Ayush Sinha
 */ 

#define	 F_CPU 16000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "adc.h"
#include "uart.h"
#include "init.h"

/************************************************************************
 *	GLOBAL VARIABLES
 */
volatile uint16_t ticker = 0;

/************************************************************************
 *	MAIN
 */
int main(void)
{
    UART_Init();							/* UART */
	ADC_Init();								/* ADC */
	Timer_Init();							/* TIMER */
	
	sei();									/* Enable Interrupts */
	
	while(1){
		
		uint16_t val = 0;
		uint8_t byte;
		
		/* RPM */
		val = ADC_Read(0);
		UART_TxChar(':');
		byte = (uint8_t) ( val >> 8 );
		UART_TxChar( byte );
		byte = (uint8_t) ( val );
		UART_TxChar( byte );
		
		/* KMPH */
		uint8_t k =  (uint8_t) ADC_Read(1);
		UART_TxChar( k );
		
		//UART_TxChar(ADMUX);
		
		/* GEAR POSITION */
		UART_TxChar( 0 );
		
		/* PNEUMATIC STATUS */
		UART_TxChar(0);
		
		/* OVERHEATING (HOT) WARNING */
		UART_TxChar(255);
		
		/* OIL WARNING */
		UART_TxChar(0);
		_delay_ms(50);
         
    }
}

/************************************************************************
 *	TIMER2 INTERRUPT (1 MS)
 */ 
ISR(TIMER2_COMP_vect)
{
	if( ticker++ == 50 ){
		
		ticker = 0;
		
		
		
		
	}
}
	 

