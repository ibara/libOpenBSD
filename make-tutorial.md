# make
You may want to use `make` to simplify the building of your programs for class.
The tool itself is installed by default on all BSDs and macOS. Linux users may
have to install the tool. On a Debian-based system, this will probably be
something like:
```
$ sudo apt-get install make
```
This short tutorial will describe how to write a basic `Makefile` which will
work with BSD make and GNU make, the two most commonly used `make` programs.

## Writing Makefiles
If you have a file in a directory named `Makefile`, then the `make` utility will
automatically discover and use it to build your programs. You must have such a
file or else `make` won't work!

Using a `Makefile` will allow you to only have to type in your compiler commands
once, then `make` will always use them.

Let's say I have a directory with the files `one.c` and `two.c` that together
make a program named `three`.

My `Makefile` would look like this:
```
# Makefile for the three program.

CC =		cc
CFLAGS =	-O0 -pipe -g -W -Wall

PROG =	three
OBJS =	one.o two.o

all: ${OBJS}
	${CC} ${LDFLAGS} -o ${PROG} ${OBJS}

clean:
	rm -f ${PROG} ${OBJS} *.core
```
Let's break this down line by line.

The first line is a comment. Comments begin with a # and extend to the end of
the line. It is good practice to never use in-line comments. If you need to
write a comment in a `Makefile`, put the comment on its own line(s) above the
code in question.

`CC` is a variable that represents your C compiler. On the BSDs, the C compiler
is named `cc` or `clang` (they are the same). On macOS, it is named `clang`. On
Linux, it is named either `gcc` or `clang`, depending on which compiler you
chose.

`CFLAGS` is a variable that represents the options you want passed to your C
compiler when compiling files. Out in the real world, if you do not know what
options to pass the C compiler, you should use `-O2 -pipe`. The `-O2` flag will
enable the recommended optimizations as suggested by the compiler writers. The
`-pipe` flag uses named pipes instead of temporary files to pass around
intermediate code. This used to be quite a performance improvement back in the
day. It is less of a performance improvement now but has come to be considered
good style and practice. For this class, however, you should use `-O0 -pipe -g`
unless I tell you otherwise. The `-O0` flag disables all optimizations and the
`-g` flag puts debugging information into your binary, which will be helpful
when we look at programs in a debugger. `-W` and `-Wall`, as I have in the
example, are used to enable warnings from the compiler. You don't need them for
class, but they are useful in the real world.

`PROG` is a variable that represents the name of the binary you wish to create.

`OBJS` is a variable that represents the _object files_ that create `PROG`. This
will be a list of your source files, except you end them in `.o` instead of
`.c`.

After your variables, you write your targets. Targets are the actions `make`
will take when invoking it. This `Makefile` has two targets: `all` and `clean`.
For example, to make `make` run the clean target, you would invoke the utility
as `make clean`.

`all` is a special target. If `make` sees an `all` target, it will default to
using that target if you simply issue the command `make`. Targets must have a
colon `:` character immediately after them. Anything immediately after the `:`
is considered a _dependency_ of that target, and will be executed first.
In this case, the phrase `all: ${OBJS}` means "in order for the all target to
begin, you must have already created all the object files." Lines underneath the
target line are the _actions_ of the target. Actions must begin with a `<tab>`
character. The action line `${CC} ${LDFLAGS} -o ${PROG} ${OBJS}` says that there
is only one action of the `all` target, and it is to use the C compiler to link
the object files into the final binary.

`clean` is a target that has no dependencies, so it immediately enters its
actions. It has only one action: to delete the final program file, the object
files, and any coredumps the program may have created when you ran it.

## Style and best practices
* It is considered good practice to put a space between the variable name and
the `=`. After the `=` you should use `<tabs>` instead of `<spaces>`.
* Variables should be joined logically. I call them paragraphs when I teach this
stuff. Tabs should be aligned by paragraph, and there should always be at least
one (but possibly more than one) tab after each `=`. For example, `CC` and
`CFLAGS` are one paragraph because the C compiler and its options are a logical
grouping. If I only had one `<tab>` after `CC =` then the alignment would
dictate that there would be no `<tabs>` after `CFLAGS =`. Because each `=`
should have at least one `<tab>`, it means that there are two `<tabs>` after
`CC =` and one `<tab>` after `CFLAGS =` so that things are aligned. Likewise,
`PROG` and `OBJS` are a logical grouping, and each has only one `<tab>` after
the `=`. Paragraphs should be separated by a blank line.
* The tab alignment for each paragraph should be done in a way that there is
always _at least one_ `=` that has _exactly one_ `<tab>`. It would be bad style,
for example, to have two `<tabs>` after `PROG` and `OBJS` because there would be
no `=` in that paragraph with exactly one `<tab>`.
* There should be a blank line separating your variables from your first target.
Likewise, each target should be separated by a blank line.
* You must declare all your variables before your first target. This is a
requirement of `make`.
* Anything that can be made a variable should be made a variable. This prevents
typos from accidentally deleting your source files.
* Comments should always be on a line by themselves, with the `#` character
always being the first character of the line. No in-line comments.
