#!/bin/bash
#SBATCH -A pdc.staff         # Set the allocation to be charged for this job
#SBATCH -J myjob             # Name of the job
#SBATCH -p gpu               # The partition
#SBATCH -t 01:00:00          # 1 hour wall-clock time
#SBATCH --nodes=1            # Number of nodes
#SBATCH --ntasks-per-node=1  # Number of MPI processes per node

ml rocm/6.3.3                # Load a ROCm module
ml craype-accel-amd-gfx90a   # set the accelerator target

srun ./hello_world_gpu.x > output.txt # Run the executable named hello_world_gpu.x and write the output into output.txt
