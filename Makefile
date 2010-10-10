############################################################

# initial buffer size for the tasks and results
BUFSIZE?=		4096

############################################################
BIRTHDATE=	2008-01-25

WARNS?=		4

PROG=		paexec
SRCS=		paexec.c wrappers.c tasks.c

SCRIPTS=	paexec_reorder

MAN=		paexec.1 paexec_reorder.1

CFLAGS+=	-DPAEXEC_VERSION='"${VERSION}"'
CFLAGS+=	-DBUFSIZE=${BUFSIZE}

MKC_REQUIRE_HEADERS=	maa.h
MKC_REQUIRE_FUNCLIBS=	maa_init:maa

MKC_COMMON_DEFINES=	-D_GNU_SOURCE
MKC_COMMON_HEADERS=	unistd.h
MKC_CHECK_FUNCS5=	getopt_long:getopt.h getopt_long

############################################################

CLEANFILES=  *~ core* *.1 *.html ktrace* ChangeLog *.tmp
CLEANFILES+= transport_closed_stdin _test.in

${.OBJDIR}/transport_closed_stdin: examples/broken_echo/transport_closed_stdin.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $(.TARGET) $(.ALLSRC) $(LDFLAGS)

.PHONY : test
test : paexec ${.OBJDIR}/transport_closed_stdin; \
	@echo 'running tests...'; \
	export OBJDIR=${.OBJDIR}; \
	if cd ${.CURDIR}/tests && ./test.sh; \
	then echo 'SUCCEEDED'; \
	else echo 'FAILED'; false; \
	fi

############################################################

.include "version.mk"
.include <mkc.prog.mk>
