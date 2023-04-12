#!/bin/bash -l
#SBATCH -A edu2304.intropdc
#SBATCH -J myjob
#SBATCH -p shared
#SBATCH -n 16
#SBATCH -t 01:00:00

# Load the Matlab module
ml PDC/22.06
ml matlab/r2023a

# Run matlab taking your_matlab_program.m as input
echo "Script initiated at `date` on `hostname`"
matlab -nodisplay -nodesktop -nosplash spectral_serial.m your_matlab_program.out
echo "Script finished at `date` on `hostname`"
