SRC = src/ae.c src/anet.c
OBJ = ${SRC:.c=.o}
CFLAGS = -std=gnu99 -g -O0 -Wno-parentheses -Wno-switch-enum -Wno-unused-value

RANLIB ?= ranlib

ifneq ($(WINDOWS_BUILD),)
	LIBS = -lws2_32
endif

libae.a: libae.a.tmp
	$(RANLIB) $^
	mv $^ $@

libae.a.tmp: $(OBJ)
	$(AR) -rvc $@ $(OBJ)

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

timer: example/timer.o libae.a
	$(CC) $^ -o $@ $(LIBS)

echo: example/echo.o libae.a
	$(CC) $^ -o $@ $(LIBS)

clean:
	rm -f $(OBJ) libae.a example/timer.o timer example/echo.o echo

.PHONY: clean
