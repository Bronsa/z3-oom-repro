.PHONY: build
build:
	dune build @install

.PHONY: run
run: build
	_build/default/src/repro.exe
