#!/bin/bash

#SBATCH -A ...
#SBATCH --reservation ...
#SBATCH -p shared
#SBATCH -t 00:10:00
#SBATCH -J job-n4

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8

ml PDC/23.03
ml cpeGNU/23.03
ml cray-python/3.9.13.1

export OMP_PLACES=cores

export OMP_NUM_THREADS=4
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=2
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=1
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py
