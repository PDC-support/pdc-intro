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

# PDC is a SNIC center

![bg left:30% width:100%](https://raw.githubusercontent.com/PDC-support/introduction-to-pdc/dardel/images/snic.png)

* SNIC (Swedish National Infrastructure for Computing)

* SNIC is a national research infrastructure that provides a balanced and cost-efficient set of resources and user support for large scale computation and data storage to meet the needs of researchers from all scientific disciplines and from all over Sweden (universities, university colleges, research institutes, etc).

* SNIC is funded by the Swedish Research Council (VR-RFI) and the 10 participating universities: Chalmers, GU, KI, KTH, LiU, LU, SLU, SU, UmU, and UU.

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

* Zoom-in (advertised in training newsletter)

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

2023-03-08

[About Dardel](https://www.pdc.kth.se/hpc-services/computing-systems/about-dardel-1.1053338)

---

# Dardel is an HPE Cray EX system

* Phase 1: CPU partition

    - 2.279 petaFlops (Top500 Nov 2021)
    - 554 CPU nodes
    - Dual AMD EPYC(TM) 64-core processors

* Phase 2: GPU partition

    - 56 GPU nodes
    - AMD EPYC(TM) processor with 64 cores
    - four AMD Instinct(TM) MI250X GPUs

---

![bg width:100%](https://pdc-web.eecs.kth.se/files/support/images/anatomy.png)

---

# Supercomputer anatomy

* Dardel consists of several cabinets (also known as racks)

* Each cabinet is filled with many blades

* A single blade hosts two nodes

* A node has two AMD EPYC 7742 CPUs, each with 64 cores clocking at 2.25GHz

---

# Compute nodes

| Number of nodes | RAM per node | Name |
| --- | --- | --- |
| 488 | 256 GB | Thin nodes |
| 20 | 512 GB | Large nodes |
| 8 | 1 TB | Huge nodes |
| 2 | 2 TB| Giant nodes |
| 36 | 256 GB | Business nodes |

Total: **554** Nodes (128 cores per node)

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

