CC=gcc
CFLAGS=-I./include
LDFLAGS=-L./lib -Wl,-rpath=./lib -ltensorflow

all: main

main: main.o
	$(CC) -o $@ $^ $(LDFLAGS)

main.o: main.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f main main.o

