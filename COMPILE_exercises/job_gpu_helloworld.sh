#!/bin/bash
#SBATCH -A edu26.summer      # Set the allocation to be charged for this job
#SBATCH --reservation=edu26-08-20
#SBATCH -J myjob             # Name of the job
#SBATCH -p gpu               # The partition
#SBATCH -t 00:10:00          # 1 hour wall-clock time
#SBATCH --nodes=1            # Number of nodes
#SBATCH --ntasks-per-node=1  # Number of MPI processes per node

ml rocm/7.2.1                # Load a ROCm module
ml craype-accel-amd-gfx90a   # set the accelerator target

srun ./hello_world_gpu.x > output.txt # Run the executable named hello_world_gpu.x and write the output into output.txt
