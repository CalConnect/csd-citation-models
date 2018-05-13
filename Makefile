SRC  := $(wildcard iso-*.adoc)
DOC  := $(patsubst %.adoc,%.doc,$(SRC))
XML  := $(patsubst %.adoc,%.xml,$(SRC))
HTML := $(patsubst %.adoc,%.html,$(SRC))

SHELL := /bin/bash

all: $(HTML) $(XML) $(DOC)

clean:
	rm -f $(HTML) $(DOC) $(XML) Gemfile Gemfile.lock

bundle:	Gemfile Gemfile.lock
	bundle

Gemfile Gemfile.lock:
	cp ../common-iso/$@ .

%.xml %.html %.doc:	%.adoc | bundle
	sh make.sh
	bundle exec asciidoctor -b iso -r 'asciidoctor-iso' $^ --trace

open:
	open $(HTML)

.PHONY: bundle all open
