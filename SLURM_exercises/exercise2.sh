#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A edu25.summer

# Reservation for today
#SBATCH --reservation=lab25-08-15

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p shared

# 5 minutes wall-clock time will be given to this job
#SBATCH -t 00:05:00

# Number of nodes
#SBATCH -N 1

# Number of MPI processes
#SBATCH -n 4

# Run the executable
srun ./vector_mpi.x
