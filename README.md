# Setup
```
opam switch create . ocaml-base-compiler.4.06.1
opam install dune z3
export LD_LIBRARY_PATH=_opam/lib/z3/
make
```

# Repro

the memory thresholds might be different depending on machine

with 400mb max-memory:

```
> _build/default/src/repro.exe 400
libc++abi.dylib: terminating with uncaught exception of type out_of_memory_error
[1]    40833 abort      _build/default/src/repro.exe 400
```

with 500mb max-memory:
```
> _build/default/src/repro.exe 500
caught Z3.Error: out of memory
```
