#
# Copyright (c) 2012 Hans Petter Selasky. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
#
# Makefile for virtual_oss
#

.PATH: .

VERSION=1.0.3
PROG=virtual_oss
MAN=
PACKAGE=${PROG}-${VERSION}
PTHREAD_LIBS?= -lpthread
PREFIX?=        /usr/local
LOCALBASE?=     /usr/local
BINDIR=         ${PREFIX}/sbin
MANDIR=         ${PREFIX}/man/man
LIBDIR=         ${PREFIX}/lib

SRCS= \
virtual_audio_delay.c \
virtual_ctl.c \
virtual_format.c \
virtual_main.c \
virtual_oss.c

CFLAGS += -I${LOCALBASE}/include
LDFLAGS += -L${LIBDIR} -lcuse4bsd ${PTHREAD_LIBS} -lm

.include <bsd.prog.mk>

help:
	@echo "Targets are: all, install, clean, package, help"

package: clean
	tar -cvf ${PACKAGE}.tar Makefile virtual*.[ch]
	rm -rf ${PACKAGE}
	mkdir ${PACKAGE}
	tar -xvf ${PACKAGE}.tar -C ${PACKAGE}
	rm -rf ${PACKAGE}.tar
	tar -jcvf ${PACKAGE}.tar.bz2 ${PACKAGE}

