#!/bin/bash -l
#SBATCH -A snicYYYY-X-XX
#SBATCH -J myjob
#SBATCH -p shared
#SBATCH -n 16
#SBATCH -t 10:00:00

# Load the Matlab module
ml add PDC/21.11
ml matlab/r2021b

# Run matlab taking your_matlab_program.m as input
matlab -nodisplay -nodesktop -nosplash < your_matlab_program.m > your_matlab_program.out
