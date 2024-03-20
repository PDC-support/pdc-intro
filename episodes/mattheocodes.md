---

<!-- Section: Materials theory codes -->

# Materials theory codes on Dardel

### Johan Hellsvik


Reference page: [Available software](https://www.pdc.kth.se/software)

---

## Types of computer codes for materials theory modelling
  - Density functional theory (DFT) programs. Often with the DFT extended with for intance dynamical mean field theory (DMFT), GW, hybrid functionals.
  - Atomistic modelling of magnetic or lattice degree of freedom with Monte Carlo or equations of motion solvers
  - Modelling of quantum mechanical many body Hamiltonians
  - ... and more

---

# Density functional theory (DFT) codes

## Challenges
  - Often large complex codes. Difficult to grasp for individual developers and users
  - High memory demand, scaling to different order with number of atoms/electrons/orbitals, plane wave cut-off, angular momentum cut-off, etc
  - High memory bandwidth demand, for instance for large Fourier transforms

## Strategies on heterogeneous supercomputers
  - Make use of optimized CPU/GPU libraries
  - Modularization of code - enabling for multiple backends
  - Develop algorithms with scaled down memory bandwidth demand

---

## The Vienna Ab initio Simulation Package (VASP)

- General purpose program for electronic structure calculations and quantum-mechanical molecular dynamics from first principles.

- VASP is licensed software. For NAISS systems, the VASP licenses are managed on the [SUPR](https://supr.naiss.se/) web portal.

- To use VASP on the Dardel CPU nodes

```
ml PDC/23.03 # Load the PDC/23.03 module
ml av vasp # List all VASP modules in PDC/23.03
ml vasp/6.3.2-vanilla # Load one of the VASP modules
```

Reference page: [General information about VASP](https://www.pdc.kth.se/software/software/VASP/index_general.html)

---

## ABINIT

- General purpose program for electronic structure calculations and quantum-mechanical molecular dynamics, from first principles, using pseudopotentials and a planewave or wavelet basis. Example ABINIT job script

```
#!/bin/bash
#SBATCH -A <your-project-account>
#SBATCH -J abinit-job
#SBATCH -p main
#SBATCH -t 04:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=128

ml PDC/23.03
ml abinit/9.10.3-cpeGNU-23.03

export ABI_PSPDIR=<pseudo potentials directory>
srun -n 128 abinit <input file>.abi > out.log
```

Reference page: [General information about ABINIT](https://www.pdc.kth.se/software/software/ABINIT/index_general.html)

---

## Elk

- Elk is an all-electron full-potential linearised augmented-planewave (FP-LAPW) code. Example job script for a hybrid MPI and OpenMP Elk calculation on Dardel

```
#!/bin/bash
#SBATCH -A <project name>
#SBATCH -J myjob
#SBATCH -p main
#SBATCH -t 10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=16
ml PDC/23.03 elk/9.2.12-cpeGNU-23.03
export OMP_NUM_THREADS=8
export OMP_PLACES=cores
export OMP_PROC_BIND=false
export OMP_STACKSIZE=256M
ulimit -Ss unlimited
srun -n 16 elk > out.log
```

Reference page: [General information about Elk](https://www.pdc.kth.se/software/software/Elk/index_general.html)


---

## How to build Elk

- For maintaining and installing (new versions) of materials theory codes on Dardel, we are mainly using the EasyBuild system. To build Elk 9.2.12 under CPE 23.03, load and launch an EasyBuild with

```
ml PDC/23.03
ml easybuild-user/4.8.2
eb elk-9.2.12-cpeGNU-23.03.eb --robot
```

- A program that has been EasyBuilt and installed on Dardel can (often) be straightforwardly ported to a build configuration for LUMI. Or vice versa, a build on LUMI can be ported for Dardel. The easyconfig build configuration for Elk on Dardel has been ported to LUMI. See and compare the easyconfigs

  - Dardel [elk-9.2.12-cpeGNU-23.03.eb](https://github.com/PDC-support/PDC-SoftwareStack/blob/master/easybuild/easyconfigs/e/elk-9.2.12-cpeGNU-23.03.eb)
  - LUMI [Elk-8.7.10-cpeGNU-22.12.eb](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/blob/main/easybuild/easyconfigs/e/Elk/Elk-8.7.10-cpeGNU-22.12.eb)

Reference page: [Installing software using EasyBuild](https://www.pdc.kth.se/support/documents/software_development/easybuild.html)

---

# Other DFT codes available on Dardel (selected)

- [The Relativistic Spin Polarized tookit (RSPt)](https://www.pdc.kth.se/software/software/RSPt/index_general.html), a code for electronic structure calculations based on the Full-Potential Linear Muffin-Tin Orbital (FP-LMTO) method.

- The [Quantum ESPRESSO](https://www.pdc.kth.se/software/software/Quantum-ESPRESSO/index_general.html) integrated suite of open-source computer codes for electronic-structure calculations and materials modeling at the nanoscale

- [CP2K](https://www.pdc.kth.se/software/software/cp2k/index_general.html), a program to perform atomistic and molecular simulations of solid state, liquid, molecular, and biological systems.

---

# Materials theory codes available on Dardel via Spack

Some codes can be built and installed in your own file area using Spack. Load a Spack user module with
`ml PDC/23.03 spack-user/0.21.0`.

Examples of Spack specs for building on Dardel
- Siesta `spack install siesta@4.0.2%gcc@12.2.0`
- Sirius `spack install sirius@7.4.3%gcc@12.2.0 ^spla@1.5.5%cce@15.0.1`
- BerkeleyGW `spack install berkeleygw@3.0.1%gcc@12.2.0`
- Yambo `spack install yambo@5.1.1%gcc@12.2.0 +dp +openmp`
- BigDFT `spack install bigdft-core@1.9.2%gcc@12.2.0`

Reference page: [Installing software using Spack](https://www.pdc.kth.se/support/documents/software_development/spack.html)

---

# Other materials theory programs and tools

- The [Spglib](https://www.pdc.kth.se/software/software/Spglib/index_general.html) library for finding and handling crystal symmetries
- The [Uppsala Atomistic Spin Dynamics (UppASD)](https://www.pdc.kth.se/software/software/UppASD/index_general.html) software package, a simulation suite to study magnetization dynamics by means of the atomistic version of the Landau-Lifshitz-Gilbert (LLG) equation.
- The [Wannier90](https://www.pdc.kth.se/software/software/Wannier90/index_general.html) open-source code for generating maximally-localized Wannier functions and using them to compute advanced electronic properties of materials with high efficiency and accuracy.
- Phonopy for modelling of phonons `spack install py-phonopy@1.10.0%gcc@12.2.0`

---

# Exercise 1: Run a DFT simulation with ABINIT

Perform a calculation on two Dardel CPU compute nodes with the ABINIT package for modeling of condensed matter.
The example calculation is a DFT simulation with of the properties of the material SrVO3.


Exercise instructions: See [Submit a batch job to the queue](https://www.pdc.kth.se/support/documents/basics/quickstart.html#submit-a-batch-job-to-the-queue) and scroll down to the heading *Example 2: Submit a batch job to queue for a center installed software*

---

# Exercise 2: Build the most recent version of Elk

As of 20240314, the most recent version of Elk globally installed on Dardel is 9.2.12. How to build and make local intall of the newer version 9.5.1?

- First make a local installation of Elk 9.2.12. Why is the `--rebuild` flag needed?

```
ml PDC/23.03 easybuild-user/4.8.2
ml eb elk-9.2.12-cpeGNU-23.03.eb --robot --rebuild
```

- Use the easyfonfig ´elk-9.2.12-cpeGNU-23.03.eb´ as a template to construct a file ´elk-9.5.1-cpeGNU-23.03.eb´. Then build and install locally with `ml eb elk-9.5.1-cpeGNU-23.03.eb --robot`.

Reference page: [Installing software using EasyBuild](https://www.pdc.kth.se/support/documents/software_development/easybuild.html)

---

# Exercise 3: Calculate the magnetic phase diagram of bcc Fe with UppASD

UppASD is a program for simulating atomistic spin dynamics at finite temperatures, which makes it possible to describe magnetization dynamics on an atomic level. Magnetic phase diagrams and thermodynamical properties of a magnetic Hamiltonian can be investigated with techniques for Monte Carlo simulations.

In this exercise you will calculate the magnetic phase diagram of bulk bcc Fe. Exercise instructions: [Determination of Tc of a ferromagnetic material](https://uppasd.github.io/UppASD-manual/tutorial/#determination-of-t-c-of-a-ferromagnetic-material)

Reference pages:
- [UppASD manual](https://uppasd.github.io/UppASD-manual/)
- [UppASD tutorial](https://uppasd.github.io/UppASD-tutorial/)
- [UppASD autumn school 2022](https://www.pdc.kth.se/about/events/training/uppasd-autumn-school-2022-1.1187827)
