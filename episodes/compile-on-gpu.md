---

<!-- Section: Compiling and running code on GPU nodes -->

# Compiling and running code on GPU nodes

### Johan Hellsvik

Reference page: [Building for AMD GPUs](https://www.pdc.kth.se/support/documents/software_development/development_gpu.html)

The AMD Radeon Open Compute (ROCm) platform is a software stack for programming and running of programs on GPUs.

* The ROCm platform supports different programming models
    - Heterogeneous interface for portability (HIP),
    - Offloading to GPU with OpenMP directives
    - The SYCL programming model

---

# Setting up a GPU build environment

* Load version 5.0.2 of ROCm with
    - ``ml rocm/5.0.2``

* Set the accelerator target to **amd-gfx90a** (AMD MI250X GPU)
    - ``ml craype-accel-amd-gfx90a``

* Choose one of the available toolchains (Cray, Gnu, AOCC)
    - ``ml cpeCray/22.06``
    - ``ml cpeGNU/22.06``
    - ``ml cpeAOCC/22.06``

---
