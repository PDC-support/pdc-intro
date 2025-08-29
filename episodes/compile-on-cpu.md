---

<!-- Section: Compiling and running code on CPU nodes -->

# Compiling and running code on CPU nodes

### Johan Hellsvik

---

# Cray programming environment (CPE)

Reference pages: [Compilers and libraries](https://support.pdc.kth.se/doc/software_development/development/), [Build systems course](https://github.com/PDC-support/build-systems-course)

The Cray Programming Environment (CPE) provides consistent interface to multiple compilers and libraries.

* For building on CPU nodes, we recommend use of one the toolchains
  - ``ml PrgEnv-cray`` The Cray Compiler Environment
  - ``ml PrgEnv-gnu`` The GNU Compiler Collection
  - ``ml PrgEnv-aocc`` AMD Optimizing C/C++ and Fortran compilers

* The ``PrgEnv-cray`` is the default toolchain

* Load a PDC module to make available a large set of programs and libraries. Most recent version is currently 24.11. ``ml PDC/24.11``

---

# Compiler wrappers

* Compiler wrappers for different programming languages
    - ``cc``: C compiler wrapper
    - ``CC``: C++ compiler wrapper
    - ``ftn``: Fortran compiler wrapper

* The wrappers choose the required compiler version and target architecture optinons.

* Automatically link to MPI library and math libraries
    - MPI library: ``cray-mpich``
    - Math libraries: ``cray-libsci`` and ``cray-fftw``

---

# Compile a simple MPI code

* ``hello_world_mpi.f90``
  ```
  program hello_world_mpi
  include "mpif.h"
  integer myrank,mysize,ierr
  call MPI_Init(ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD,myrank,ierr)
  call MPI_Comm_size(MPI_COMM_WORLD,mysize,ierr)
  write(*,*) "Processor ",myrank," of ",mysize,": Hello World!"
  call MPI_Finalize(ierr)
  end program
  ```

  ```
  ftn hello_world_mpi.f90 -o hello_world_mpi.x
  ```

---

# What flags does the ``ftn`` wrapper activate?

* Use the flag ``-craype-verbose``

  ```
  ftn -craype-verbose hello_world_mpi.f90 -o hello_world_mpi.x
  ```

---

# Test run the hello world code

Request 8 cores in the shared partition for interactive use
```
salloc -n 8 -t 10 -p shared -A <name-of-allocation> --reservation=<name of reservation>
```
Run on 8 cores in the ``shared`` partition
```
user@uan01:> srun -n 8 ./hello_world_mpi.x
 Processor            4  of            8 : Hello World!
 Processor            6  of            8 : Hello World!
 Processor            7  of            8 : Hello World!
 Processor            0  of            8 : Hello World!
 Processor            1  of            8 : Hello World!
 Processor            2  of            8 : Hello World!
 Processor            3  of            8 : Hello World!
 Processor            5  of            8 : Hello World!
```

---

# Compile a simple linear algebra code

[Link to the code](https://github.com/PDC-support/pdc-intro/blob/master/COMPILE_exercises/dgemm_test.c)

Use cray-libsci. This module is available by default. Load Gnu toolchain

```
ml PrgEnv-gnu
```
Build the code
```
cc dgemm_test.c -o dgemm_test_craylibsci.x
```

---

# Compile a simple linear algebra code

Use openblas. Load the PDC module and the openblas module.

```
ml PDC/24.11 openblas/0.3.29-cpeGNU-24.11
```

```
cc dgemm_test.c -o dgemm_test_openblas.x -I$EBROOTOPENBLAS/include -L$EBROOTOPENBLAS/lib -lopenblas
```
where the environment variable `EBROOTOPENBLAS` had been set when loading the OpenBLAS module. Its module file includes a statement
```
local root = "/pdc/software/24.11/eb/software/openblas/0.3.29-cpeGNU-24.11"
setenv("EBROOTOPENBLAS", root)
```
which corresponds to an export statement
```
export EBROOTOPENBLAS=/pdc/software/24.11/eb/software/openblas/0.3.29-cpeGNU-24.11
```

---

# Check the linked libraries

```
ldd dgemm_test_craylibsci.x
```

```
ldd dgemm_test_openblas.x
```

---

# Check the linked libraries

```
ldd dgemm_test_craylibsci.x

...
libsci_cray.so.6 => /opt/cray/pe/lib64/libsci_cray.so.6
...
```

```
ldd dgemm_test_openblas.x

...
libopenblas.so.0 => /pdc/software/24.11/eb/software/openblas/0.3.29-cpeGNU-24.11/lib/libopenblas.so.0
...
```

---

# Test run the dgemm_test code

* Run on a single core in the ``shared`` partition
  ```
  salloc -n 1 -t 10 -p shared -A <name-of-allocation>
  srun -n 1 ./dgemm_test_craylibsci.x
  srun -n 1 ./dgemm_test_openblas.x
  exit
  ```

* Expected output:
  ```
      2.700     4.500     6.300     8.100     9.900    11.700    13.500
      4.500     8.100    11.700    15.300    18.900    22.500    26.100
      6.300    11.700    17.100    22.500    27.900    33.300    38.700
  ```

---

# Exercise: Compile and run ``fftw_test`` code

```
ml cray-fftw/3.3.10.9

wget https://people.math.sc.edu/Burkardt/c_src/fftw/fftw_test.c

cc --version
cc fftw_test.c -o fftw_test.x

ldd fftw_test.x

salloc -n 1 -t 10 -p shared -A <name-of-allocation>
srun -n 1 ./fftw_test.x
```

---

# Environment variables for manual installation of software

* Environment variables for compilers
  ```
  export CC=cc
  export CXX=CC
  export FC=ftn
  export F77=ftn
  ```

* Environment variables for compiler flags
    - add ``-I``, ``-L``, ``-l``, etc. to Makefile

* Environment variables at runtime
    - prepend to ``PATH``, ``LD_LIBRARY_PATH``, etc.

---

# What happens when loading a module

```
ml show elpa/2025.01.001-cpeGNU-24.11
```

```
whatis("Description: ELPA - Eigenvalue SoLvers for Petaflop-Applications")
prepend_path("CMAKE_PREFIX_PATH","/pdc/software/24.11/eb/software/elpa/2025.01.001-cpeGNU-24.11")
prepend_path("LD_LIBRARY_PATH","/pdc/software/24.11/eb/software/elpa/2025.01.001-cpeGNU-24.11/lib")
prepend_path("LIBRARY_PATH","/pdc/software/24.11/eb/software/elpa/2025.01.001-cpeGNU-24.11/lib")
prepend_path("PATH","/pdc/software/24.11/eb/software/elpa/2025.01.001-cpeGNU-24.11/bin")
prepend_path("PKG_CONFIG_PATH","/pdc/software/24.11/eb/software/elpa/2025.01.001-cpeGNU-24.11/lib/pkgconfig")
...
```

---

# When running your own code

* Load correct programming environment (e.g. ``cpeGNU``)
* Load correct dependencies (e.g. ``openblas`` if your code depends on it)
* Properly prepend to environment variables (e.g. ``PATH``, ``LD_LIBRARY_PATH``)
* Choose correct SLURM settings
