---
marp: true
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

### [name of lecturer]

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

# Building software with EasyBuild
![bg h:150 80% left](https://docs.easybuild.io/en/latest/_static/easybuild_logo_alpha.png)

### [name of lecturer]

---

# Compiling and running your own code

### [name of lecturer]
