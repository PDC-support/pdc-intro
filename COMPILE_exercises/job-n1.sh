#!/bin/bash

#SBATCH -A ...
#SBATCH -p shared
#SBATCH -t 00:10:00
#SBATCH -J job-n1

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32

ml PDC/23.03
ml cpeGNU/23.03
ml cray-python/3.9.13.1

export OMP_NUM_THREADS=16
export OMP_PLACES=cores
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=8
export OMP_PLACES=cores
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py

export OMP_NUM_THREADS=4
export OMP_PLACES=cores
echo $SLURM_NTASKS MPI x $OMP_NUM_THREADS OMP
srun python3 matmul_mpi_omp_test.py
