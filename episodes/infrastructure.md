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

