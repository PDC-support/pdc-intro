---

<!-- Section: Using Matlab -->

# Using MATLAB

### Johan Hellsvik

---

# Using MATLAB

![bg right:50% width:80%](https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Matlab_Logo.png/667px-Matlab_Logo.png)

MATLAB is a proprietary multi-paradigm programming language and numeric computing environment developed by MathWorks.

MATLAB allows matrix manipulations, plotting of functions and data, implementation of algorithms, creation of user interfaces, and interfacing with programs written in other languages.

---

# MATLAB at PDC

## Licensing

In order to use MATLAB you need to have a MATLAB license.

KTH has a MATLAB site license valid for academic users that are affiliated with KTH or with other universities. The license includes all MATLAB toolboxes.

To access the installation of MATLAB on Dardel, please contact PDC support and request access.

## Interactive and batch use of MATLAB

MATLAB can be run on Dardel both in interactive sessions, with or without a graphical user interface, or in batch jobs.

---

# Running interactively

Matlab can be run interactively on allocated cores. To book 24 cores for one hour

```
salloc -n 24 -t 1:00:00 -p shared -A edu2304.intropdc
```

Wait for cores to be reserved

```
salloc: Granted job allocation 591571
salloc: Waiting for resource configuration
salloc: Nodes nid001015 are ready for job
```

Log in to the node where the cores reside

```
ssh -X nid00105
```

---
and start MATLAB with graphical user interface (GUI)

```
ml PDC/22.06
ml matlab/r2023a
matlab
```

if you have not got X11 forwarding active, start MATLAB without GUI

```
ml PDC/22.06
ml matlab/r2023a
matlab -nodisplay -nodesktop -nosplash
```

---

# Parallel computation with Matlab

MATLAB implements a large set of solutions for parallel computing.

* Vectorization
* Automated parallel computing support
* Parallel execution of loops with ``parfor``
* Running multiple serial batch jobs

---

# Parallel execution with ``parfor``

Calculation of the spectral radius of a matrix

Consider first serial code: [spectral_serial.m](https://github.com/PDC-support/pdc-intro/blob/master/MATLAB_exercises/spectral_serial.m)

```
tic
disp('Start serial calculation of spectral radius')
n = 500;
A = 1000;
a = zeros(n);
for i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
toc
disp('End serial calculation of spectral radius')
```

Execution time on one core: 297 s

Can this be parallelized? How large is the overhead?

---

A ``parfor`` loop can be used to execute loop iterations in parallel on workers in a parallel pool.

Replace `for` statements in serial code with ``parfor`` to obtain [spectral_parfor.m](https://github.com/PDC-support/pdc-intro/blob/master/MATLAB_exercises/spectral_parfor.m)


```
tic
disp('Start parallel calculation of spectral radius')
ticBytes(gcp);
n = 500;
A = 1000;
a = zeros(n);
parfor i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
tocBytes(gcp)
disp('End parallel calculation of spectral radius')
toc
```

Execution time on 24 cores: 30 s

Speedup as compared to execution time on 1 core: 9.9

---
# Parallel execution of MATLAB in batch jobs

Also for batch job use of MATLAB, consider to use the shared partition of Dardel. Example job script [jobMATLABn16.sh](https://github.com/PDC-support/pdc-intro/blob/master/MATLAB_exercises/jobMATLABn16.sh)


```
#!/bin/bash -l
#SBATCH -A snicYYYY-X-XX
#SBATCH -J myjob
#SBATCH -p shared
#SBATCH -n 16
#SBATCH -t 01:00:00

# Load the Matlab module
ml add PDC/22.06
ml matlab/r2023a

# Run matlab taking your_matlab_program.m as input
matlab -nodisplay -nodesktop -nosplash < your_matlab_program.m > your_matlab_program.out
```

---

# Running multiple serial batch jobs

```
#!/bin/bash -l
#SBATCH -A snicYYYY-X-XX
#SBATCH -J myjob
#SBATCH -p shared
#SBATCH -n 24
#SBATCH -t 02:00:00

# Load the Matlab module
ml add PDC/22.06
ml matlab/r2023a

# Run matlab for 24 individual programs serial_program_1.m,
# serial_program_2.m ... and print output in files logfile_1, logfile_2, ...
# The input files must be in the directory where you submit this script.
# This is also where the output will be created.

for i in {1..24} ; do
    matlab -nosplash -nodesktop -nodisplay < serial_program_${i}.m > logfile_$i &
done
# this wait command must be present since otherwise the job will terminate immediately
wait
```

---

# Exercise 1

## Calculating spectral radius in interactive session

* Request node / cores for interactive session
* Log in to the node, and start MATLAB
* Experiment with [spectral_serial.m](https://github.com/PDC-support/pdc-intro/blob/master/MATLAB_exercises/spectral_serial.m) and [spectral_parfor.m](https://github.com/PDC-support/pdc-intro/blob/master/MATLAB_exercises/spectral_parfor.m)
  * Compare runtimes serial code vs parallel code for n = 200; A = 500;
  * Change values of n and A. How does relative runtime change?

---

# Exercise 2

## Calculating spectral radius in batch job

* Edit the template script [jobMATLABn16.sh](https://github.com/PDC-support/pdc-intro/blob/master/MATLAB_exercises/jobMATLABn16.sh). You will need to
  * Specify allocation and reservation
  * Change the name of the MATLAB program
  * Consider to change the time for the job and number or cores

* Launch jobs for both the serial and the parallel versions of the spectral radius code


