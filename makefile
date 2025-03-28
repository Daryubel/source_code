# Makefile to compile HYDRUS-1D on Mac and Linux

# Find the fortran compiler
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	CC = /usr/local/bin/gfortran
endif
ifeq ($(UNAME_S),Linux)
	CC = /usr/bin/gfortran
endif

# Set the files and objects
objects = HYDRUS.o INPUT.o HYSTER.o MATERIAL.o OUTPUT.o SINK.o SOLUTE.o TEMPER.o TIME.o WATFLOW.o
files = source/HYDRUS.FOR source/INPUT.FOR source/HYSTER.FOR source/MATERIAL.FOR source/OUTPUT.FOR source/SINK.FOR source/SOLUTE.FOR source/TEMPER.FOR source/TIME.FOR source/WATFLOW.FOR
FFLAGS = -g -ffpe-summary=none
# Compile to a unix executable
hydrus:
	$(CC) $(FFLAGS) -c $(files)
	$(CC) -o hydrus $(objects)
	rm $(objects)

# Compile to an shared-object file to import in python (WIP)
f2py : 
	f2py -c $(files) -m hydrus

# Clean the directory after
clean : 
	rm $(objects)