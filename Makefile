.ONESHELL:
SHELL           =/bin/bash
MAKEFLAGS       += $(if $(VERBOSE),,--no-print-directory)
MINMAKEVERSION  =3.82

WEBSERVERPORT	=8083
DCNAME			=sphinx_mindmap
$(if $(findstring $(MINMAKEVERSION),$(firstword $(sort $(MINMAKEVERSION) $(MAKE_VERSION)))),,$(error The Makefile requires minimal GNU make version:$(MINMAKEVERSION) and you are using:$(MAKE_VERSION)))

.PHONY:doc

UNAME := $(shell uname 2>/dev/null || echo Windows)
TOOLS ?= tools.mak

ifeq ($(UNAME),Linux)
SED=sed
endif
ifeq ($(UNAME),Darwin)
SED=gsed
endif

$(MAKE_VERBOSE).SILENT:
	echo NothingAtAll

webserver:
	docker ps | awk '$$NF=="$(DCNAME)"{print "docker stop "$$1}' | bash
	sleep 1
	docker run -it --rm -d -p $(WEBSERVERPORT):80 \
		--name $(DCNAME) \
		-v $$PWD/doc/build/html:/usr/share/nginx/html nginx

show:
	open http://localhost:$(WEBSERVERPORT)

install:
	cd sphinx_mindmap
	pip uninstall -y sphinx_mindmap
	poetry build
	pip install dist/sphinx_mindmap-0.5.0-py3-none-any.whl

ec:
	git commit --allow-empty -m "Empty commit" && git push

show-package:
	tar -tvf dist/sphinx_mindmap-0.5.0.tar.gz

extract-package:
	cd /tmp
	tar -xvf $(CURDIR)/dist/sphinx_mindmap-0.5.0.tar.gz
	ls -l

test-package:
	$(eval WDIR=/tmp/test)
	mkdir -p $(WDIR)
	rm -rf $(WDIR)/*
	cd $(WDIR)
	git clone -b Init --single-branch \
		https://github.com/mi-parkes/sphinx_mindmap.git
	cd sphinx_mindmap
	cp $(CURDIR)/sphinx_mindmap/pyproject.toml .
	python3 -m venv .venv
	source .venv/bin/activate
	python -m pip install --upgrade pip
	pip install poetry
	poetry install
	poetry build
	poetry run task doc
