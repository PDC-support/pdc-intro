---
marp: true
backgroundImage: url('assets/kth_background.png')
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
![height:200px center](assets/singularity/SingularityLogos_CE.png)

---

# Exercise 1

```
$ singularity build myhelloworld.sif shub://vsoch/hello-world
$ singularity shell myhelloworld.sif
Singularity> exit
```

---

# Exercise 2

```
$ singularity build --sandbox ubuntu_test docker://ubuntu:latest
$ sudo singularity shell -w ubuntu_test
Singularity> apt-get update
Singularity> apt-get install build-essential
Singularity> exit
```

---

# Exercise 3

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

# Exercise 4

See several examples at https://github.com/PDC-support/PDC-SoftwareStack/tree/master/other/singularity

Run them using...
```
sudo singularity build --sandbox [sandbox name] [recipe name]
```

---

# Exercise 5

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
