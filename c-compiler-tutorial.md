# C compiler
You will predominantly use `clang` for this class. On our server, it is aliased
to `cc`. There is also `gcc` (for historical reasons, named `egcc`), `pcc`,
`tcc`, `cparser`, and `ccomp` installed on the server as well. You are welcome
to use them but unless specifically stated otherwise (notably, the coding
project), you should stick with `cc`.

I will occasionally use `pcc` to generate assembly for us to look at as a class.
This is because `pcc` generates much simpler assembly than `cc`, and also
doesn't use all the fancy security features built into `cc`. That makes it
easier for us to read the assembly.

I invite you to read through the
[clang](https://clang.llvm.org/docs/CommandGuide/clang.html) and
[gcc](https://linux.die.net/man/1/gcc) manual pages, particularly if you are not
very familiar with the C compiler. There is an overwhelming number of options, I
understand this. But there's only a few you realistically need to know in order
to get through this course.

`gcc` and `clang` take the same options, so I will just use `cc` to mean either
compiler.

* `cc file.c` will compile a file named `file.c` into a binary named `a.out`.
The name `a.out` is for historical reasons.
* `cc -o file file.c` will compile a file named `file.c` into a binary named
`file`. So you can control the output file name with `-o`.
* `-O0` disables optimizations. Always use it for class.
* `-O2` enables all recommended optimizations. While we won't use `-O2` in
class, `-O2` is an ideal default unless you have special requirements.
* `-pipe` will make your compiles a little bit faster on `gcc` and is a noop on
`clang`. Always use it.
* `-g` turns on debug symbols. Always use it for class since we will use the
debugger.
* `cc -S file.c` will compile the file `file.c`, write the assembly to `file.s`,
and stop. It will not produce a binary. Very useful for when we start looking at
assembly code.
* `cc -c file.c` will compile and assemble the file `file.c`, write the object
file to `file.o`, and stop. This is used when you have multiple C files (called
modules) that are used to then create a binary. In other words, this flag is
always used when compiling real software into a binary, as you have to create
all the object code first, then link those files together to make the binary.
* `-Wall` will turn on all the common warnings. Useful for making sure you are
writing clean code.
* `-Wextra` or simply `-W` will turn on even more warnings. Sometimes these
warnings will produce false positives. Useful if you want to dive into the more
pedantic rules of C.
* `-w` will turn off all warnings.

And that's really it. You can get pretty far with just knowing those compiler
flags. You may in your reading be tempted to use the `-march=` and `-mtune=`
flags, particularly in their `-march=native` and `-mtune=native` variants. Don't
use those. Ever. Unless you really know what you are doing.

Don't forget to read the
[make tutorial](https://github.com/ibara/libOpenBSD/blob/master/make-tutorial.md)
too.
