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

2022-MM-DD

PDC staff

<style scoped>a { color: #eee; }</style>

<!-- This is presenter note. You can write down notes through HTML comment. -->

---

<!-- paginate: true -->

# Introduction to Dardel supercomputer
![bg 90% left](https://www.pdc.kth.se/polopoly_fs/1.1053343.1614296818!/image/3D%20marketing%201%20row%20cropped%201000pW%20300ppi.jpg)

### [name of lecturer]

---

# HPE/Cray EX system

* Phase 1: CPU partition

    - 2.279 petaFlops (Top500 Nov 2021)
    - 554 CPU nodes
    - Dual AMD EPYC(TM) 64-core processors

* Phase 2: GPU partition

    - 56 GPU nodes
    - AMD EPYC(TM) processor with 64 cores
    - four AMD Instinct(TM) MI250X GPUs

---

# Dardel CPU partition

* Processor

    - Dual AMD EPYC 2.25 Ghz 64-core
    - 128 cores per node

* Interconnect

    - HPE Slingshot using Dragonfly topology
    - 100 Gb/s first phase

---

# Compute nodes

| Nodes | RAM (GB) | Name |
| --- | --- | --- |
| 488 | 256 | Thin |
| 20 | 512 | Large |
| 8 | 1024 | Huge |
| 2 | 2048 | Giant |
| 36 | 256 | Business |
| ? | 256 | SCANIA |

Total: **554** Nodes with 128 cores

---

# File Systems

Lustre File System (Klemming)

* Open-source massively parallel distributed le system
* Optimized for handling data from many clients
  - Total size is 12 PB (12,000 TB)
* Home directory (25 GB, with backup)
  - /cfs/klemming/home/[u]/[username]
* Project directory
  - /cfs/klemming/projects/snic/[projectname]
* Scratch directory
  - /cfs/klemming/scratch/[u]/[username]

---

# File Systems

* Good practice
  - Minimize the number of I/O operations
  - Avoid creating too many files
  - Avoid creating directories with a large numbers of files
* Bad practice
  - Small reads
  - Opening many files
  - Seeking within a le to read a small piece of data

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

### To grant the access to another user ("-R" for recursive):
```
setfacl -m u:<uid>:r-x -R /cfs/klemming/home/u/user/test
```
### To remove the access for another user ("-R" for recursive):
```
setfacl -x u:<uid> -R /cfs/klemming/home/u/user/test
```

---

# Using Bash shell
## Introduction for beginners
### [Tor Kjellsson Lindblom]
---
### Content
* Bash shell and basic commands
* Files and Folders
* Input/output
* Searching for files or text
* Processes
* File/directory permissions
* Hotkeys
* Environment variables
* File archiving



---
### What is a shell?
* What you get when the terminal window is open

* A "layer" (shell) around the operating system

* **Frequently used to interact with remote systems, such as Dardel**

* Multiple types of shells exist - this is about **bash shell**

* This presentation contains the very basics, mixing in some hands-on exercises.

* **No need to finish all exercises**.

---
### Getting a bash shell
* Linux and Mac users - just open a terminal window (or login to Dardel)
* Windows users - please login to Dardel.
---
### Your very first commands
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
### Exercise 1
* Explore the contents of **shell-lesson-data**
* Move back and forth into the subdirectories
* Move into **exercise-data** and copy the file "numbers.txt" into a new file "numbers_copy.txt" by typing
```
cp numbers.txt numbers_copy.txt
```
verify that the new file was created.
 **NB! Do not use whitespace in file/folder names.**

* Create a new directory with some name, and move this copy there
```
mv numbers_copy.txt your_new_folder/.
```
---
### Some more commands

```
cp -r dir1 dir2   (copy directory, NB "-r")
man ls            (prints manual for ls)
rm file_example   (remove file_example (careful! can not be undone))
history           (prints command line history)
cat file_example  (print all contents of file)
less file_example (view contents of file in pager)
head file_example (print first lines of file)
tail file_example (print last lines of file)

```
---
### Exercise 2
* Copy an existing directory
* Display "numbers_copy.txt" in some way
* Print your command line history
* Take a peek at the manual for command *ls*:
```
Type man ls
Press up/down keys to scroll
Type / to start search mode
Try to search for the flag: -F
Type q to quit
```
---
### Relative vs. absolute paths
You can specify a location relative to current position, or give an absolute path to it.

```
(Relative)            
cd exercise_data    

(Absolute)
cd /home/tkl/shell-lesson-data/exercise-data
```


---
### Text editors
Most people are used to GUI text editors but it is often worthwhile to master at least one editor in the terminal.

List of common editors:
* nano - easiest, minimal functionality
* vi/vim - a bit more involved, but more functionality
* emacs - even a bit more involved, but a lot of functionality

---

### Input & Output: redirect and pipes
* Programs can display something, e.g. **"echo hello world"**

* Programs can take input, e.g. **less**

* "cat numbers_copy.txt" dumps the file to *stdout*

* "cat numbers_copy.txt | less" gives the text as input to *less* (i.e. pipe)
---
### Try it: pipes
```
# count number of logged in users
w -h | wc -l

# to list all matching commands
history | grep -w 'ls'

# print the name of the newest file in the directory (non-dot)
ls -1tF | grep -v -E '*/|@' | head -1

```
---
### Redirects
* Like pipes, but data is sent to/from files and not processes

* Replace a file: command > file.txt

* Append to a file: command >> file.txt (be careful to **not** mix them up!)

* Redirect file as STDIN: command < file (in case program accepts STDIN only)

---
### Try it: Redirects
```
echo Hello World > hello.txt

ls -lH >> current_dir_ls.txt

# join two files (e.g. the two above) into one
cat file1 file2 > file3

# go through file1 and replace spaces with a new line mark, then output to file2
tr -s ' ' '\n' < file1 > file2
# -or- in more readable format
cat file1 | tr -s ' ' '\n' > file2
```
---
### Exercise 4
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
### Finding things
Command: *find*

```
# search for pentane.pdb in current directory
find . -name pentane.pdb

# one can search more than one dir at once
find . /cfs/klemming/nobackup/u/username -name pentane.pdb

```
Bonus (for interested to do later):
* On a Lustre system, *lfs find* is faster. Same syntax.

* On a workstation: *locate* may be useful. Read manual for information.
---
### grep
This command is for searching keyword inside files.

```
grep <pattern> <filename>  # grep lines that match <pattern>
 -or-
command | grep <pattern>  # grep lines from stdin

```
---
### Exercise 5
```
grep:
* Go back to the data-shell directory
* Type grep rabbit exercise-data/animal-counts/animals.csv
* Try finding all occurences of the string “rabbit” using
recursive search (adding the -R flag)

find:
* Type find . -name animals.csv.
* Try to find all files ending with .pdb using the find command.

grep + pipes:
* Make a pipe that counts number of files/directories in the
 data-shell directory.

bonus:
* Count unique logged in users on Dardel.
Tip: w or users gives you a list of all currently login users,
many of them have several sessions open.
Tip: You may have to use uniq, tr -s, cut -f 1 -d " ", and wc -l
```

---
### Processes
Uptil now we only discussed files/folders.
But we also want to run **programs.**
* All running programs and commands are *processes*
* Processes have:
  * Process ID
  * NAME
  * Command line arguments
  * input and output
  * Return code (integer) when complete
  * Working directory
  * Environment variables
* These concepts bind together all UNIX programs

To see some runnings processes, typ *top*

---
### Foreground and background processes

**Foreground**

 * Example: *Top*
 * Keyboard is connected as input, screen to output.
 * Only one such process active at a time.
 * Kill it: Ctrl-c

**Background**
 * No input connected
 * You can have as many as resources allow
 * Add an *&* after a command to put it in background
 * To kill: use *kill* or *pkill*, or do it from within *top*

 ```
 Example:
 ./my_prog.ex
 ./my_prog.ex 1> output.txt 2>error.txt &

 ```
**NB: You will most likely not use Dardel like this, but it is possible to do so by logging into a compute node.**

---
### File/directory permissions
#### The basics
* Important to set access permission on shared objects
* Permissions are a type of file metadata
* Tell you who can: **r**ead, **w**rite and e**x**ecute a file/list a directory

```
Example
$ ls -l exercise_data

drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 proteins
-rw-rw-r-- 1 tkl tkl   13 sep 16  2021 numbers.txt
drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 animal-counts
drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 creatures
drwxrwxr-x 2 tkl tkl 4096 sep 28 12:23 writing

```
* First character specific for object: *d* is for directory.
* Then 3 groups of triple fields: user, group, others
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
**NB: On Dardel, we mainly use ACLs instead (next slide)**

---
#### Access control lists (ACLs)

* On Lustre (Klemming) we use more advanced access permissions.

* Normal unix permission have only one *owner* and *group*. With ACLs, this restriction is lifted.

* ACLs are controlled via *getfacl* and *setfacl*

```
getfacl file                   (get current stage)
setfacl -m u:<user>:r file    (Allow read access for user)

```
In many support cases we ask users to apply the last line so we can access files.

---
### Hotkeys
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
### Exercise 6
#### TAB autocompletion

We will here display contents of a file using its full path, but try to type as few characters as possible.

First find your absolute path to "numbers.txt"
```
Type find $HOME -name numbers.text
```
Say the path was /home/tkl/shell-lesson-data/exercise-data/numbers.txt
```
Type cat /home/tk and then start hitting TAB. Add characters when needed to reach full path.
```
(use your own path)

---
### Environment variables
Defined text strings that your programs may use

* In the shell, these variables define your environment
* Common practice: capital letters, e.g. $HOME, $PATH, $OMP_NUM_THREADS
* List all defined variables with *printenv*

Try it:
```
* Type echo $HOME
* Type echo $HOSTNAME
* Type echo $PATH
```

---
### Initialization and configuration
* When the shell first starts (e.g. at login) it reads shell config files.

* The config files give you power to customize your shell to your liking.

* You can always manually test things in an open shell before putting it in the config files (recommended!)

* Config files are located in $HOME and are called:
 * .bashrc
 * .bash_profile

```
Example
* Type history
* Type HISTTIMEFORMAT="%d/%m/%y %T "
* Type history
```

---
### File archiving
* *tar* is the standard tool to save many files or directories into a single archive file_example

* Archive files may have extensions .tar, .tar.gz etc depending on compression used.

```
# create tar archive gzipped on the way
tar -caf archive_name.tar.gz dir/

# extract files
tar -xaf archive_name.tar.gz -C /path/to/directory
```
* f is for filename
* a selects compression based on suffix
* With no compression, files are simply packed
* r will append files to end of archive
* t will list archive

* Individual files can be compressed directly with e.g. gzip. (gzip file, gunzip file.gz)

---
### Exercise 7
```
* Make a tar.gz archive of shell-lesson-data
* Make a tar archive, compare sizes
* List the files inside the archive

```

---
# Running jobs with efficient utilization of hardware

### [name of lecturer]

---

# Using Matlab

### [name of lecturer]

---

# Using Python virtual environment

### [name of lecturer]

---


# How to use EasyBuild on Dardel
![bg h:150 80% left](https://docs.easybuild.io/en/latest/_static/easybuild_logo_alpha.png)
### 2022-03-24

### https://docs.easybuild.io/en/latest/

---

# Methods of installing software at PDC

* EasyBuild https://www.pdc.kth.se/support/documents/software_development/easybuild.html
* Spack https://www.pdc.kth.se/support/documents/software_development/spack.html
* Manually https://www.pdc.kth.se/support/documents/software_development/development_dardel.html

---

# What is EasyBuild

* Started in 2008 by HPC team at Ghent university, Belgium
* Software build and installation framework
* Tailored towards High Performance Computing (HPC) systems
* Installs HPC software using procedures described in recipes

---

# What modules are available

### For local installations

```
ml PDC
ml EasyBuild-user
```

* INSTALLPATH: *$HOME/.local/easybuild*
* SOURCEPATH: *$HOME/.local/easybuild/sources*
* adds to MODULEPATH: *$HOME/.local/easybuild/modules/all*
* Temporary folder: /tmp

---

# How is EasyBuild configured

```
$ eb --show-config
# (C: command line argument, D: default value, E: environment variable, F: configuration file)
#
buildpath          (E) = /tmp/eb-build
...
sourcepath         (D) = /cfs/klemming/home/h/hzazzi/.local/easybuild/sources
```

:red_circle: Current EasyBuild configuration can be changed if needed

```
$ eb --show-config --<CONFIG-NAME>=<VALUE>
```

---

# Exercise 1

* Load the EasyBuild-user module
* Check how it is configured
* Change some of the configuration parameters

---

# What are easyconfigs files

* Plain text file to define installation parameters

* serves as a build specification for software installation

* Is typically named:
  ```
  <name>-<version>[-<toolchain>][<versionsuffix>].eb
  ```
* Example
  ```
  GROMACS-2021.3-cpeGNU-21.11.eb
  ```

---

# What is a toolchain

* Defines what compiler toolchains to install the software with
* On Cray we have compiler wrappers, so all software is installed within the Cray Programming Environment (CPE)

  ```
  cpeGNU version 21.11
  cpeCray version 21.11
  cpeAMD version 21.11
  ```
* Softwares not in need of parallelization can use the **SYSTEM** toolchain

---

# How to install software using EasyBuild

* Installs dependencies
* Builds and install software
* Create modules for software and dependencies

```
$ eb <FILENAME>.eb
== creating build dir, resetting environment...
== unpacking...
== preparing...
== configuring...
== building...
== testing...
== installing...
== sanity checking...
== cleaning up...
== creating module...
== COMPLETED: Installation ended successfully
```
---

# Other types of installation procedures

## Installing software via the Robot paths

* Installs the latest software found in the paths defined in the configuration

```
eb --software-name=GROMACS --toolchain=cpeGNU,21.11
```

## Rebuild

* rebuilds the software even if it does exist

```
eb --rebuild ...
```

---

# dry-run

```
eb Boost-1.75.0-cpeGNU-21.09.eb -dr/--dry-run
```

* Test the installation procedure without installing it
* you can also use *-x/--extended-dry-run* for more information

---

# How install dependent software

Automatically installs dependency software using easyconfigs that are available in robot paths

* Automatically install dependencies
  ```
  eb Boost-1.75.0-cpeGNU-21.09.eb -r/--robot[=<PATH>]
  ```

* Check what dependencies are missing
  ```
  eb Boost-1.75.0-cpeGNU-21.09.eb -M/--missing
  ```

---

# Supported Robot paths

Contains easyconfigs and easyblocks for building software.

* PDC SoftwareStack
* LUMI SoftwareStack
* CSCS Software stack

---

# How to search for software using EasyBuild

```
eb -S/--search <software>
CFGS1=/pdc/software/eb_repo/PDC-SoftwareStack/easybuild/easyconfigs/g
CFGS2=/pdc/software/eb_repo/LUMI-SoftwareStack/easybuild/easyconfigs/g/GROMACS
CFGS3=/pdc/software/eb_repo/CSCS-production/easybuild/easyconfigs/g/GROMACS
 * $CFGS1/GROMACS-2020.5-cpeCray-21.09.eb
 * $CFGS1/GROMACS-2021.3-cpeCray-21.09.eb
 * $CFGS1/GROMACS-2022-beta1-cpeCray-21.09.eb
```

* Lists available *easyconfig* files
* These can be used to make new easyconfig recipes
* PDC recipes can be found at https://github.com/PDC-support/PDC-SoftwareStack/blob/master/easybuild/easyconfigs

---

# Copy found easyconfigs

Copy found easyconfigs to act as base for creating easyconfigs for your application

```
eb --copy-ec <easyconfig filename>.eb [<new filename>]
```

Example:

```
eb --copy-ec BWA-0.7.17.eb my_easyconfig.eb
```

---

# Exercise 2

* Install BWA
  * Does it miss any dependencies
  * Run a dry-run to see if it installs properly before installing it
* Install any other software using EasyBuild

---

# How to build easyconfig files

* Parameters and templates
* What is needed in an easyconfig file
  * Name
  * Toolchain
  * Sources
  * Easyblock
  * Dependencies
  * Sanity_check

Writing easyconfig files https://docs.easybuild.io/en/latest/Writing_easyconfig_files.html

---

# Parameters and templates in easyconfig files

A full overview of all known easyconfig parameter
```
eb -a/--avail-easyconfig-params
```

A set of variables that can be used in easyconfig files
```
eb --avail-easyconfig-templates
```

---

# Name

* Specifies the name and version of the software
* module will be named accordingly
* *versionsuffix* is not mandatory

```
name = 'GROMACS'
version = '2020.5'
versionsuffix = '-PLUMED-2.7.2'

homepage = 'https://blast.ncbi.nlm.nih.gov/'
description = """Blast for searching sequences"""
```

---

# Toolchain

### If you want to use MPI, OpenMP ...

```
toolchain = {'name': 'cpeGNU', 'version': '21.11'}
```
`Will also have an impact on the dependencies for this easyconfig`

### If you want to use supporting tools, libraries...

```
toolchain = SYSTEM
```

---

# Sources

Specify where you can download your source

```
sources = [{
    'source_urls': ['https://example.com'],
    'filename': '%(name)s-%(version)s.tar.gz',
    'extract_cmd': "tar xf %s",  # Optional
}]
```
```
source_urls = ['ftp://ftp.%(namelower)s.org/pub/%(namelower)s/']
sources = ['%(namelower)s_%(version_major)s_%(version_minor)s_0.tar.bz2']
```

More information at https://docs.easybuild.io/en/latest/Writing_easyconfig_files.html#source-files-patches-and-checksums

---

# Easyblock

* A python code to address special needs of the installation
* Adresses that you should first run *configure > make > make install* or *cmake > make > make install

```
easyblock = 'type'
```

* Many EasyBlock are generic as to describe standard installation patterns
* Easyconfigs without an easyblock entry are special and Easybuild will search for EasyBlocks named **EB_[software]**

To find which Easyblock is specially for you...
```
eb --list-easyblocks
```

---

# Examples of useful easyblocks

* **ConfigureMake**: implements the standard ./configure, make, make install installation procedure;
* **CMakeMake**: same as ConfigureMake, but with ./configure replaced with cmake for the configuration step;
* **PythonPackage**: implements the installation procedure for a single Python package, by default using "python setup.py install" but other methods like using "pip install" are also supported;
* **Bundle**: a simple generic easyblock to bundle a set of software packages together in a single installation directory;

See information about parameters for easyblocks https://docs.easybuild.io/en/latest/version-specific/generic_easyblocks.html

---

# Dependencies/builddependencies

* Will be installed if found and a module does not exists.
* *dependencies* are used when the module is loaded
* *builddependencies* are used when the software is installed

### Main application toolchain

```
dependencies = [
    ('Software', 'version'),
]
```

### System toolchain

```
dependencies = [
    ('Software', 'version', '', ('system', '')),
]
```

---

# Sanity check

* A test to see everything was installed correctly

```
sanity_check_paths = {
    'files': ['bin/reframe',
              'share/completions/file1',
              'share/completions/file2'],
    'dirs': ['bin', 'lib', 'share', 'tutorials']
}

sanity_check_commands = [
    'software --version',
    'software --help',    
]
```

---

# Exercise 3

* Create your own *easyconfig* file
  * Create your *easyconfig* on any recipe you find that is appropriate
  * Edit and make the necessary changes
* Perform a dry-run as to acertain that there are no installation issues
* Install the software

---

# Compiling and running your own code

### [name of lecturer]
