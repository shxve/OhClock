CC ?= gcc
CFLAGS ?= -O2 -pipe -Wall -Wextra -Wshadow
LDLIBS ?= -pthread

TARGET := exploit

.PHONY: all run clean

all: $(TARGET)

$(TARGET): exploit.c
	$(CC) $(CFLAGS) -static -o $@ exploit.c $(LDLIBS)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)
