#!/bin/bash

#SBATCH -A ...
#SBATCH -p shared
#SBATCH -t 00:10:00
#SBATCH -J job-n2

#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=16

ml PDC/23.03
ml cpeGNU/23.03
ml cray-python/3.9.13.1

export OMP_PLACES=cores

export OMP_NUM_THREADS=8
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=4
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=2
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py
