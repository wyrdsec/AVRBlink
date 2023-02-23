#define F_CPU 16000000UL        // Speed of the microprocessor, in hertz (16 MHz)
#include <avr/io.h>             // provides PORT* and DDR* registers
#include <util/delay.h>         // provides _delay_ms(), and needs F_CPU

int main()
{
    // set the DataDirectionRegister of PB0 as input
    DDRB |= _BV(DDB0);

    while(1)
    {
        // set PB0 on
        PORTB |= _BV(PB0);

        // caveat: the precision falls down after 260 ms
        // see the avr-libc documentation
        _delay_ms(250);

        // set PB0 off
        PORTB &= ~_BV(PB0);

        _delay_ms(250);
    }

    return 0;
}
