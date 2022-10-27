#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A XXX

# Reservation for today
#SBATCH --reservation=intropdc-2022-10-28

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p shared

# 10 hours wall-clock time will be given to this job
#SBATCH -t 00:05:00

# Number of nodes
#SBATCH --nodes=X

# Number of MPI processes per node
#SBATCH --ntasks-per-node=Y

# Run the executable named myexe
# and write the output into my_output_file
srun ./hello_mpi > my_output_file
sleep 60

