# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

conf:
	make clean && make confluence && make html

LIVETARGET=html
PORT?=1234

live:
	sphinx-autobuild --host 0.0.0.0 --port ${PORT} -b ${LIVETARGET} $(SPHINXOPTS) $(0) \
		$(SOURCEDIR) \
		$(BUILDDIR)/${LIVETARGET}
	exit(0)

FUNCSOURCE="functionality-and-specifications"
FUNCDEST="build/functionality-and-specifications"

funcspecs-live:
	sphinx-autobuild --host 0.0.0.0 --port ${PORT} \
		-b ${LIVETARGET} \
		${FUNCSOURCE} \
		${FUNCDEST}/${LIVETARGET} \
		${SPHINXOPTS} ${0}
	exit(0)

funcspecs-conf:
		@$(SPHINXBUILD) -b confluence "${FUNCSOURCE}" "${FUNCDEST}/confluence" -E -a $(SPHINXOPTS) $(O)

funcspecs:
		@$(SPHINXBUILD) -b html "${FUNCSOURCE}" "${FUNCDEST}/html" $(SPHINXOPTS) $(O)

all:
	make clean
	make confluence
	make html
	make funcspecs

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
