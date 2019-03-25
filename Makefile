ASMFILES	:= $(wildcard src/*.asm)
OBJFILES	:= $(patsubst src/%.asm, build/src/%.o, $(ASMFILES))
DYLIB		:= bin/maths/libmaths.dylib
STATIC		:= bin/maths/libmaths.a

TESTASM		:= $(wildcard tests/*.asm)
TESTOBJS	:= $(patsubst tests/%.asm, build/tests/%.o, $(TESTASM))
TESTEXES	:= $(patsubst build/tests/%.o, bin/tests/%, $(TESTOBJS))
TESTFLAGS	:= -L bin/maths -lmaths

NASM		:= nasm
LD			:= ld
LIBTOOL		:= libtool

NASMFLAGS	:= -f macho64
LDFLAGS		:= -lSystem /usr/lib/crt1.o -macosx_version_min 10.14


all: dir link

.PHONY: all dir link objs test clean fclean re

dir:
	@echo "\033[0;33m\nCreating Build Folders\033[0m"
	mkdir -p build
	mkdir -p bin
	mkdir -p build/src
	mkdir -p build/tests
	mkdir -p bin/tests
	mkdir -p bin/maths
	@echo "\033[0;32mBuild Folders Created Succesfully\n\033[0m"

link: objs
	@echo "\033[0;33mLinking and Compiling\033[0m"
	$(LIBTOOL) -static -o $(STATIC) $(OBJFILES)
	$(LIBTOOL) -dynamic -macosx_version_min 10.14 -o $(DYLIB) $(OBJFILES)
	@echo "\033[0;32mSuccesfully Created libmaths.a\n\033[0m"

objs:
	@echo "\033[0;33mCreating Object Files\033[0m"
	make $(OBJFILES)
	@echo "\033[0;32mObject Files Created Succesfully\n\033[0m"

test:
	make $(TESTOBJS)
	make $(TESTEXES)

build/src/%.o: src/%.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

build/tests/%.o: tests/%.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

bin/tests/%: build/tests/%.o
	$(LD) $(LDFLAGS) $(TESTFLAGS) -o $@ $<

clean:
	rm -rf $(STATIC) $(DYLIB)

fclean: clean
	@echo "\033[0;33m\nCleaning Dir\033[0m"
	rm -rf $(OBJFILES)
	rm -rf $(TESTOBJS)
	rm -rf $(TESTFILES)
	rm -rf build
	rm -rf bin

re: fclean all