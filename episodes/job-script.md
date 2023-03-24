---

<!-- Section: Job script for efficient utilization of hardware -->

# Running jobs with efficient utilization of hardware

### Xavier Aguilar

---

# How we run jobs on a Supercomputer

![bg right:60% width:100%](https://pdc-web.eecs.kth.se/files/support/images/LoginNodeWarning.PNG)

* Edit files
* Compile programs
* Run light tasks
* Submit jobs
* **Do not** run parallel jobs on the login node!


---
# What is SLURM ?
## Simple Linux Utility for Resource Management

* Open source, fault-tolerant, and highly scalable cluster management and job scheduling system
  - Allocates access to resources
  - Provides a framework for work monitoring on the set of allocated nodes
  - Arbitrates contention for resources
---

# Types of jobs?

* **Batch jobs**
  - the user writes a job script indicating the number of nodes, cores, time needed, etc.
  - the script is submitted to the batch queue
  - The user retrieves the output files once the job is finished
* **Interactive jobs:**
  - the user runs a command that allocates interactive resources on a number of cores
  - this creates an interactive job that awaits in the queue as any other job
  - when the job reaches the front of the queue, the user gets access to the resources and can run commands there

---

# How jobs are scheduled?

* **Age**: the time the job has been in the queue
* **Job size**: number of nodes or cores requested
* **Partition**: a factor associated with each node partition
* **Fair-share**: the difference between the computing resources promissed and the amount of resources computed


---

# SLURM basic commands

### Submit a job to the queue:
```
sbatch <script>
```

### List queued/running jobs belonging to a user:
```
squeue -u <username>
```

### Cancel a job:
```
scancel <job-id>
```

### Get information on partitions and nodes
```
sinfo
```
---

# Job scripts (pure MPI)

```
#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
# not required if you have set a default allocation
#SBATCH -A snicYYYY-X-XX

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p main

# 10 hours wall-clock time will be given to this job
#SBATCH -t 10:00:00

# Number of nodes
#SBATCH --nodes=4

# Number of MPI processes per node
#SBATCH --ntasks-per-node=128

# Loading modules needed by your job
module add X
module add Y

# Run the executable named myexe
# and write the output into my_output_file
srun ./myexe > my_output_file
```

---

# Partitions

* Nodes are logically grouped into partitions
* There are four partitions that can be used on Dardel
  - **main**: Thin nodes (256 GB RAM), whole nodes, maximum 24 hours job time
  - **long**: Thin nodes (256 GB RAM), whole nodes, maximum 7 days job time
  - **shared**: Thin nodes (256 GB RAM), job shares node with other jobs, maximum 24 hours job time
  - **memory**: Large/Huge/Giant nodes (512 Gb - 2 TB RAM), whole nodes, 24 hours job time


---

# Job scripts (MPI + OpenMP)

```
#!/bin/bash -l
# The -l above is required to get the full environment with modules

# Set the allocation to be charged for this job
#SBATCH -A snicYYYY-X-XX

# The name of the script is myjob
#SBATCH -J myjob

# The partition
#SBATCH -p main

# 10 hours wall-clock time will be given to this job
#SBATCH -t 10:00:00

# Number of Nodes
#SBATCH --nodes=4

# Number of MPI tasks per node
#SBATCH --ntasks-per-node=16
# Number of logical cores hosting OpenMP threads. Note that cpus-per-task is set as 2x OMP_NUM_THREADS
#SBATCH --cpus-per-task=16

# Number and placement of OpenMP threads
export OMP_NUM_THREADS=8
export OMP_PLACES=cores

# Run the executable named myexe
srun ./myexe > my_output_file
```

---

# Exercise 1: Basic SLURM commands

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

---

# Exercise 1

* You can find the code from the previous slide [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/hello_mpi.c)

* Save the file on Dardel, compile the code and generate a binary called *hello_mpi*

---



# Exercise 1

* Take the job script that you can find [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/exercise1.sh) and modify it accordingly to:
   - Use the proper allocation required, for this course it is *edu23.sf2568*
   - Use one node for the job
   - Use 4 cores from that node


---

# Exercise 1

* Submit this script using **sbatch**

* Check the queue using **squeue -u <your_username>**
   - What's the ID of the job?
   - Is it already running? If so, which node was allocated for the job?

* Once the job finishes check the job output. Where is it saved?

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

However, we don't need to specify those flags because SLURM takes the *-N* and *-n* values from the *BATCH* directives in the script

---

# Exercise 1

* Use **sinfo** to check the partitions
  - How many different partitions are defined? What are their names?
  - What's the partition with the highest number of nodes?
  - Name 1-2 nodes included in that same partition

---
# Interactive jobs

Request an interactive allocation
```
salloc -A <allocation> -t <d-hh:mm:ss> -p <partition> -N <nodes> -n <cores>
```

Once the allocation is granted, a new terminal session starts (typing exit will stop the interactive session)
```
srun -n <number-of-processes> ./mybinary.x
```
It is also possible to ssh into one of the allocated nodes.

---
# Interactive jobs

We can check what nodes have been granted with:

  ```
  squeue -u $USER
  ```

  or inspecting the environment variable:
  ```
  SLURM_NODELIST
  ```

---

# SLURM advanced commands

<!-- ### To get further information about a job:
```
scontrol show job <jobid>
```
-->

### Get detailed information of a running job:
```
sstat --jobs=<your_job-id>
```

### Filter the information provided by sstat
```
sstat --jobs=your_job-id --format=JobID,aveCPU,MaxRRS,NTasks
```

**Tip:** Use *sstat -e* to see all possible fields for the *format* flag

---

# SLURM advanced commands

### To get information on past jobs:
```
sacct
```

### Get detailed information of a certain job:
```
sacct --jobs=<your_job-id> --starttime=YYYY-MM-DD
```
```
sacct --starttime=2019-06-23 --format=JobName,CPUTime,NNodes,MaxRSS,Elapsed
```

---

# SLURM advanced commands

### Quick performance summary for a finished job:
```
seff <jobid>
```

---

# Common reasons for inefficient jobs

* Not all nodes allocated are used
* Not all cores within a node are used (if it's not intentional)
* Many more cores than the available are used
* Inneficient use of the file system
* Using the wrong partition

---

# Exercise 2

* In this exercise we are going to use some more advanced SLURM commands to explore job performance.

* You will:
   - Create and compile a simple MPI program
   - Submit it to the queues
   - Check job data using sacct


---

# Exercise 2

* You can find the sample code for this exercise [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/vector_mpi.c)

* Compile the code and generate a binary called *vector_mpi*

---


# Exercise 2

* You can find the job script for this exercise [here](https://github.com/PDC-support/pdc-intro/blob/master/SLURM_exercises/exercise-2.sh)

* Save the script on Dardel and submit the job. Once the job finishes check its output.

* Inspect the job performance data using **sacct**
   - Use: -j <job-id> --format=JobID,JobName,Elapsed,ReqMem,MaxRSS

     **Tip**: use flag "--unit=M" to see memory units in MB

---

# Exercise 2

* Use the **seff <job-id>** command for quick job efficiency overview.  

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
  
---

# Job arrays

When we have several similar jobs that can be packed within a single job

```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:10:00

for i in $(seq 0 9); do
        srun -n 1 myprog $i
done
```

---
# Job arrays
```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:01:00
#SBATCH -a 0-9

srun -n 1 myprog $SLURM_ARRAY_TASK_ID
```

\$SLURM_ARRAY_TASK_ID contains a number 0-9 identifying each job in the array (defined with -a)

**Note:** Too many short jobs is bad for performance and can slow down the whole queue system. Ideally each job should be at least 10 minutes long.

---
# Job arrays

Once submitted, the job array gets a job id assigned that can be used to manipulate all jobs at once:
```
> sbatch job_array.sh
Submitted batch job 6975769
> scancel 6975769
```

For more info on job arrays check the SLURM website:
https://slurm.schedmd.com/job_array.html

---

# Packing short jobs

Several short jobs can be packed together into a single job where they run serially

```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:10:00

for arg in "$@"; do
        srun -n 1 myprog $arg
done
```

The job is submitted with:
```
sbatch packed_job.sh x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
```

---
# Using fewer cores

Reduce the number of cores used per job and run multiple instances of the job in a single node

```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:01:00

export OMP_NUM_THREADS=32

srun myprog $1
```

---

# Using fewer cores

```
#!/bin/bash -l
#SBATCH -A project
#SBATCH -N 1
#SBATCH -t 00:08:00

export OMP_NUM_THREADS=4

srun ./inner.sh "$@"
```

```
#!/bin/bash

for arg in "$@"; do
        myprog $arg &
done

wait
```
  
---

# Good SLURM practices

* Avoid too many short jobs
* Avoid massive output to STDOUT
* Try to provide a good estimate of the job duration before submitting

