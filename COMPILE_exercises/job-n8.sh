#!/bin/bash

#SBATCH -A edu2203.intropdc
#SBATCH --reservation intropdc-day2
#SBATCH -p main
#SBATCH -t 00:10:00
#SBATCH -J job-n8

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=32

module load PDC/21.11
module load cpeGNU/21.11
module load cray-python/3.9.4.2
module load openblas/0.3.18-openmp

source ./myenv/bin/activate

export OMP_PLACES=cores

export OMP_NUM_THREADS=16
echo 8 MPI x 16 OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=8
echo 8 MPI x 8 OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=4
echo 8 MPI x 4 OMP
srun python3 matmul_mpi_omp_test.py
