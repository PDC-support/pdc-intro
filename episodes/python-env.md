---

<!-- Section: Using Python virtual environment -->

# Using Python virtual environment

### Xin Li, Juan de Gracia

---

# Why Use a Virtual Environment?

* **Python packages are essential tools** that help us accomplish various tasks in programming. Examples include:
  ```
  import numpy
  from pandas import DataFrame
  import matplotlib.pyplot as plt
  ```
* **Projects have unique needs:** Different projects may require different versions of the same package, leading to conflicts.
* **Shared systems complicate package management:** On High-Performance Computing (HPC) platforms, multiple users' needs might clash due to different package requirements.

---

# Why virtual environment?

Without virtual environment, Python packages are installed globally:

* **System site directory:** Where Python is installed and accessible by all users.
  ```
  python3 -c 'import site; print(site.getsitepackages())'
  ```
* **User base directory:** A user-specific area to avoid needing system-wide permissions.
  ```
  echo $HOME/.local
  ```

---

# Exercise: Check python site directory

```
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

```
ml cray-python/3.9.13.1
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

```
ml PDC/23.03 anaconda3/2023.09-0
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

---

# Python virtual environment

* **What is a Virtual Environment?** An isolated environment allowing you to manage packages for individual projects without conflicts and without interfering with the outside world.
* **How to Manage Virtual Environments?**
    - Using Python's built-in `venv` module.
    - Using `conda`, a powerful package manager and environment manager.

---

# Virtual environment with ``venv``

* Recommendation: use with cray-python
  ```
  ml cray-python/3.9.13.1

  cd $HOME
  python3 -m venv myenv

  source myenv/bin/activate
  ```
  Your prompt changes to indicate the active environment:
  ```
  (myvenv) user@uan01:~>
  ```

---

# Virtual environment with ``venv``

* Check site-packages directory
  ```
  (myenv) user@uan01:~> python3 -c 'import site; print(site.getsitepackages())'
  ['/cfs/klemming/home/u/user/myenv/lib/python3.9/site-packages']
  ```

* Install a Python package
  ```
  (myenv) user@uan01:~> python3 -m pip install yapf

  (myenv) user@uan01:~> which yapf
  /cfs/klemming/home/u/user/myenv/bin/yapf
  ```

---

# Virtual environment with ``venv``

* Deactivate a virtual environment
  ```
  (myenv) user@uan01:~> deactivate
  user@uan01:~>
  ```

---

# Virtual environment with ``conda``

* Load anaconda3
  ```
  ml PDC/23.03 anaconda3/2023.09-0
  ```

* Initialize conda
  ```
  source conda_init_bash.sh
  ```

  ```
  (base) user@uan01:~>
  ```

---

# Virtual environment with ``conda``

* Content of ``conda_init_bash.sh``

    ```
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/pdc/software/23.03/eb/software/anaconda3/2023.09-0/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/pdc/software/23.03/eb/software/anaconda3/2023.09-0/etc/profile.d/conda.sh" ]; then
            . "/pdc/software/23.03/eb/software/anaconda3/2023.09-0/etc/profile.d/conda.sh"
        else
            export PATH="/pdc/software/23.03/eb/software/anaconda3/2023.09-0/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    ```

* ``conda init bash`` may append the above script to your ``~/.bashrc`` but this is not recommended on an HPC system.

---

# Virtual environment with ``conda``

```
(base) user@uan01:~> conda create --name my-conda-env

(base) user@uan01:~> conda activate my-conda-env

(my-conda-env) user@uan01:~>
```

---

# Virtual environment with ``conda``

* Now try the site-packages directory again
  ```
  (my-conda-env) user@uan01:~> python3 -c 'import site; print(site.getsitepackages())'
  ```
* Why is ``site-packages`` still under ``anaconda3``?
  ```
  ['/pdc/software/23.03/eb/software/anaconda3/2023.09-0/lib/python3.11/site-packages']
  ```

---

# Virtual environment with ``conda``

```
(my-conda-env) user@uan01:~> conda install python=3.9

(my-conda-env) user@uan01:~> python3 -c 'import site; print(site.getsitepackages())'
['/cfs/klemming/home/u/user/.conda/envs/my-conda-env/lib/python3.9/site-packages']
```

---

# Virtual environment with ``conda``

```
(my-conda-env) user@uan01:~> conda deactivate
(base) user@uan01:~>
```

---
# Working with Jupyter Notebooks
- Disclaimer: Jupyter notebooks can be run trough Thinlinc. 
- Make sure you have installed jupyter notebooks in your conda environment:
```
conda install jupyterlab
```
- Then start a Jupyter notebooks without browser:
```
jupyter-notebook 
```
**Important:** Do not run a Jupyter notebook in the login node, instead get an interactive node allocation:
```
salloc --nodes=<n> -t 1:00:00 -A <project>
```


