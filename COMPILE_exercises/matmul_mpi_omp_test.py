from mpi4py import MPI
import numpy as np
import time

comm = MPI.COMM_WORLD
nranks = comm.Get_size()

nrows = 2000000
ncols = 2000

local_matrix = np.random.rand(nrows // nranks, ncols)

comm.barrier()
t0 = time.time()

mat = np.matmul(local_matrix.T, local_matrix)
mat = comm.reduce(mat, op=MPI.SUM, root=0)

if comm.Get_rank() == 0:
    print(f'Time spent in matmul: {time.time() - t0:.3f} sec')
    print('Error:', np.max(np.abs(mat - mat.T)))
