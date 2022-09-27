---
marp: true
backgroundImage: url('/afs/pdc.kth.se/home/h/hzazzi/Documents/Presentations/intro_pdc/img/background.png')
style: |
  section h1 {
    text-align: center;
    }
  .column50 {
    float: left;
    width: 48%;
    border: 20px solid transparent;
    background-color: transparent;
    }
  .columnlightblue {
    border: 10px solid #b6e0ff;
    background-color: #b6e0ff;
    box-shadow: 10px 10px 10px #888888;
    margin-top: 20px;
    margin-left: 20px;
    }
  .columnblue {
    border: 10px solid #99c0ff;
    background-color: #99c0ff;
    box-shadow: 10px 10px 10px #888888;
    margin-top: 20px;
    margin-left: 20px;
    }
  .columndarkblue {
    border: 10px solid #77a0ff;
    background-color: #77a0ff;
    box-shadow: 10px 10px 10px #888888;
    margin-top: 20px;
    margin-left: 20px;
    }
  .row:after {
    display: table;
    clear: both;
    }
---
<!-- paginate: true -->

# Introduction to PDC
![bg](/afs/pdc.kth.se/home/h/hzazzi/Documents/Presentations/intro_pdc/img/first_slide.png)
# Henric Zazzi 2022-08-16
#
#

---

# Overview

1. General information about PDC
1. Infrastructure at PDC
1. How to apply to PDC resources
1. How to login
1. File systems, permissions and transfer
1. Modules
1. How to run jobs
1. How to compile
1. Conclusion

---

# General information about PDC

---

# SNIC Centra

<div class="row">
<div class="column50">

The Swedish National Infrastructure for Computing (SNIC) is a national research infrastructure that provides a balanced and cost-efficient set of resources and user support for large scale computation and data storage to meet the needs of researchers from all scientific disciplines and from all over Sweden (universities, university colleges, research institutes, etc). The resources are made available through open application procedures such that the best Swedish research is supported.

</div>
<div class="column50">

![height:570px](/afs/pdc.kth.se/home/h/hzazzi/Documents/Presentations/intro_pdc/img/sweden.png)


</div></div>

---

# PDC offers...

![height:600px](/afs/pdc.kth.se/home/h/hzazzi/Documents/Presentations/intro_pdc/img/pdc_offers.png)

---

# Research areas at PDC

![height:450px](/afs/pdc.kth.se/home/h/hzazzi/Documents/Presentations/intro_pdc/img/beskow_statistics.jpeg)

*Usage of beskow, march 2017*

---

# PDC key assets: Support

### First-line support
Helps you have a smooth start to using PDC’s resources and provides assistance if you need help while using our facilities

### Advanced support
Application experts that can support in development of code, how to submit jobs, scaling, projects and allocations

### System administrators
System managers/administrators that ensure that PDC’s HPC and storage facilities run smoothly and securely

---

# Infrastructure at PDC

---

# Dardel

<div class="row">
<div class="column50">

![](/afs/pdc.kth.se/home/h/hzazzi/Documents/Presentations/intro_pdc/img/dardel.png)

**Nodes:** 794
**Cores:** 101632
**Peak performance:** 13.5 PFLOPS

</div>
<div class="column50 columnlightblue">

### Node configuration

* 2xAMD EPYC™ 2.25 GHz 64 cores
* RAM
  * 524 nodes, 256 GB
  * 256 nodes, 512 GB RAM
  * 8 nodes, 1024 GB RAM
  * 6 nodes, 2048 GB RAM
* <span style="color:red;">4xAMD Instinct™ MI250X GPUs</span>

</div></div>

---

# How to apply for PDC resources

---

# How to access PDC resources

* User account (SUPR/PDC)
  * For projects you must have a SUPR and a PDC account
  * A PDC account suffices for courses
* Every user must belong to at least one time allocation

### Time allocation
* A measure for how many jobs you can run per month (corehours/month)
* Which clusters you can access

---

# Flavors of time allocations

<div class="columnlightblue">

**Small allocation** *<5000 corehours/month*
Applicant can be a PhD student or higher
Evaluated on a technical level only
   
</div>
<div class="columnblue">

**Medium allocation** *5000-200000 corehours/month*
Applicant must be a senior scientist in swedish academia
Evaluated on a technical level only
	
</div>
<div class="columndarkblue">

**Large allocation** *200000 corehours/month*
Applicant must be a senior scientist in swedish academia
Evaluated on a technical and scientific level
Proposal evaluated by SNAC twice a year

</div>

---

# Can I use PDC resources?

* PDC resources are **free** for swedish academia
* Please acknowledge SNIC/PDC in your publications
  *"The computations/data handling/[SIMILAR] were/was enabled by resources provided by the Swedish National Infrastructure for Computing (SNIC), partially funded by the Swedish Research Council through grant agreement no. 2018-05973"*
* More information at http://www.snic.se/allocations/apply4access/

---

# How to get a time allocation

* You can apply for a SUPR account at https://supr.snic.se
* In SUPR send in a proposal for your project
* More information at http://www.snic.se/allocations/apply4access/

---

# How to login

---

# Login with SSH pairs

* Only available if you have a SUPR account
* More information at https://www.pdc.kth.se/support/documents/login/ssh_login.html

---

# Kerberos

* authentication protocol originally developed at MIT
* PDC uses kerberos together with SSH for login

### Ticket
* Proof of users identity
* Users use password to obtain tickets
* Tickets are cached on users computer for a specified duration
* <span style="color:red;">Tickets should always be created on your local computer</span>
* As long as tickets are valid there is no need to enter password

---

## Kerberos realm
All resources available to access
Example: NADA.KTH.SE

## Principal
Unique identity to which kerberos can assign tickets
Example: [username]@NADA.KTH.SE

---

# Kerberos commands

| Command | Description |
| --- | --- |
| kinit | proves your identity |
| klist | List of your kerberos tickets |
| kdestroy | destroy your kerberos ticket file |
| kpasswd | change your kerberos password |

```
$ kinit -f [username[@NADA.KTH.SE
$ klist -T
Principal: [username]@NADA.KTH.SE
Issued Expires Flags Principal
Mar 25 09:45 Mar 25 19:45 FI krbtgt/NADA.KTH.SE@NADA.KTH.SE
```

---

# Login using kerberos ticket

1. Get a 7 days forwardable ticket on your local system
   ```
   $ kinit -f -l 7d [username]@NADA.KTH.SE
   ```
1. Forward your ticket via ssh and login
   ```
   $ ssh [username]@dardel.pdc.kth.se
   ```

---

# Login from any OS

* You can reach PDC from any computer or network
* The kerberos implementation heimdal can be installed on most operating systems
  * **Linux:** heimdal, openssh-client
  * **Windows:** Network Identity Manager, PuTTY
  * **Mac:** homebrew/openssh
  * **KTH Computers:** pdc-[kerberos command]
* Follow the instructions for your operating system https://www.pdc.kth.se/support/documents/login/login.html

---

# File systems at PDC

<div class="row">
<div class="column50 columnlightblue">

## Lustre file system

1. Distributed
1. High performance
1. No backup

</div>
<div class="column50">

### $HOME
**Quota:** 25 GB
```
/cfs/klemming/home/[u]/[username]
```
### Scratch
Data deleted after 30 days
```
/cfs/klemming/scratch/[u]/[username]
```

### Projects
**Quota:** according to project
```
/cfs/klemming/projects/snic/
```

</div></div>

---

# File transfer

Files can be transfered to PDC clusters using **scp**

https://www.pdc.kth.se/support/documents/data_management/data_management.html

### From my laptop to $HOME at dardel
```
scp file.txt [username]@dardel.pdc.kth.se:~
```

### From my laptop to scratch on dardel
```
scp file.txt [username]@dardel.pdc.kth.se:/cfs/klemming/scratch/[u]/[username]
```

---

# Modules

## Used to load a specific software, and versions, into your environment

```
$ module show R/4.0.0
-------------------------------------------------------------------
/pdc/modules/system/base/R/4.0.0:

module-whatis	 GNU R 
module-whatis	   
module		 add gcc/7.2.0 
module		 add jdk/1.8.0_45 
prepend-path	 PATH /pdc/vol/R/4.0.0/bin 
prepend-path	 MANPATH /pdc/vol/R/4.0.0/share/man 
prepend-path	 LD_LIBRARY_PATH /pdc/vol/R/4.0.0/lib64/ 
-------------------------------------------------------------------
```

---

# Module commands

| Command | Abbreviation | Description |
| --- | --- | --- |
| module load *[s]/[v]* | ml *[s]/[v]* | Loads software/version |
| module avail *[s]/[v]* | ml av *[s]/[v]* | List available software |
| module show *[s]/[v]* | ml show *[s]/[v]* | Show info about software |
| module list | ml | List currently loaded software |
| ml spider *[s]* |  | searches for software |
| module swap *[s1]/[v1]* *[s2]/[v2]* | ml *[s2]/[v2]* | Swap one module 1 for module 2 |

**[s]:** Software. Optional for *avail* command
**[v]:** Version. Optional. Latest by default

---

# Accessing the Cray Programming Environment

```
$ ml av PDC
---- /pdc/software/modules ---------------------
   PDC/21.09    PDC/21.11 (L,D)    PDCTEST/22.04

```

* Every PDC module relate to a specific version of **CPE**
* Every software is installed under a specific **CPE**
* To access the softwares you need to first...
  ```
  $ ml PDC/21.11
  ```
* Omitting the *[version]* you will load the latest stable **CPE**

---

# How to run jobs

---

# SLURM workload manager

<div class="column columnlightblue">
Allocates exclusive and/or non-exclusive access to resources (computer nodes) to users for some duration of time so they can perform work.
</div>
<div class="column columnlightblue">
Provides a framework for starting, executing, and monitoring work (typically a parallel job) on a set of allocated nodes.
</div><div class="column columnlightblue">
Arbitrates contention for resources by managing a queue of pending work
</div><div class="column columnlightblue">
Installed by default, no need to load module
</div>

---

# Which allocation I am a member of

### projinfo

```
$ projinfo -h
Usage: projinfo [-u <username>] [-c <clustername>] [-a] [-o] [-m] [-c <cluster>] [-d] [-p <DNR>] [-h]
-u [user] : print information about specific user
-o : print information about all (old) projects, not just current
-m : print usage of all months of the project
-c [cluster] : only print allocations on specific cluster
-a : Only print membership in projects
-d : Usage by all project members
-p [DNR] : only print information about this project
-h : prints this help
```
Statistics are also available at… 
https://pdc-web.eecs.kth.se/cluster_usage/

---

# Partitions

#### Partition are a mandatory entry for running jobs on Dardel

<div class="row">
<div class="column50 columnlightblue">

**Main**
Exclusive node access
Time limit: 24h

</div>
<div class="column50 columnlightblue">

**Shared**
Shared node access
Time limit: 24h (most nodes), 7 days

</div></div>
<div class="row">
<div class="column50 columnlightblue">

**Long**
Exclusive node access
Time limit: 7 days

</div>
<div class="column50 columnlightblue">

**Memory**
Exclusive node access
Time limit: 24h
Nodes with 512 Gb RAM or more  

</div></div>

---

# Using salloc

#### To book and execute on a dedicated node
```
$ salloc -t <min> -N <nodes> -A <allocation> -p <partition> srun -n <processes> ./MyPrgm
```
#### To run interactively
```
$ salloc -t <min> -N <nodes> -A <allocation> -p <partition>
$ ml [modulename]
$ srun -n <processes> <executable>
$ srun -n <cores> <executable>
$ exit
```
---

# Other SLURM flags

| Command | Description |
| --- | --- |
| -p shared -n [processes] | Shared node. **-n Must be present on shared job** |
| --reservation=[reservation] | Reserved nodes |
| --mem=1000000 | At least 1TB RAM |
| --mincpus=24 | At least 24 logical CPUs |
| --gres=gpu:K80:2 | Node with a K80 GPU |

#### If the cluster does not have enough nodes of that type then the request will fail with an error message.

---

# Using sbatch scripts

<div class="row">
<div class="column50 columnlightblue">

#### Create a file

</div><div class="column50">

```
#!/bin/bash -l
# Name of job
#SBATCH -J <myjob>
#SBATCH -A <allocation ID>
# Reservation if needed
#SBATCH --reservation=<reservation ID>
#SBATCH -t 10:00
#SBATCH --nodes=1
#SBATCH -p shared
#SBATCH -n <processes>
# load modules and run
ml PDC/21.11
srun -n 1 ./MyPrgm
```

</div><div class="row">
</div><div class="column50 columnlightblue">

#### Run

</div><div class="column50 column">

```
$sbatch <myfile>
```

</div></div>

---

# Other SLURM commands

### Show my running jobs
```
$ squeue [-u <username>]
```

### To remove a submitted job
```
$ scancel [jobID]
```

---

# Reservation

| Reservation | Starttime | Endtime | Nodes | Partition |
| --- | --- | --- | --- | --- |
| summer-test | 2022-08-15T11:00 | 2022-08-15T12:00  | 2 |  shared |
| summer-2022-08-16 | 2022-08-16T15:00 | 2022-08-16T17:30 | 8 | shared | 
| summer-2022-08-17 | 2022-08-17T13:00 | 2022-08-17T17:30 | 8 | shared | 
| summer-2022-08-18 | 2022-08-18T13:00 | 2022-08-18T15:30 | 8 | shared |
| summer-2022-08-19 | 2022-08-19T13:00 | 2022-08-19T17:30 | 8 | shared |  
| summer-2022-08-22 | 2022-08-22T13:00 | 2022-08-22T17:30 | 8 | shared | 
| summer-2022-08-23 | 2022-08-23T13:00 | 2022-08-23T17:30 | 8 | shared |  

---

# How to compile on Dardel

<div class="column50 columnlightblue">

### Dardel uses compiler wrappers

</div>

### PrgEnv module

* PrgEnv-cray, PrgEnv-gnu, PrgEnv-aocc (AMD compiler)
* By default **PrgEnv-cray** is loaded
* Swap it by using command...
  ```
  $ ml swap PrgEnv-cray PrgEnv-<other>
  ```

---

# Compiler wrappers

* Always use the wrappers

  * **cc** C code
  * **CC** C++ code
  * **ftn** Fortran code
      
* Wrappers automatically link with math libraries if their modules are loaded
  ```
  $ ml cray-libsci fftw
  ```

* Other libraries are lapack, blas scalapack, blacs,...
  https://www.pdc.kth.se/software/#libraries

---

# Compiling serial code on Tegner
```
#GNU
$ gfortran -o hello hello.f
$ gcc -o hello hello.c
$ g++ -o hello hello.cpp
#Intel
$ module add i-compilers
$ ifort -FR -o hello hello.f
$ icc -o hello hello.c
$ icpc -o hello hello.cpp
```

---

# Compiling MPI/OpenMP code on Tegner

```
#GNU
$ module add gcc/9.2 openmpi/4.1-gcc-9.2
$ mpif90 -FR -fopenmp -o hello_mpi hello_mpi.f
$ mpicc -fopenmp -o hello_mpi hello_mpi.c
$ mpic++ -fopenmp -o hello_mpi hello_mpi.cpp
#Intel
$ module add i-compilers intelmpi
$ mpiifort -openmp -o hello.f90 -o hello_mpi
$ mpiicc -openmp -o hello_mpi hello_mpi.c
$ mpiicpc -openmp -o hello_mpi hello_mpi.cpp
```

---

# PDC Support

1. A lot of question can be answered via our web http://www.pdc.kth.se/support
1. The best way to contact us is via e-mail https://www.pdc.kth.se/support/documents/contact/contact_support.html
1. The support request will be tracked
1. Use a descriptive subject in your email
1. Give your PDC user name.
1. Provide all necessary information to reproduce the problem.
1. For follow ups always reply to our emails
