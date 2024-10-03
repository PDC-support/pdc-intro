---
marp: true
style: |
  section h1 {
    text-align: center;
    }
  .column {
    float: left;
    width: 50%;
    outline: 20px solid #FFF;
    border: 20px solid #AAF;
    background-color: #AAF;
    }
  .row:after {
    display: table;
    clear: both;
    }
---

# <!--fit--> Introduction to PDC

2024-03-21

PDC staff

<style scoped>a { color: #eee; }</style>

---

# Contents

* [Background and infrastructure](#3)
* [Accounts, login, and file system](#18)
* [Using Bash shell](#31)
* [Compiling and running code on CPU nodes](#64)
* [Job script for efficient utilization of hardware](#86)
* [Using ThinLinc](#117)
* [Compiling and running code on GPU nodes](#118)
* [Using Singularity](#134)
* [Using Matlab](#135)
* [Materials theory codes](#147)
* [Using Python virtual environment](#160)

---

<!-- Section: Background and infrastructure -->

# Background and infrastructure

---

![bg top:90% width:80%](./assets/pdc-homepage.jpg)

---

# History of PDC

| Year | rank | procs. | peak TFlops | vendor | name | remark |
| --- | --- | --- | --- | --- | --- | --- |
| 2017 | 69  | 67456 | 2438.1 | Cray | Beskow | XC40 16-core 2.3GHz |
| 2014 | 32  | 53632 | 1973.7 | Cray | Beskow | |
| 2011 | 31  | 36384 | 305.63 | Cray | Lindgren | XE6 12-core 2.1GHz  |
| 2010 | 76  | 11016 | 92.534 | Cray | Lindgren | |
| 2010 | 89  | 9800  | 86.024 | Dell | Ekman | PowerEdge SC1435 Dual core Opteron 2.2GHz |

---

# History of PDC

| Year | rank | procs. | peak TFlops | vendor | name | remark |
| --- | --- | --- | --- | --- | --- | --- |
| 2005 | 65  | 886   | 5.6704 | Dell | Lenngren | PowerEdge 1850 3.2GHz |
| 2003 | 196 | 180   | 0.6480 | HP | Lucidor | Cluster Platform 6000 rx2600 Itanium2 900MHz |
| 1998 | 60  | 146   | 0.0934 | IBM | Strindberg | SP P2SC 160MHz  |
| 1996 | 64  | 96    | 0.0172 | IBM | Strindberg | |
| 1994 | 341 | 256   | 0.0025 | Thinking Machines | Bellman | CM-200/8k  |

---

# PDC is finansed by NAISS

![bg left:25% width:100%](https://github.com/PDC-support/pdc-intro/raw/master/outreach/outreach_pdc/img/naiss_sweden.png)

* NAISS: National Academic Infrastructure for Supercomputing in Sweden

* Resources: Chalmers Tek. Högskola, Kungliga Tek. Högskola, Linköping Universitet, Uppsala Universitet

* Branches: Chalmers Tek. Högskola, Göteborg Universitet, Karolinska institutet, Kungliga Tek. Högskola, Linköpings Universitet, Lund Universitet, Stockholm Universitet, Umeå Universitet, Uppsala Universitet,

---

# Collaboration with Industry

![bg right:45% width:100%](https://www.pdc.kth.se/polopoly_fs/1.767503.1600720912!/image/Scania_truck_17332-001_670pW.jpg)

PDC's largest industrial partner is Scania. The figure shows a volume rendering of the instantaneous velocity magnitude on the leeward side of a Scania R20 Highline truck at crosswind conditions. (Source: Scania)

---

# Collaboration with industry

* Business partners

    - https://www.pdc.kth.se/research/business-research/pdc-partners

* A small part of Dardel nodes will be dedicated to industry/business research.

* If you are interested in purchasing HPC compute time, contact PDC Support.

---

# Broad range of training

* Summer School

    - Introduction to HPC held every year

* Workshops (see [PDC events](https://www.pdc.kth.se/about/events))

* University Courses that use PDC systems

    - KTH courses: DD2356, DD2365, SF2568, FDD3258, ...
    - SU courses: BL4018, BL8060

---

# Support and System Staff

* First-Line Support

  - Provide specific assistance to PDC users related to accounts, login, allocations etc.

* System Staff

  - System managers/administrators ensure that computing and storage resources run smoothly and securely.

* [Application Experts](https://www.pdc.kth.se/hpc-services/application-expert-help)

  - Hold PhD degrees in various fields and specialize in HPC. Assist researchers in optimizing, scaling and enhancing scientific codes for current and next generation supercomputers.

---

<!-- paginate: true -->

![bg 90% left](https://www.pdc.kth.se/polopoly_fs/1.1053343.1614296818!/image/3D%20marketing%201%20row%20cropped%201000pW%20300ppi.jpg)

# Introduction to Dardel supercomputer

2023-04-13

[About Dardel](https://www.pdc.kth.se/hpc-services/computing-systems/about-dardel-1.1053338)

---

# Dardel is an HPE Cray EX system

* CPU partition

    - 1270 CPU nodes
    - Each node has
        + two AMD EPYC(TM) Zen2 2.25 GHz 64-core processors

* GPU partition

    - 56 GPU nodes
    - Each node has
        + one AMD EPYC(TM) processor with 64 cores
        + four AMD Instinct(TM) MI250X GPUs

---

# More about the CPU nodes

| Number of nodes | RAM per node | Name |
| --- | --- | --- |
| 736 | 256 GB | NAISS thin nodes |
| 268 | 512 GB | NAISS large nodes |
| 8 | 1024 GB | NAISS huge nodes |
| 10 | 2048 GB | NAISS giant nodes |
| 36 | 256 GB | KTH industry/business research nodes |
| 248 | 512 GB | KTH industry/business research nodes |

---

# Non-uniform memory access (NUMA)

* Memory access time depends on the relative location of memory

* Accessing local memory is faster compared to non-local memory

* On Dardel compute node: 8 NUMA domains (16 cores in each NUMA domain)
  ```
  salloc -N 1 ...
  srun -n 1 numactl --hardware
  ```

---

# Non-uniform memory access (NUMA)

```
available: 8 nodes (0-7)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 128 129 130 ... 141 142 143
node 0 size: 31620 MB
node 0 free: 30673 MB
...
node 7 cpus: 112 113 114 115 116 ... 123 124 125 126 127 240 241 242 ... 253 254 255
node 7 size: 32246 MB
node 7 free: 31375 MB
```

---

# Non-uniform memory access (NUMA)

```
node distances:
node   0   1   2   3   4   5   6   7
  0:  10  12  12  12  32  32  32  32
  1:  12  10  12  12  32  32  32  32
  2:  12  12  10  12  32  32  32  32
  3:  12  12  12  10  32  32  32  32
  4:  32  32  32  32  10  12  12  12
  5:  32  32  32  32  12  10  12  12
  6:  32  32  32  32  12  12  10  12
  7:  32  32  32  32  12  12  12  10
```

---

<!-- Section: Accounts, login, and file system -->

<!-- paginate: true -->

![bg 90% left](https://www.pdc.kth.se/polopoly_fs/1.1053343.1614296818!/image/3D%20marketing%201%20row%20cropped%201000pW%20300ppi.jpg)

# Account, Login and File System

2023-04-13

[PDC support documentation](https://www.pdc.kth.se/support)

---

# Getting a PDC account

* From [SUPR](https://supr.naiss.se/)

    - Get a SUPR account
    - Join a project with time allocation on Dardel
        - PI: create proposal for small/medium/large allocation
        - collaborators: added to project by PI
    - Request a PDC account from SUPR

* From [PDC webpage](https://www.pdc.kth.se/support/documents/getting_access/get_access.html#course-account)

    - Attend a course or training event
    - Fill in the form and provide a copy of passport or national ID

---

# Time allocation (project)

* Unit: core-hours per month

* NAISS projects are managed in SUPR.

* Course/Workshop allocations are managed locally at PDC.

* Use ``projinfo`` to list the projects that you have access to.

---

# Login

![bg right:50% width:110%](https://pdc-web.eecs.kth.se/files/support/images/login.png)

* Method 1: Use Kerberos ticket
    - [Windows: PuTTY + NIM](https://www.pdc.kth.se/support/documents/login/windows_login.html)
    - [Linux: openssh-client](https://www.pdc.kth.se/support/documents/login/linux_login.html)
    - [macOS: homebrew-openssh-gssapi](https://www.pdc.kth.se/support/documents/login/mac_login.html)

* Method 2: Use SSH keys
    - Upload your public key in [PDC login portal](https://loginportal.pdc.kth.se/)

---

# Login with Kerberos ticket

* Edit ``/etc/krb5.conf`` on Linux/macOS

* ``kinit -f <your-username>@NADA.KTH.SE``
    - use NIM on Windows
    - use ``/usr/bin/kinit -f ...`` on macOS

* ``ssh -o GSSAPIDelegateCredentials=yes -o GSSAPIKeyExchange=yes -o GSSAPIAuthentication=yes <your-username>@dardel.pdc.kth.se``
    - use PuTTY on Windows
    - you can save SSH options in ``~/.ssh/config`` on Linux/macOS

---

# Login with SSH keys

* Generate SSH key pair
  ```
  ssh-keygen -t ed25519 -f ~/.ssh/id-ed25519-pdc
  ```
  - Create ``~/.ssh`` folder if it doesn't exist
    ```
    mkdir ~/.ssh && chmod 700 ~/.ssh
    ```

* Upload SSH public key in [PDC login portal](https://loginportal.pdc.kth.se/)

* Login using SSH key
  ```
  ssh -i ~/.ssh/id-ed25519-pdc <your-username>@dardel.pdc.kth.se
  ```

---

# File System

Lustre File System (Klemming, total size 12 PB (12,000 TB))

* Open-source massively parallel distributed file system
* Optimized for handling data from many clients
* Home directory (25 GB quota, with backup)
  ```
  /cfs/klemming/home/[u]/[username]
  ```
* Project directory
  ```
  /cfs/klemming/projects/...
  ```
* Scratch directory
  ```
  /cfs/klemming/scratch/[u]/[username]
  ```

---

# Home and project directories

* Home directory
  ```
  cd && pwd
  ```
  or
  ```
  echo $HOME
  ```

* Project directory
  ```
  projinfo
  ```

---

# Groups

In addition to ``projinfo``, your groups also indicate the projects that you have access to.

```
groups
```
* groups starting with ``cac-`` are associated with compute projects
* groups starting with ``pg_`` are associated with storage projects

---

# Storage quota

```
projinfo
```

```
$HOME folder
Path: /cfs/klemming/home/u/user
Storage: ... GiB
Number of files: ...
```

```
Information for storage project: naissYYYY-X-XX (PI: ...)
...
Active from ... to ...
Members: ...
Max quota: ... GiB, ... files
Path: /cfs/klemming/projects/...
Storage: ... TiB
Number of files: ...
```

---

# Use of file system

* Good practice
  - Minimize the number of I/O operations
  - Avoid creating too many files
  - Avoid creating directories with a large numbers of files
* Bad practice
  - Small reads
  - Opening many files
  - Seeking within a file to read a small piece of data

---

# Access Control Lists

### To view the access for a folder:
```
getfacl -a /cfs/klemming/home/u/user/test
```
### The output looks like this:
```
# file: /cfs/klemming/home/u/user/test
# owner: me
# group: users
user::rwx
group::r-x
other::---
```

---

# Access Control Lists

### To grant the access to another user (use "-R" for recursive):
```
setfacl -m u:<uid>:r-x /cfs/klemming/home/u/user/test
```
### To remove the access for another user (use "-R" for recursive):
```
setfacl -x u:<uid> /cfs/klemming/home/u/user/test
```

---

<!-- Section: Using Bash shell -->

# Using Bash shell
## Introduction for beginners
### Tor Kjellsson Lindblom
---
### Content
* Bash shell and basic commands
* Files and Folders
* Input/output
* File/directory permissions
* Environment variables


### Bonus material for self-studying
* Processes (including programs)
* Searching in text
* Finding files
* Hotkeys
* File archiving

---
### What is a shell?
* What you get when the terminal window is open

* A "layer" (shell) around the operating system

* **Frequently used to interact with remote systems, such as Dardel**

* Multiple types of shells exist - this is about **bash shell**

* This presentation contains the very basics with hands-on exercises and type-alongs.

* **No need to finish all exercises now**.

---
### Getting a bash shell
* Linux and Mac users - just open a terminal window (or login to Dardel)
* Windows users - please login to Dardel.
---
### Your very first commands (type along)
Explore the following commands, one at a time.

```
pwd                 (print work directory)
ls                  (list files)
ls -l               (+ extra flag)
mkdir bash_tutorial (create directory)
cd bash_tutorial    (change directory)
cd ..               (cd one step above current directory)
wget  https://swcarpentry.github.io/shell-novice/data/shell-lesson-data.zip (download file from specified location)
unzip shell-lesson-data.zip
```
The last two lines downloads and extracts tutorial material we have borrowed from Software Carpentry
https://carpentries.org/

---
### Exercise 1 (3 min)
```
$ ls -l shell-lesson-data
* Move back and forth into the subdirectories
* Move into exercise-data and type
$ cp numbers.txt numbers_copy.txt
```
verify that the new file was created.
 **NB! Do not use whitespace in file/folder names.**

```
* Create a new directory with some name. Then type:
$ mv numbers_copy.txt your_new_folder/.
* what happened?
```
---
### Exercise 2: Some more commands (5 min)

```
cp -r dir1 dir2   (copy directory, NB "-r")
man ls            (prints manual for ls)
rm file_example   (remove file_example (careful! can not be undone))
history           (prints command line history)
cat file_example  (print all contents of file)
less file_example (view contents of file in pager)
head file_example (print first lines of file)
tail file_example (print last lines of file)

* Copy an existing directory
* Display "numbers_copy.txt" in some way
* Print your command line history
* Open manual for the command ls and then
- press up/down keys to scroll
- Type / to start search mode
- Search for the flag: -F
- Type q to quit
```
---
### Relative vs. absolute paths
You can specify a location in two ways:

```
(Relative)            
cd exercise_data    

(Absolute)
cd /home/tkl/shell-lesson-data/exercise-data
```
Both ways are useful. Determine which is best for the situation at hand.

---

### Text editors
Very good idea to master at least one (non-graphical) editor in the terminal.

List of common editors:

* nano - easiest, minimal functionality
* vi/vim - a bit more involved, but more functionality
* emacs - even a bit more involved, but a lot of functionality
* HOMEWORK: get used to one text editor.
---

### Input & Output: redirect and pipes
* Programs can display something, e.g. **echo hello world**

* Programs can take input, e.g. **less**

* $ cat numbers_copy.txt

* $ cat numbers_copy.txt | less

---
### Try it: pipes (3 min)
```
# what sessions are logged in?
$ w

# count number of sessions
$ w -h | wc -l

# list all matching commands
$ history | grep -w 'ls'

# print the name of the newest file in the directory (non-dot)
$ ls -1tF | grep -v -E '*/|@' | head -1

```
---
### Redirects
* Like pipes, but data is sent to/from files and not processes

* Replace a file:

* $ command > file.txt

* Append to a file:

* $ command >> file.txt (be careful to **not** mix them up!)

* Redirect file as STDIN:

* command < file (in case program accepts STDIN only)

---
### Try it: Redirects (3 min)
```
$ echo Hello World > hello.txt

$ ls -lH >> current_dir_ls.txt

# join two files (e.g. the two above) into one
$ cat file1 file2 > file3

# go through file1 and replace spaces with a new line mark, then output to file2
$ tr -s ' ' '\n' < file1 > file2

# -or- in more readable format
$ cat file1 | tr -s ' ' '\n' > file2
```
---
### File/directory permissions
#### The basics
Important to set access permission on shared objects

```
Example
$ ls -l exercise_data

drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 proteins
-rw-rw-r-- 1 tkl tkl   13 sep 16  2021 numbers.txt
drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 animal-counts
drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 creatures
drwxrwxr-x 2 tkl tkl 4096 sep 28 12:23 writing

```
Tell you who can: **r**ead, **w**rite and e**x**ecute a file/list a directory

*d* is for directory - then 3 groups of triple fields: user, group, others

---
#### Basic file permission manipulation
```
chmod u+rwx fileA      (add read, write, execute rights to fileA for user)

chmod o+r fileA        (add read permission for others)       

chmod o-wx fileA       (remove write and execectue for others)

chmod -R <perms> <dir> (recursively apply permission changes on all of dir)

chgrp group_name fileA (change group ownership)

chown -R folder        (Change owner of folder)

```
**NB: On Dardel, we also use ACLs (next slide)**

---
#### Access control lists (ACLs)
```
* On Lustre (Klemming) we use more advanced access permissions.

* Normal unix permission have only one owner and group.
 With ACLs, this restriction is lifted.

* ACLs are controlled via getfacl and setfacl.

$ getfacl file                   (get current stage)
$ setfacl -m u:<user>:r file    (Allow read access for user)
```

In many support cases we ask users to apply the last line so we can access files.

---
### Environment variables
Defined text strings that your programs may use

```
* In the shell, these variables define your environment
* Common practice: capital letters, e.g. $HOME, $PATH, $OMP_NUM_THREADS
* List all defined variables with printenv

Try it:
$ echo $HOME
$ echo $HOSTNAME
$ echo $PATH
```

---
## Bonus material
* Processes (including Programs)
* Initialization and configuration
* Finding files and text patterns within files
* Hotkeys
* File archiving

 [Jump to next section](#68)

 ---
 ### Processes [bonus slide]
 Uptil now we only discussed files/folders.
 But we also want to run **programs.**
 * All running programs and commands are *processes*
 * Processes have:
   * Process ID, NAME, Command line arguments
   * input and output, Return code (integer) when complete
   * Working directory, Environment variables
 * These concepts bind together all UNIX programs
 * To see some runnings processes, type *top*

 ---
 ### Foreground and background processes [bonus slide]

 **Foreground**

  * Example: *top*
  * Keyboard is connected as input, screen to output.
  * Only one such process active at a time.
  * Kill it: Ctrl-c

 **Background**
  * No input connected
  * You can have as many as resources allow
  * Add an *&* after a command to put it in background
  * To kill: use *kill* or *pkill*, or do it from within *top*

 ---
 ### Foreground and background processes [bonus slide cont]

  ```
  Example:
  ./my_prog.ex
  ./my_prog.ex 1> output.txt 2>error.txt &

  ```

 **NB: You will most likely not use Dardel like this, but it is possible to do so by logging into a compute node.**


---
### Exercise: some more redirects [bonus slide]
```
* Step into the data-shell folder
* Type history
* Type history > history.txt
* Type ls -l and then check time stamp of history.txt
* Print the last 4 lines of history.txt using the tail command
(explore the manpage if needed)
* Instead of creating an intermediate file, find a more clever
way to print the last 4 commands by piping history into tail
```
---
### Initialization and configuration [bonus slide]
* When the shell first starts (e.g. at login) it reads shell config files.

* The config files give you power to customize your shell to your liking.

* You can always manually test things in an open shell before putting it in the config files (recommended!)

Config files are located in $HOME and are called:

 * .bashrc
 * .bash_profile

---
#### Example to try [bonus slide]
```
* Try to customize your shell to your liking. It can for instance be
- define some environmental you will often used
- get certain color scheme
- get date and time information when typing the command history
```

---

### Findings patterns in files: grep  [bonus slide]
This command is for searching keyword inside files.

```
grep <pattern> <filename>  # grep lines that match <pattern>
 -or-
command | grep <pattern>  # grep lines from stdin

```
---
### Exercise 5 [grep]  [bonus slide]
```
* Go back to the data-shell directory
* Type grep rabbit exercise-data/animal-counts/animals.csv
* Try finding all occurences of the string “rabbit” using
recursive search (adding the -R flag)

grep + pipes:
* Make a pipe that displays all files ending with "pdb" in the
 data-shell directory.

```
---


### Finding things [bonus slide]
Command: *find*

```
# search for pentane.pdb in current directory
find . -name pentane.pdb

# one can search more than one dir at once
find . /cfs/klemming/nobackup/u/username -name pentane.pdb

```

---
### Exercise 5 [bonus slide]

Bonus (for interested to do later):

* On a Lustre system, *lfs find* is faster. Same syntax.

* On a workstation: *locate* may be useful. Read manual for information.


* Type find . -name animals.csv.

* Type find . -name *.pdb

* Make a pipe that counts number of files/directories in the
 data-shell directory.

* Count unique logged in users on Dardel.

Tip: **w** or **users** give you a list of all currently login users,
many of them have several sessions open.

Tip: You may have to use **uniq**, **tr -s**, **cut -f 1 -d " "**, and **wc -l**

---

### Hotkeys [bonus slide]
* Shortcuts
* Most important key: **tab** for autocompletion
* You should never type full filenames or command names - **tab** can complete almost anything.

---
Some common commands
```
TAB            (autocompletion)
Home/Ctrl-a    (move to start of command line)
End/Ctrl-e     (move to end)
up/down        (traverse command history)
Ctrl-l         (clear the screen)
Ctrl-Shift-c   (copy)
Ctrl-Shift-v   (paste)
Ctrl-r         (command history search: backwards)

```
---
### Exercise 6 [bonus slide]
#### TAB autocompletion

We will here display contents of a file using its full path, but try to type as few characters as possible.

First find your absolute path to "numbers.txt"
```
* Type find $HOME -name numbers.text
Say the path was /home/tkl/shell-lesson-data/exercise-data/numbers.txt

* Type cat /home/tk and then start hitting TAB.
 Add characters when needed to reach full path.
(use your own path)
```


---
### File archiving [bonus slide]
```
# create tar archive gzipped on the way
tar -caf archive_name.tar.gz dir/

# extract files
tar -xaf archive_name.tar.gz -C /path/to/directory
```

* *tar* is the standard tool to save many files or directories into a single archive
* Archive files may have extensions .tar, .tar.gz etc depending on compression used.
* "f" is for filename, "a" selects compression based on suffix
* With no compression, files are simply packed
* "r" will append files to end of archive, "t" will list archive
* Individual files can be compressed directly with e.g. gzip. (gzip file, gunzip file.gz)

---
### Exercise 7 [bonus slide]
```
* Make a tar.gz archive of shell-lesson-data
* Make a tar archive, compare sizes
* List the files inside the archive
```
---

<!-- Section: Compiling and running code on CPU nodes -->

# Compiling and running code on CPU nodes

### Xin Li

---

# Cray programming environment (CPE)

Reference page: [Compilers and libraries](https://www.pdc.kth.se/support/documents/software_development/development.html)

The Cray Programming Environment (CPE) provides consistent interface to multiple compilers and libraries.

* In practice, we recommend
    - ``ml cpeCray/23.12``
    - ``ml cpeGNU/23.12``
    - ``ml cpeAOCC/23.12``

* The ``cpeCray``, ``cpeGNU`` and ``cpeAOCC`` modules are available after ``ml PDC/23.12``

* No need to ``module swap`` or ``module unload``

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

# Compile a simple MPI code

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

Use cray-libsci

```
ml PDC/23.12 cpeGNU/23.12
```

```
cc dgemm_test.c -o dgemm_test_craylibsci.x
```

---

# Compile a simple linear algebra code

Use openblas

```
ml PDC/23.12 openblas/0.3.28-cpeGNU-23.12
```

```
cc dgemm_test.c -o dgemm_test_openblas.x -I$EBROOTOPENBLAS/include -L$EBROOTOPENBLAS/lib -lopenblas
```
where the environment variable `EBROOTOPENBLAS` had been set when loading the OpenBLAS module. Its module file includes a statement
```
setenv("EBROOTOPENBLAS","/pdc/software/23.12/eb/software/openblas/0.3.28-cpeGNU-23.12")
```
which corresponds to an export statement
```
export EBROOTOPENBLAS=/pdc/software/23.12/eb/software/openblas/0.3.28-cpeGNU-23.12
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
libopenblas.so.0 => /pdc/software/23.12/eb/software/openblas/0.3.28-cpeGNU-23.12/lib/libopenblas.so.0
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
ml cray-fftw/3.3.10.6

wget https://people.math.sc.edu/Burkardt/c_src/fftw/fftw_test.c

cc --version
cc fftw_test.c -o fftw_test.x

ldd fftw_test.x

salloc -n 1 -t 10 -p shared -A <name-of-allocation>
srun -n 1 ./fftw_test.x
```

---

# Compilation of large program

* Examples at https://www.pdc.kth.se/software

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
ml show elpa/2023.05.001-cpeGNU-23.12
```

```
whatis("Description: ELPA - Eigenvalue SoLvers for Petaflop-Applications")
prepend_path("CMAKE_PREFIX_PATH","/pdc/software/23.12/eb/software/elpa/2023.05.001-cpeGNU-23.12")
prepend_path("LD_LIBRARY_PATH","/pdc/software/23.12/eb/software/elpa/2023.05.001-cpeGNU-23.12/lib")
prepend_path("LIBRARY_PATH","/pdc/software/23.12/eb/software/elpa/2023.05.001-cpeGNU-23.12/lib")
prepend_path("PATH","/pdc/software/23.12/eb/software/elpa/2023.05.001-cpeGNU-23.12/bin")
prepend_path("PKG_CONFIG_PATH","/pdc/software/23.12/eb/software/elpa/2023.05.001-cpeGNU-23.12/lib/pkgconfig")
...
```

---

# When running your own code

* Load correct programming environment (e.g. ``cpeGNU``)
* Load correct dependencies (e.g. ``openblas`` if your code depends on it)
* Properly prepend to environment variables (e.g. ``PATH``, ``LD_LIBRARY_PATH``)
* Choose correct SLURM settings

---

# SLURM settings for hybrid MPI/OpenMP code

* ``--nodes`` number of nodes
* ``--ntasks-per-node`` number of MPI processes
* ``--cpus-per-task`` 2 x number of OpenMP threads (because of SMT)

* ``OMP_NUM_THREADS`` number of OpenMP threads
* ``OMP_PLACES`` cores

---

# Example job script

* 64 MPI x 2 OMP per node (main parition)
  ```
  #!/bin/bash

  #SBATCH -A ...
  #SBATCH -J my_job
  #SBATCH -t 01:00:00
  #SBATCH -p main

  #SBATCH --nodes=2
  #SBATCH --ntasks-per-node=64
  #SBATCH --cpus-per-task=4

  module load ...

  export OMP_NUM_THREADS=2
  export OMP_PLACES=cores

  srun ...
  ```

---

# Example job script

* 2 MPI x 2 OMP per node (shared partition)
  ```
  #!/bin/bash

  #SBATCH -A ...
  #SBATCH -J my_job
  #SBATCH -t 01:00:00
  #SBATCH -p shared

  #SBATCH --ntasks=2
  #SBATCH --cpus-per-task=4

  module load ...

  export OMP_NUM_THREADS=2
  export OMP_PLACES=cores

  srun ...
  ```

---

# Exercise: Hybrid MPI/OpenMP code for matrix-matrix multiplication

* Preparation

  ```
  mkdir -p matmul_test && cd matmul_test
  ```

* Copy python code [matmul_mpi_omp_test.py](https://github.com/PDC-support/pdc-intro/blob/master/COMPILE_exercises/matmul_mpi_omp_test.py) to the same folder

---

# Exercise: Hybrid MPI/OpenMP code for matrix-matrix multiplication

* Copy job script [job-n1.sh](https://github.com/PDC-support/pdc-intro/blob/master/COMPILE_exercises/job-n1.sh)
    - for running on 1 MPI processes with different number of OpenMP threads

* Copy job script [job-n2.sh](https://github.com/PDC-support/pdc-intro/blob/master/COMPILE_exercises/job-n2.sh)
    - for running on 2 MPI processes with different number of OpenMP threads

* Submit two jobs

---

# Exercise: Hybrid MPI/OpenMP code for matrix-matrix multiplication

* Result

  | Setting | Timing |
  | --- | --- |
  | 1 MPI x 16 OMP | Time spent in matmul: 2.307 sec|
  | 1 MPI x  8 OMP | Time spent in matmul: 3.924 sec|
  | 1 MPI x  4 OMP | Time spent in matmul: 6.626 sec|
  | 2 MPI x  8 OMP | Time spent in matmul: 2.034 sec|
  | 2 MPI x  4 OMP | Time spent in matmul: 3.287 sec|
  | 2 MPI x  2 OMP | Time spent in matmul: 6.188 sec|
---

<!-- Section: Job script for efficient utilization of hardware -->

# Running jobs with efficient utilization of hardware

### Xavier Aguilar

---

# How do we run jobs on a Supercomputer?

![bg right:60% width:100%](https://pdc-web.eecs.kth.se/files/support/images/LoginNodeWarning.PNG)

* Edit files
* Compile programs
* Run light tasks
* Submit jobs
* **Do not** run parallel jobs on the login node!


---
# What is SLURM ?
## Simple Linux Utility for Resource Management

* Open source, fault-tolerant, and highly scalable cluster management and job scheduling system
  - Allocates access to resources
  - Provides a framework for work monitoring on the set of allocated nodes
  - Arbitrates contention for resources
---

# Types of jobs?

* **Batch jobs**
  - the user writes a job script indicating the number of nodes, cores, time needed, etc.
  - the script is submitted to the batch queue
  - The user retrieves the output files once the job is finished
* **Interactive jobs:**
  - the user runs a command that allocates interactive resources on a number of cores
  - this creates an interactive job that awaits in the queue as any other job
  - when the job reaches the front of the queue, the user gets access to the resources and can run commands there

---

# How jobs are scheduled?

* **Age**: the time the job has been in the queue
* **Job size**: number of nodes or cores requested
* **Partition**: a factor associated with each node partition
* **Fair-share**: the difference between the computing resources promissed and the amount of resources computed


---

# SLURM basic commands

### Submit a job to the queue:
```
sbatch <script>
```

### List queued/running jobs belonging to a user:
```
squeue -u <username>
```

### Cancel a job:
```
scancel <job-id>
```

### Get information on partitions and nodes
```
sinfo
```
---

# Job scripts (pure MPI)

```
#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A snicYYYY-X-XX

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p main

# 10 hours wall-clock time will be given to this job
#SBATCH -t 10:00:00

# Number of nodes
#SBATCH --nodes=4

# Number of MPI processes per node
#SBATCH --ntasks-per-node=128

# Loading modules needed by your job
module add X
module add Y

# Run the executable named myexe
# and write the output into my_output_file
srun ./myexe > my_output_file
```

---

# Partitions

* Nodes are logically grouped into partitions
* There are several partitions that can be used on Dardel
  - **main**: Thin nodes (256 GB RAM), whole nodes, maximum 24 hours job time
  - **long**: Thin nodes (256 GB RAM), whole nodes, maximum 7 days job time
  - **shared**: Thin nodes (256 GB RAM), job shares node with other jobs, maximum 24 hours job time
  - **memory**: Large/Huge/Giant nodes (512 GB - 2 TB RAM), whole nodes, 24 hours job time
  - **gpu**: GPU nodes, 512 GB RAM, and 4 AMD MI250X GPU cards

---

# Job scripts (MPI + OpenMP)

```
#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
#SBATCH -A snicYYYY-X-XX

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p main

# 10 hours wall-clock time will be given to this job
#SBATCH -t 10:00:00

# Number of Nodes
#SBATCH --nodes=4

# Number of MPI tasks per node
#SBATCH --ntasks-per-node=16
# Number of logical cores hosting OpenMP threads. Note that cpus-per-task is set as 2x OMP_NUM_THREADS
#SBATCH --cpus-per-task=16

# Number and placement of OpenMP threads
export OMP_NUM_THREADS=8
export OMP_PLACES=cores

# Run the executable named myexe
srun ./myexe > my_output_file
```


---

# Interactive jobs

Request an interactive allocation
```
salloc -A <allocation> -t <d-hh:mm:ss> -p <partition> -N <nodes> -n <cores>
```

Once the allocation is granted, a new terminal session starts (typing exit will stop the interactive session)
```
srun -n <number-of-processes> ./mybinary.x
```
It is also possible to ssh into one of the allocated nodes.

---

# Interactive jobs

We can check what nodes have been granted with:

  ```
  squeue -u $USER
  ```

  or inspecting the environment variable:
  ```
  SLURM_NODELIST
  ```

---

# Exercise 1: Basic SLURM commands

* In this exercise we are going to test some basic SLURM commands.

* You will:
   - Create and compile a simple MPI program
   - Submit it to the queues
   - Inspect the queues
   - Inspect the partitions
   - Check the output of the job


---

# MPI Hello world

```c
#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
  int world_size,world_rank;

  // Initialize the MPI environment
  MPI_Init(NULL, NULL);
  // Get the number of processes
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);
  // Get the rank of the process
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
  // Print off a hello world message
  printf("Hello world from rank %d out of %d process\n", world_rank, world_size);
  // Finalize the MPI environment.
  MPI_Finalize();
  return 0;
  }
```

---

# Exercise 1

* You can find the code from the previous slide [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/hello_mpi.c)

* Save the file on Dardel, compile the code and generate a binary called *hello_mpi.x*

---



# Exercise 1

* Take the job script that you can find [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/exercise1.sh) and modify it accordingly to:
   - Use one node for the job
   - Use 4 cores from that node


---

# Exercise 1

* Submit this script using **sbatch**

* Check the queue using **squeue -u <your_username>**
   - What's the ID of the job?
   - Is it already running? If so, which node was allocated for the job?

* Once the job finishes check the job output. Where is it saved?

---

**Note**:

Notice that we run our program with just:

```
srun ./hello_mpi.x
````

It would be also possible to run our program with:
```
srun -N 1 -n 4 ./hello_mpi.x
```

However, we don't need to specify those flags because SLURM takes the *-N* and *-n* values from the *BATCH* directives in the script

---

# Exercise 1

* Use **sinfo** to check the partitions
  - How many different partitions are defined? What are their names?
  - What's the partition with the highest number of nodes?
  - Name 1-2 nodes included in that same partition


---

# SLURM advanced commands

<!-- ### To get further information about a job:
```
scontrol show job <jobid>
```
-->

### Get detailed information of a running job:
```
sstat --jobs=<your_job-id>
```

### Filter the information provided by sstat
```
sstat --jobs=your_job-id --format=JobID,aveCPU,MaxRRS,NTasks
```

**Tip:** Use *sstat -e* to see all possible fields for the *format* flag

---

# SLURM advanced commands

### To get information on past jobs:
```
sacct
```

### Get detailed information of a certain job:
```
sacct --jobs=<your_job-id> --starttime=YYYY-MM-DD
```
```
sacct --starttime=2019-06-23 --format=JobName,CPUTime,NNodes,MaxRSS,Elapsed
```

---

# SLURM advanced commands

### Quick performance summary for a finished job:
```
seff <jobid>
```

---

# Common reasons for inefficient jobs

* Not all nodes allocated are used
* Not all cores within a node are used (if it's not intentional)
* Many more cores than the available are used
* Inefficient use of the file system

---

# Exercise 2

* In this exercise we are going to use some more advanced SLURM commands to explore job performance.

* You will:
   - Create and compile a simple MPI program
   - Submit it to the queues
   - Check job data using sacct


---

# Exercise 2

* You can find the sample code for this exercise [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/vector_mpi.c)

* Compile the code and generate a binary called *vector_mpi.x*

---


# Exercise 2

* You can find the job script for this exercise [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/exercise-2.sh)

* Save the script on Dardel and submit the job. Once the job finishes check its output.

* Inspect the job performance data using **sacct**
   - Use: -j <job-id> --format=JobID,JobName,Elapsed,ReqMem,MaxRSS

     **Tip**: use flag "--unit=M" to see memory units in MB

---

# Exercise 2

* Use the **seff <job-id>** command for quick job efficiency overview.  

   ```
   Job ID: 211499
   Cluster: dardel
   User/Group: xaguilar/xaguilar
   State: COMPLETED (exit code 0)
   Nodes: 1
   Cores per node: 8
   CPU Utilized: 00:00:01
   CPU Efficiency: 0.37% of 00:04:32 core-walltime
   Job Wall-clock time: 00:00:34
   Memory Utilized: 549.25 MB (estimated maximum)
   Memory Efficiency: 7.73% of 6.94 GB (888.00 MB/core)
   ```


---

# SLURM good practices

* Avoid too many short jobs
* Avoid massive output to STDOUT
* Try to provide a good estimate of the job duration before submitting

---

# Packing short jobs

Several short jobs can be packed together into a single job where they run serially

```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:10:00

for arg in "$@"; do
        srun -n 1 myprog $arg
done
```

The job is submitted with:
```
sbatch packed_job.sh x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
```

---
# Using fewer cores

Reduce the number of cores used per job and run multiple instances of the job in a single node

```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:01:00

export OMP_NUM_THREADS=32

srun myprog $1
```

---

# Using fewer cores

```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:08:00

export OMP_NUM_THREADS=4

srun ./inner.sh "$@"
```

```
#!/bin/bash

for arg in "$@"; do
        myprog $arg &
done

wait
```

---
---

<!-- Section: Using ThinLinc -->

# Using ThinLinc

### Mustafa Arif

Link to download the slides: [ThinLinc_Tutorial.pdf](https://github.com/PDC-support/pdc-intro/raw/master/episodes/pdf-files/ThinLinc_Tutorial.pdf)

---

<!-- Section: Compiling and running code on GPU nodes -->

# Compiling and running code on GPU nodes

### Johan Hellsvik

Reference pages:
[Building for AMD GPUs](https://www.pdc.kth.se/support/documents/software_development/development_gpu.html)
[Introduction to GPUs course, September and October 2023](https://github.com/PDC-support/introduction-to-gpu)

---

# Generalized programming for GPUs

Central processing units (CPU) and graphics processing units (GPU) do different work

- CPUs have large instruction sets and execute general code.

- GPUs have smaller instructions sets. Runs compute intensive work in parallel on large number of compute units (CU).

- Code execution is started and controlled from the CPU. Compute intensive work is offloaded to the GPU.

---

# Dardel GPU nodes

Dardel has 56 GPU nodes, each of which is equipped with

- One AMD EPYC™ processor with 64 cores

- 512 GB of shared fast HBM2E memory

- Four AMD Instinct™ MI250X GPUs (with an impressive performance of up to 95.7 TFLOPS in double precision when using special matrix operations)

![bg right:45% width:100%](https://www.pdc.kth.se/polopoly_fs/1.1242679.1679986622!/image/MI200_hpc_architecture_1000pW_heading_cut.png)

---

# AMD Radeon Open Compute (ROCm)

The AMD Radeon Open Compute (ROCm) platform is a software stack for programming and running of programs on GPUs.

- The ROCm platform supports different programming models
    - Heterogeneous interface for portability (HIP)
    - Offloading to GPU with OpenMP directives
    - The SYCL programming model

- [AMD ROCm Information Portal](https://rocm.docs.amd.com/en/latest/)

---

# Setting up a GPU build environment

- Load the PDC/23.12 module and version 5.7.0 of ROCm with
    - ``ml PDC/23.12``
    - ``ml rocm/5.7.0``

- Set the accelerator target to **amd-gfx90a** (AMD MI250X GPU)
    - ``ml craype-accel-amd-gfx90a``

- Choose one of the available toolchains (Cray, Gnu, AOCC)
    - ``ml cpeCray/23.12``
    - ``ml cpeGNU/23.12``
    - ``ml cpeAOCC/23.12``

---

## The ROCM info command

Information on the available GPU hardware can be displayed with the ``rocminfo`` command. Example output (truncated)

```
ROCk module is loaded
=====================
HSA System Attributes
=====================
Runtime Version:         1.1
System Timestamp Freq.:  1000.000000MHz

==========
HSA Agents
==========
*******
Agent 1
*******
  Name:                    AMD EPYC 7A53 64-Core Processor
  Uuid:                    CPU-XX
```

---

## The CRAY_ACC_DEBUG runtime environment variable

For executables that are built with the compilers of the Cray Compiler Environment (CCE), verbose runtime information can be enabled with the environment variable ``CRAY_ACC_DEBUG`` which takes values 1, 2 or 3.

For the highest level of information

``export CRAY_ACC_DEBUG=3``

---

# Offloading to GPU with HIP

The heterogeneous interface for portability (HIP) is a hardware close (low level) programming model for GPUs. Example lines of code:

- Include statement for the HIP runtime

```
#include <hip/hip_runtime.h>
```

- HIP functions have names starting with ``hip``

```
// Get number of GPUs available
if (hipGetDeviceCount(&ndevices) != hipSuccess) {
    printf("No such devices\n");
    return 1;
    } 
printf("You can access GPU devices: 0-%d\n", (ndevices - 1));
```

---

- Explicit handling of memory on the GPU

```
// Allocate memory on device
hipMalloc(&devs1, size);
hipMalloc(&devs2, size);
// Copy data host -> device
hipMemcpy(devs1, hosts1, size, hipMemcpyHostToDevice);

```

- Call to run the compute kernel on the GPU

```
// Run kernel
hipLaunchKernelGGL(MyKernel, ngrid, nblock, 0, 0, devs1, devs2);
```

---

# Offloading to GPU with OpenMP

The OpenMP programming model can be used for directive based offloading to GPUs.

Example: A serial code that operates on arrays ``vecA``, ``vecB``, and ``vecC``

```
! Dot product of two vectors
do i = 1, nx
   vecC(i) =  vecA(i) * vecB(i)
end do
```

Implement OpenMP offloading by inserting OpenMP directives. In Fortran the directives starts with ``!$omp``

```
! Dot product of two vectors
!$omp target teams distribute map(from:vecC) map(to:vecA,vecB)
do i = 1, nx
   vecC(i) =  vecA(i) * vecB(i)
end do
!$omp end target teams distribute
```

---

# Exercise 1: Hello world with HIP

Build and test run a Hello World C++ code which offloads to GPU via HIP.

- Download the [source code](https://raw.githubusercontent.com/PDC-support/introduction-to-pdc/master/example/hello_world_gpu.cpp)
   - ``wget https://raw.githubusercontent.com/PDC-support/introduction-to-pdc/master/example/hello_world_gpu.cpp``

- Load the ROCm module and set the accelerator target to amd-gfx90a (AMD MI250X GPU)
   - ``ml rocm/5.7.0``
   - ``ml craype-accel-amd-gfx90a``

- Compile the code with the AMD hipcc compiler on the login node
   - ``hipcc --offload-arch=gfx90a hello_world_gpu.cpp -o hello_world_gpu.x``

---

## Run the code as a batch job

- Edit [job_gpu_helloworld.sh](https://github.com/PDC-support/pdc-intro/blob/master/COMPILE_exercises/job_gpu_helloworld.sh) to specify the compute project and reservation

- Submit the script with ``sbatch job_gpu_helloworld.sh``

with program output written to ``output.txt``

```
You can access GPU devices: 0-7
GPU 0: hello world```
...
```

---

# Exercise 2: Dot product with OpenMP

Build and test run a Fortran program that calculates the dot product of vectors.

- Activate the PrgEnv-cray environment ``ml PrgEnv-cray``

- Download the [source code](https://github.com/ENCCS/openmp-gpu/raw/main/content/exercise/ex04/solution/ex04.F90)
    - ``wget https://github.com/ENCCS/openmp-gpu/raw/main/content/exercise/ex04/solution/ex04.F90``

- Load the ROCm module and set the accelerator target to amd-gfx90a
    - ``ml rocm/5.7.0 craype-accel-amd-gfx90a``

- Compile the code on the login node
    - ``ftn -fopenmp ex04.F90 -o ex04.x``

---

## Run the code as a batch job

- Edit [job_gpu_ex04.sh](https://github.com/PDC-support/pdc-intro/blob/master/COMPILE_exercises/job_gpu_ex04.sh) to specify the compute project and reservation

- Submit the script with ``sbatch job_gpu_ex04.sh``

- with program output ``The sum is:  1.25`` written to ``output.txt``

---

## Optionally, test the code in interactive session.

- First queue to get one GPU node reserved for 10 minutes

    - ``salloc -N 1 -t 0:10:00 -A <project name> -p gpu``

- wait for a node, then run the program ``srun -n 1 ./ex04.x``

- with program output to standard out ``The sum is:  1.25``

---

- Alternatively, login to the reserved GPU node (here nid002792) ``ssh nid002792``.

- Load ROCm, activate verbose runtime information, and run the program
    - ``ml rocm/5.7.0``
    - ``export CRAY_ACC_DEBUG=3``
    - ``./ex04.x``

- with program output to standard out

```
ACC: Version 5.0 of HIP already initialized, runtime version 50013601
ACC: Get Device 0
...
...
ACC: End transfer (to acc 0 bytes, to host 4 bytes)
ACC:
The sum is:  1.25
ACC: __tgt_unregister_lib
```
---

<!-- Section: Using Singularity -->

# Using Singularity

### Henric Zazzi

Link to download the slides: [singularity.pdf](https://github.com/PDC-support/pdc-intro/raw/master/episodes/pdf-files/singularity.pdf)

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


---

<!-- Section: Materials theory codes -->

# Materials theory codes on Dardel

### Johan Hellsvik


Reference page: [Available software](https://www.pdc.kth.se/software)

---

## Types of computer codes for materials theory modelling
  - Density functional theory (DFT) programs. Often with the DFT extended with for instance dynamical mean field theory (DMFT), GW, hybrid functionals.
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
ml PDC/23.12 # Load the PDC/23.12 module
ml av vasp # List all VASP modules in PDC/23.12
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
ml PDC/23.12
ml abinit/10.0.5-cpeGNU-23.12
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
ml PDC/23.12 elk/9.5.14-cpeGNU-23.12
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

- For maintaining and installing (new versions) of materials theory codes on Dardel, we are mainly using the EasyBuild system. To build Elk 9.5.14 under CPE 23.12, load and launch an EasyBuild with

```
ml PDC/23.12 easybuild-user/4.9.2
eb elk-9.5.14-cpeGNU-23.12.eb --robot
```

- A program that has been EasyBuilt and installed on Dardel can (often) be straightforwardly ported to a build configuration for LUMI. Or vice versa, a build on LUMI can be ported for Dardel. The easyconfig build configuration for Elk on Dardel has been ported to LUMI. See and compare the easyconfigs

  - Dardel [elk-9.5.14-cpeGNU-23.12.eb](https://github.com/PDC-support/PDC-SoftwareStack/blob/master/easybuild/easyconfigs/e/elk-9.5.14-cpeGNU-23.12.eb)
  - LUMI [Elk-8.7.10-cpeGNU-22.12.eb](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/blob/main/easybuild/easyconfigs/e/Elk/Elk-8.7.10-cpeGNU-22.12.eb)

Reference page: [Installing software using EasyBuild](https://www.pdc.kth.se/support/documents/software_development/easybuild.html)

---

# Other DFT codes available on Dardel (selected)

- [The Relativistic Spin Polarized tookit (RSPt)](https://www.pdc.kth.se/software/software/RSPt/index_general.html), a code for electronic structure calculations based on the Full-Potential Linear Muffin-Tin Orbital (FP-LMTO) method.

- The [Quantum ESPRESSO](https://www.pdc.kth.se/software/software/Quantum-ESPRESSO/index_general.html) integrated suite of open-source computer codes for electronic-structure calculations and materials modeling at the nanoscale

- [CP2K](https://www.pdc.kth.se/software/software/cp2k/index_general.html), a program to perform atomistic and molecular simulations of solid state, liquid, molecular, and biological systems.

---

# Materials theory codes available on Dardel via Spack

Some codes can be built and installed in your own file area using Spack. Load a Spack user module with `ml PDC/23.12 spack-user/0.21.2`.

Examples of Spack specs for building on Dardel
- Siesta `spack install siesta@4.0.2%gcc@12.3.0`
- Sirius `spack install sirius@7.4.3%gcc@12.3.0 ^spla@1.5.5%cce@15.0.1`
- BerkeleyGW `spack install berkeleygw@3.0.1%gcc@12.3.0`
- Yambo `spack install yambo@5.1.1%gcc@12.3.0 +dp +openmp`
- BigDFT `spack install bigdft-core@1.9.2%gcc@12.3.0`

Reference page: [Installing software using Spack](https://www.pdc.kth.se/support/documents/software_development/spack.html)

---

# Other materials theory programs and tools

- The [Spglib](https://www.pdc.kth.se/software/software/Spglib/index_general.html) library for finding and handling crystal symmetries
- The [Uppsala Atomistic Spin Dynamics (UppASD)](https://www.pdc.kth.se/software/software/UppASD/index_general.html) software package, a simulation suite to study magnetization dynamics by means of the atomistic version of the Landau-Lifshitz-Gilbert (LLG) equation.
- The [Wannier90](https://www.pdc.kth.se/software/software/Wannier90/index_general.html) open-source code for generating maximally-localized Wannier functions and using them to compute advanced electronic properties of materials with high efficiency and accuracy.
- Phonopy for modelling of phonons `spack install py-phonopy@1.10.0%gcc@12.3.0`

---

# Exercise 1: Run a DFT simulation with ABINIT

Perform a calculation on two Dardel CPU compute nodes with the ABINIT package for modeling of condensed matter. The example calculation is a DFT simulation of the properties of the material SrVO3.


Exercise instructions: See [Submit a batch job to the queue](https://www.pdc.kth.se/support/documents/basics/quickstart.html#submit-a-batch-job-to-the-queue) and scroll down to the heading *Example 2: Submit a batch job to queue for a center installed software*

---

# Exercise 2: Build the most recent version of Elk

As of 20240320, the most recent version of Elk globally installed on Dardel is 9.5.14. How to build and make local intall of the newer version 10.0.15?

- First make a local installation of Elk 9.5.14. Why is the `--rebuild` flag needed?

```
ml PDC/23.12 easybuild-user/4.8.2
eb elk-9.5.14-cpeGNU-23.12.eb --robot --rebuild
```

- Use the easyfonfig `elk-9.5.14-cpeGNU-23.12.eb` as a template to construct a file `elk-10.0.15-cpeGNU-23.12.eb`. Then build and install locally with `eb elk-10.0.15-cpeGNU-23.12.eb --robot`.

Reference page: [Installing software using EasyBuild](https://www.pdc.kth.se/support/documents/software_development/easybuild.html)

---

# Exercise 3: Calculate the magnetic phase diagram of bcc Fe with UppASD

[UppASD](https://www.pdc.kth.se/software/software/UppASD/index_general.html) is a program for simulating atomistic spin dynamics at finite temperatures, which makes it possible to describe magnetization dynamics on an atomic level. Magnetic phase diagrams and thermodynamical properties of a magnetic Hamiltonian can be investigated with techniques for Monte Carlo simulations.

In this exercise you will calculate the magnetic phase diagram of bulk bcc Fe. Exercise instructions: [Determination of Tc of a ferromagnetic material](https://uppasd.github.io/UppASD-manual/tutorial/#determination-of-t-c-of-a-ferromagnetic-material)

Reference pages:
- [UppASD manual](https://uppasd.github.io/UppASD-manual/)
- [UppASD tutorial](https://uppasd.github.io/UppASD-tutorial/)
- [UppASD autumn school 2022](https://www.pdc.kth.se/about/events/training/uppasd-autumn-school-2022-1.1187827)
---

<!-- Section: Using Python virtual environment -->

# Using Python virtual environment

### Xin Li, Juan de Gracia

---

# Why Use a Virtual Environment?

* **Python packages are essential tools** that help us accomplish various tasks in programming. Examples include:
  ```
  import numpy
  from pandas import DataFrame
  import matplotlib.pyplot as plt
  ```
* **Projects have unique needs:** Different projects may require different versions of the same package, leading to conflicts.
* **Shared systems complicate package management:** On High-Performance Computing (HPC) platforms, multiple users' needs might clash due to different package requirements.

---

# Why virtual environment?

Without virtual environment, Python packages are installed globally:

* **System site directory:** Where Python is installed and accessible by all users.
  ```
  python3 -c 'import site; print(site.getsitepackages())'
  ```
* **User base directory:** A user-specific area to avoid needing system-wide permissions.
  ```
  echo $HOME/.local
  ```

---

# Exercise: Check python site directory

```
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

```
ml cray-python/3.11.5
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

```
ml PDC/23.12 anaconda3/2024.02-1
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

---

# Python virtual environment

* **What is a Virtual Environment?** An isolated environment allowing you to manage packages for individual projects without conflicts and without interfering with the outside world.
* **How to Manage Virtual Environments?**
    - Using Python's built-in `venv` module.
    - Using `conda`, a powerful package manager and environment manager.

---

# Virtual environment with ``venv``

* Recommendation: use with cray-python
  ```
  ml cray-python/3.11.5

  cd $HOME
  python3 -m venv myenv

  source myenv/bin/activate
  ```
  Your prompt changes to indicate the active environment:
  ```
  (myvenv) user@uan01:~>
  ```

---

# Virtual environment with ``venv``

* Check site-packages directory
  ```
  (myenv) user@uan01:~> python3 -c 'import site; print(site.getsitepackages())'
  ['/cfs/klemming/home/u/user/myenv/lib/python3.9/site-packages']
  ```

* Install a Python package
  ```
  (myenv) user@uan01:~> python3 -m pip install yapf

  (myenv) user@uan01:~> which yapf
  /cfs/klemming/home/u/user/myenv/bin/yapf
  ```

---

# Virtual environment with ``venv``

* Deactivate a virtual environment
  ```
  (myenv) user@uan01:~> deactivate
  user@uan01:~>
  ```

---

# Virtual environment with ``conda``

* Load Anaconda: Prepares your system to use Anaconda packages and tools.
  ```
  ml PDC/23.12 anaconda3/2024.02-1
  ```

* Initialize Conda: Sets up Conda in your current shell session.
  ```
  source conda_init_bash.sh
  ```
* Your prompt changes to show (base), indicating Conda is ready.
  ```
  (base) user@uan01:~>
  ```

---

# Virtual environment with ``conda``

* Content of ``conda_init_bash.sh``

    ```
    # >>> conda initialize >>>

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('//pdc/software/23.12/eb/software/anaconda3/2024.02-1-cpeGNU-23.12/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/pdc/software/23.12/eb/software/anaconda3/2024.02-1-cpeGNU-23.12/etc/profile.d/conda.sh" ]; then
            . "/pdc/software/23.12/eb/software/anaconda3/2024.02-1-cpeGNU-23.12/etc/profile.d/conda.sh"
        else
            export PATH="/pdc/software/23.12/eb/software/anaconda3/2024.02-1-cpeGNU-23.12/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    ```

* ``conda init bash`` may append the above script to your ``~/.bashrc`` but this is not recommended on an HPC system.
* *Note:* Alternatively we can create a ``~/.bashrc.conda.dardel`` file and source it.

---

# Virtual environment with ``conda``

  * Create and activate a conda environment:

    ```
    (base) user@uan01:~> conda create --name my-conda-env

    (base) user@uan01:~> conda activate my-conda-env
    ```

  * Your prompt now indicates the active environment, e.g., (my-conda-env).

    ```
    (my-conda-env) user@uan01:~>
    ```

---

# Virtual environment with ``conda``

* Check Installation Path: Understand where Conda places your environment's packages.
  ```
  (my-conda-env) user@uan01:~> python3 -c 'import site; print(site.getsitepackages())'
  ```
* Anaconda's Default Directory: Packages are placed in Anaconda's directory **unless specified otherwise**.
  ```
  ['/pdc/software/23.12/eb/software/anaconda3/2024.02-1/lib/python3.11/site-packages']
  ```
* **Important:** We do not want to create our environments under the `anaconda3` instalation directory!

---

# Virtual environment with ``conda``

* We have seen that we cannot rely on the default behaviour of `conda create`.
* To circumvent this issue we will add a `~/.condarc` file specifying where environments and packages are installed
  ```
  pkgs_dirs:
      - /cfs/klemming/home/u/username/conda-dirs/pkgs
  envs_dirs:
      - /cfs/klemming/home/u/username/conda-dirs/envs 
  ```


* Verify Package Location: Confirm that packages are in your environment's directory.
  ```
  (my-conda-env) user@uan01:~> python3 -c 'import site; print(site.getsitepackages())'
  ['/cfs/klemming/home/u/user/conda-dirs/envs/my-conda-env/lib/python3.9/site-packages']
  ```

---

# Virtual environment with ``conda``
* Deactivate: Return to the base environment or your system's default settings.

  ```
  (my-conda-env) user@uan01:~> conda deactivate
  (base) user@uan01:~>
  ```


---
# Customizing Environment Location with --prefix


  ```
  conda create --prefix /path/to/myenv python=3.8
  ```
  - Replace /path/to/myenv with your desired location.
  Activating with --prefix:
  ```
  conda activate /path/to/myenv
  ```
  - Advantage: One can install the environment in a project directory and not be bounded to the memory limitation of the `$HOME`

---
# Working with Jupyter Notebooks

* Disclaimer: Jupyter notebooks can be run trough Thinlinc. 

* Make sure you have installed jupyter notebooks in your conda environment:
  ```
  conda install jupyterlab
  ```
* Then start a Jupyter notebooks without browser:
  ```
  jupyter-notebook 
  ```
* **Important:** Do not run a Jupyter notebook in the login node, instead get an interactive node allocation:
  ```
  salloc --nodes=<n> -t 1:00:00 -A <project>
  ```


