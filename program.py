from ctypes import cdll


lib = cdll.LoadLibrary("./libffi-example.so")

lib.example_init()

for x in range(10):
    print(f"Haskell fib{x}: {lib.fibonacci_hs(x)}")

lib.example_exit()
