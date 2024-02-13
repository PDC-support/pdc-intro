---
marp: true
backgroundImage: url('img/kth_background.png')
style: |
  section h1 {
    text-align: center;
    }
  .column50 {
    float: left;
    width: 45%;
    border: 20px solid transparent;
    background-color: transparent;
    }
  .columnlightblue {
    border: 10px solid #b6e0ff;
    background-color: #b6e0ff;
    box-shadow: 10px 10px 10px #888888;
    margin-top: 20px;
    margin-left: 20px;
    }
  .columnblue {
    border: 10px solid #99c0ff;
    background-color: #99c0ff;
    box-shadow: 10px 10px 10px #888888;
    margin-top: 20px;
    margin-left: 20px;
    }
  .columndarkblue {
    border: 10px solid #77a0ff;
    background-color: #77a0ff;
    box-shadow: 10px 10px 10px #888888;
    margin-top: 20px;
    margin-left: 20px;
    }
  .row:after {
    display: table;
    clear: both;
    }
  img[alt~="center"] {
    display: block;
    margin: 0 auto;
    }
---
<!-- paginate: true -->

# Singularity exercises

# Henric Zazzi
![height:200px center](img/singularity/SingularityLogos_CE.png)

---

# Exercise 1: Download a container

1. Go to singularity hub and find the hello-world container (https://singularityhub.github.io/singularityhub-archive/)
1. build the container using singularity
1. Use the container shell and get acquainted with it 

---

# Exercise 1: Answer

```
$ singularity build myhelloworld.sif shub://vsoch/hello-world
$ singularity shell myhelloworld.sif
Singularity> exit
```

---

# Exercise 2: Create your own container

1. Go to docker hub and find the official latest ubuntu
1. build the container using singularity
1. Build a writeable sandbox
1. Install necessary tools into the container (Compiler etc...)
   1. apt-get update
   1. apt-get install build-essential

---

# Exercise 2: Answer

```
$ singularity build --sandbox ubuntu_test docker://ubuntu:latest
$ sudo singularity shell -w ubuntu_test
Singularity> apt-get update
Singularity> apt-get install build-essential
Singularity> exit
```

---

# Exercise 3: Edit your own container

1. Create a help file
1. Create/Edit the runscript printing *Hello world!*

<span style="color:red;">**Tip:** You can use an editor in your VM or create it and then transfer the file</span>

---

# Exercise 3: Answer

```
$ singularity build --sandbox ubuntu_test docker://ubuntu:latest
$ sudo singularity shell -w ubuntu_test
Singularity> apt-get install nano
Singularity> cd /.singularity.d
Singularity> nano runscript.help
(Enter some text)
Singularity> nano runscript

#!/bin/sh
echo "Hello world!"

Singularity> exit
```

---

# Exercise 4: Create a recipe

1. Based on UBUNTU
1. Install compilers
1. Create a help text
1. Create a runscript
1. Run the recipe

<span style="color:red;">**Tip:** You can use the editor in your VM and then transfer the file</span>

---

# Exercise 4: Answer

See several examples at https://github.com/PDC-support/PDC-SoftwareStack/tree/master/other/singularity

Run them using...
```
sudo singularity build --sandbox [sandbox name] [recipe name]
```

---

# Exercise 5: Run a HPC container

1. Login into dardel.pdc.kth.se
1. send in a job for the hello-world sandbox
1. Use the hello_world in PDCs singularity repository

<span style="color:red;">**Tip:** With the singularity module use the **Path:** $PDC_SHUB</span>

---

# Exercise 5: Answer

```
#!/bin/bash -l
# The -l above is required to get the full environment with modules
# Set the allocation to be charged for this job
#SBATCH -A 202X-X-XX
# The name of the script is myjob
#SBATCH -J myjob
# Only 5 min wall-clock time will be given to this job
#SBATCH -t 5
# Number of nodes
#SBATCH --nodes=2
# Using the shared partition as we are not using all cores
#SBATCH -p shared
# Number of MPI processes per node
#SBATCH --ntasks-per-node=12
# Run the executable
ml PDC singularity
srun -n 24 --mpi=pmi2 singularity exec $PDC_SHUB/ubuntu/18.04_hello_world hello_world_mpi
```
* How to submit
```
$ sbatch <script>
```

---
