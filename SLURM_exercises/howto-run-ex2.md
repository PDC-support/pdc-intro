---
marp: true
---

# Exercise 2

* In this exercise we are going to use some more advanced SLURM commands to explore job performance. 

* You will:
   - Create and compile a simple MPI program
   - Submit it to the queues
   - Check job data using sacct



<style scoped>a { color: #eee; }</style>

<!-- This is presenter note. You can write down notes through HTML comment. -->

---
```c
#include <mpi.h>
#include <stdio.h>
#include <unistd.h>

#define NROWS 16384
#define NCOLS 16384

double A[NROWS][NCOLS];

int main(int argc, char** argv) {
  int world_size,world_rank;
  int i, j;

  // Initialize the MPI environment
  MPI_Init(NULL, NULL);

  // Get the number of processes
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);

  // Get the rank of the process
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

  // Print off a hello world message
  printf("Hello world from rank %d out of %d process\n", world_rank, world_size);

  // Initialize the matrix
  for(i = 0; i < NROWS; i++)
     for(j = 0; j < NCOLS; j++)
        A[i][j] = i + j;


  // Wait a bit to simulate some computation
  sleep(30);

  // Finalize the MPI environment.
  MPI_Finalize();
  return 0;
}
```

---

# Exercise

* Save the code from the previous slide into hello_mpi.c

* Compile the code and generate a binary

---

# Job script

```
#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A edu2210.intropdc

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p shared

# 10 hours wall-clock time will be given to this job
#SBATCH -t 00:01:00

# Number of nodes
#SBATCH --nodes=1

# Number of MPI processes per node
#SBATCH --ntasks-per-node=4

# Run the executable named myexe
# and write the output into my_output_file
srun ./hello_mpi
```
---

# Exercise

* Save the script from the previous slide to myjob.sh

* Submit the job. Once the job finishes check its output

* What happened with the job?

* Inspect the job data using **sacct**
   - Use: JobID, JobName, Elapsed, Alloc, NTask, MaxRRS, ReqMem, State

     **Tip**: use flag "--unit=M" to see memory units in MB

* Can you see why the job failed?


---

# Exercise

* Change the NROWS and NCOLS value to 4096 for example

* Run again, and check the job with sacct

* Try to use the **seff** command for another quick job efficiency report.  

```
Job ID: 211499
Cluster: dardel
User/Group: xaguilar/xaguilar
State: COMPLETED (exit code 0)
Nodes: 1
Cores per node: 8
CPU Utilized: 00:00:01
CPU Efficiency: 0.37% of 00:04:32 core-walltime
Job Wall-clock time: 00:00:34
Memory Utilized: 549.25 MB (estimated maximum)
Memory Efficiency: 7.73% of 6.94 GB (888.00 MB/core)
```

