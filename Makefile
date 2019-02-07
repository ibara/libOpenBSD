# libOpenBSD Makefile

CC ?=		cc
CFLAGS ?=	-O2 -pipe
CFLAGS +=	-std=c99

OBJS =	strlcat.o strlcpy.o strtonum.o

all: ${OBJS}
	${AR} cru libopenbsd.a ${OBJS}
	ranlib libopenbsd.a

install:
	install -c -m 444 openbsd.h /usr/include
	install -c -s -m 444 libopenbsd.a /usr/lib

uninstall:
	rm -f /usr/include/openbsd.h
	rm -f /usr/lib/libopenbsd.a

clean:
	rm -f libopenbsd.a ${OBJS}
