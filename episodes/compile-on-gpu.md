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

# Experimental GPU build environment

Some programs a require a more recent version of the CPE and of ROCm. We have CPE 22.12 and ROCm 5.3.3 available on the GPUs. This combination of software is not officially supported by HPE but seems to work quite well and contains some additional functionality.

   - ``ml cpe/22.12``
   - ``ml rocm/5.3.3``
   - ``ml craype-accel-amd-gfx90a``

The CPE version 22.12 is available **on the GPU nodes**. We recommend these versions to more advanced users.

---

# Runtime environment variables

For executables that are built with the compilers of the Cray Compiler Environment (CCE),
verbose runtime information can be enabled with the environment variable ``CRAY_ACC_DEBUG``
which takes values 1, 2 or 3. For the highest level of information

   - ``export CRAY_ACC_DEBUG=3``

---

# Example 1: Offloading to GPU with HIP - building

In this example we build and test run a Hello World C++ code in which offloading to GPU is done with the heterogeneous interface for portability (HIP). The program is built with the AMD hipcc compiler.

* Download the source code
   - ``wget https://raw.githubusercontent.com/PDC-support/introduction-to-pdc/master/example/hello_world_gpu.cpp``

* Load the ROCm module and set the accelerator target to amd-gfx90a (AMD MI250X GPU)
   - ``ml rocm/5.0.2``
   - ``ml craype-accel-amd-gfx90a``

* Compile the code with hipcc on the login node
   - ``hipcc --offload-arch=gfx90a hello_world_gpu.cpp -o hello_world_gpu.x``

---

# Example 1: Offloading to GPU with HIP - running

* Test the code in an interactive session.

* First queue to get one GPU node reserved for 10 minutes
    - ``salloc -N 1 -t 0:10:00 -A <project name> -p gpu``

* wait for a node, then run the program
    - ``srun -n 1 ./hello_world_gpu.x``

* with program output to standard out

```
You can access GPU devices: 0-7
GPU 0: hello world```
...
```

