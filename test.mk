CLEANFILES +=		_test.in

# the following section will be fixed/improved in the next version of mk-c
.if defined(MAKEOBJDIR)
OBJDIR_paexec ?=	${MAKEOBJDIR}
OBJDIR_broken_echo ?=	${MAKEOBJDIR}
.else
OBJDIR_paexec ?=	${.CURDIR}
OBJDIR_broken_echo ?=	${.CURDIR}/examples/broken_echo
.endif

#
.PHONY : test
test : all-paexec all-examples
	@echo 'running tests...'; \
	export OBJDIR=${.OBJDIR}; \
	export PATH=${OBJDIR_broken_echo}:${OBJDIR_paexec}:$$PATH; \
	if cd ${.CURDIR}/tests && ./test.sh; \
	then echo 'SUCCEEDED'; \
	else echo 'FAILED'; false; \
	fi
