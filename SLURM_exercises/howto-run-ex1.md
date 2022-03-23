---
marp: true
---

# Exercise 1

* In this exercise we are going to test some basic SLURM commands. 

* You will:
   - Create and compile a simple MPI program
   - Submit it to the queues
   - Inspect the queues
   - Inspect the partitions
   - Check the output of the job


---
# MPI Hello world

```c
#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
  int world_size,world_rank;
      
  // Initialize the MPI environment
  MPI_Init(NULL, NULL);
  // Get the number of processes
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);
  // Get the rank of the process
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
  // Print off a hello world message
  printf("Hello world from rank %d out of %d process\n", world_rank, world_size);
  // Finalize the MPI environment.
  MPI_Finalize();
  return 0;
  }
```


<style scoped>a { color: #eee; }</style>

<!-- This is presenter note. You can write down notes through HTML comment. -->

---

# Exercise

* Save the code from the previous slide to hello_mpi.c

* Compile the code and generate a binary

---

# Job script

```
#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A XXX

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
```
---

# Exercise

* Take the job script from the previous slide, save it in job.sh and modify it accordingly to:
   - Use the proper allocation required, for this course it is *edu2203.intropdc* 
   - Use one node
   - Use 4 cores from that node
   - Add the command **srun -n 1 hostname** to the script (what this will do?)
   - Add at the end the command **sleep 60** to make the job "sleep" for 60 seconds


---

# Exercise

* Submit this script using **sbatch**

* Check the queue using **squeue -u $USER**
   - What's the ID of the job?
   - Is it already running? 
   - Which node was allocated for the job?

* Try using **scontrol show job <job-id>** to see more info about the job

* Once the job finishes check the output job. Where is it saved?

---

**Note**: 

Notice that we run our program with just:

```
srun ./hello_mpi
````

It would be also possible to run our program with:
```
srun -N 1 -n 4 ./hello_mpi
```

However, we don't need to specify the flags because SLURM takes the *-N* and *-n* values from the script *BATCH* directives 

---

# Exercise

* Use **sinfo** to check the partitions
  - How many different partitions are defined? What are their names?
  - What's the partition with the highest number of nodes?
  - Name 1-2 nodes included in that same partition
