#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A edu2203.intropdc

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p shared

# 10 hours wall-clock time will be given to this job
#SBATCH -t 00:01:00

# Number of nodes
#SBATCH --nodes=1

# Number of MPI processes per node
#SBATCH --ntasks-per-node=4

# Run the executable named myexe
# and write the output into my_output_file
srun ./vector_mpi
