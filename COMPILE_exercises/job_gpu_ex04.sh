#!/bin/bash
#SBATCH -A pdc.staff         # Set the allocation to be charged for this job
#SBATCH -J myjob             # Name of the job
#SBATCH -p gpu               # The partition
#SBATCH -t 01:00:00          # 1 hour wall-clock time
#SBATCH --nodes=1            # Number of nodes
#SBATCH --ntasks-per-node=1  # Number of MPI processes per node

ml rocm/5.0.2                # Load a ROCm module
ml craype-accel-amd-gfx90a   # set the accelerator target

srun ./ex04.x > output.txt  # Run the ex04.x executable named myexe and write the output into output.txt
