GHC=ghc
GHC_RUNTIME_LINKER_FLAG=-lHSrts-ghc7.10.3.so

libffi-example.so: Example.o wrapper.o
	$(GHC) -o $@ -shared -dynamic -fPIC $^ $(GHC_RUNTIME_LINKER_FLAG)

Example_stub.h Example.o: Example.hs
	$(GHC) -c -dynamic -fPIC Example.hs

wrapper.o: wrapper.c Example_stub.h
	$(GHC) -c -dynamic -fPIC wrapper.c

fib.cpython-37m-x86_64-linux-gnu.so:
	python setup.py build_ext -i

cython: fib.cpython-37m-x86_64-linux-gnu.so

clean:
	rm -f *.hi *.o *_stub.[ch]

clean-all:
	rm -f *.hi *.o *_stub.[ch] *.so


# Runs the example Python program
example: libffi-example.so
	python program.py
