# AVR Vars
MCU = atmega328p
MCU_AVRDUDE = m328p
BAUD = 9600
PORT?=/dev/ttyACM0
PROGRAMMER?=avrisp

# Compiler flags
RM = rm -f
CC = avr-gcc
CFLAGS = -Os -mmcu=$(MCU)

# Target
TARGET = blink
SRC:=$(TARGET).c 
OBJ:=$(SRC:.c=.o) 

all: $(TARGET).elf

%.elf: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: all clean setfuses upload 
