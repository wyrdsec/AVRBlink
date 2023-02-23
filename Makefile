# AVR Vars
MCU = atmega328p
MCU_AVRDUDE = m328p
BAUD = 19200
BIN_FORMAT=ihex
PORT?=/dev/ttyACM0
PROGRAMMER?=avrisp

# Compiler flags
RM = rm -f
CC = avr-gcc
CFLAGS = -Os -mmcu=$(MCU)
OBJCOPY = avr-objcopy
AVRDUDE = avrdude

# Target
TARGET = blink
SRC:=$(TARGET).c 
OBJ:=$(SRC:.c=.o) 

all: $(TARGET).hex

%.elf: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.hex: %.elf
	$(OBJCOPY) -O $(BIN_FORMAT) -R .eeprom $< $@

upload: $(TARGET).hex
	$(AVRDUDE) -v -p $(MCU_AVRDUDE) -P $(PORT) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(TARGET).hex

fuses:
	$(AVRDUDE) -v -p $(MCU_AVRDUDE) -P $(PORT) -c $(PROGRAMMER) -b $(BAUD) -U lfuse:w:0xe6:m

clean:
	$(RM) $(TARGET).elf $(TARGET).hex $(OBJ)

.PHONY: all clean setfuses upload 
