#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A edu2304.intropdc

# Reservation for today
#SBATCH --reservation=intropdc-cpu-2023-04-13

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p shared

# 5 minutes wall-clock time will be given to this job
#SBATCH -t 00:05:00

# Number of nodes
#SBATCH --nodes=1

# Number of MPI processes per node
#SBATCH --ntasks-per-node=4

# Run the executable
srun ./vector_mpi.x
