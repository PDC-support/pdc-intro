---

<!-- Section: Using Python virtual environment -->

# Using Python virtual environment

### Xin Li

---

# Why virtual environment?

* We often need to use a number of Python packages
  ```
  import A
  from B import C
  import D as E
  ```
* When working with multiple projects, it is not uncommon that different projects have conflicting requirements of packages
* On HPC platform, different users may have conflicting needs of packages

---

# Why virtual environment?

Without virtual environment, Python packages are installed

* either in system site directory
  ```
  python3 -c 'import site; print(site.getsitepackages())'
  ```
* or in the so-called user base
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
ml cray-python/3.9.12.1
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

```
ml PDC/22.06 anaconda3/2021.05
which python3
python3 -c 'import site; print(site.getsitepackages())'
```

---

# Python virtual environment

* Isolated run-time environment
* Install and execute Python packages without interfering with the outside world
* Two ways of creating and managing virtual environment
    - ``venv``
    - ``conda``

---

# Virtual environment with ``venv``

* Recommendation: use with cray-python
  ```
  ml cray-python/3.9.12.1

  cd $HOME
  python3 -m venv myenv

  source myenv/bin/activate
  ```

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
  ml PDC/22.06 anaconda3/2021.05
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
    __conda_setup="$('/pdc/software/22.06/eb/software/anaconda3/2021.05/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/pdc/software/22.06/eb/software/anaconda3/2021.05/etc/profile.d/conda.sh" ]; then
            . "/pdc/software/22.06/eb/software/anaconda3/2021.05/etc/profile.d/conda.sh"
        else
            export PATH="/pdc/software/22.06/eb/software/anaconda3/2021.05/bin:$PATH"
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
  ['/pdc/software/22.06/eb/software/anaconda3/2021.05/lib/python3.8/site-packages']
  ```

---

# Virtual environment with ``conda``

```
(my-conda-env) user@uan01:~> conda install python=3.8

(my-conda-env) user@uan01:~> python3 -c 'import site; print(site.getsitepackages())'
['/cfs/klemming/home/u/user/.conda/envs/my-conda-env/lib/python3.8/site-packages']
```

---

# Virtual environment with ``conda``

```
(my-conda-env) user@uan01:~> conda deactivate
(base) user@uan01:~>
```

