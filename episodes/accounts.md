---

<!-- Section: Accounts, login, and file system -->

<!-- paginate: true -->

![bg 90% left](https://www.pdc.kth.se/polopoly_fs/1.1053343.1614296818!/image/3D%20marketing%201%20row%20cropped%201000pW%20300ppi.jpg)

# Account, Login and File System

2023-03-08

[PDC support documentation](https://www.pdc.kth.se/support)

---

# Getting a PDC account

* From [SUPR](https://supr.snic.se/)

    - Get a SUPR account
    - Join a project with time allocation on Dardel
        - PI: create proposal for small/medium/large allocation
        - collaborators: added to project by PI
    - Request a PDC account from SUPR

* From [PDC webpage](https://www.pdc.kth.se/support/documents/getting_access/get_access.html#course-account)

    - Attend a course or training event
    - Fill in the form and provide a copy of passport or national ID

---

# Time allocation (project)

* Unit: core-hours per month

* NAISS projects are managed in SUPR.

* Course/Workshop allocations are managed locally at PDC.

* Use ``projinfo`` to list the projects that you have access to.

---

# Login

![bg right:50% width:110%](https://pdc-web.eecs.kth.se/files/support/images/login.png)

* Method 1: Use Kerberos ticket
    - [Windows: PuTTY + NIM](https://www.pdc.kth.se/support/documents/login/windows_login.html)
    - [Linux: openssh-client](https://www.pdc.kth.se/support/documents/login/linux_login.html)
    - [macOS: homebrew-openssh-gssapi](https://www.pdc.kth.se/support/documents/login/mac_login.html)

* Method 2: Use SSH keys
    - Upload your public key in [PDC login portal](https://loginportal.pdc.kth.se/)

---

# Login with Kerberos ticket

* Edit ``/etc/krb5.conf`` on Linux/macOS

* ``kinit -f <your-username>@NADA.KTH.SE``
    - use NIM on Windows
    - use ``/usr/bin/kinit -f ...`` on macOS

* ``ssh -o GSSAPIDelegateCredentials=yes -o GSSAPIKeyExchange=yes -o GSSAPIAuthentication=yes <your-username>@dardel.pdc.kth.se``
    - use PuTTY on Windows
    - you can save SSH options in ``~/.ssh/config`` on Linux/macOS

---

# Login with SSH keys

* Generate SSH key pair
  ```
  ssh-keygen -t ed25519 -f ~/.ssh/id-ed25519-pdc
  ```
  - Create ``~/.ssh`` folder if it doesn't exist
    ```
    mkdir ~/.ssh && chmod 700 ~/.ssh
    ```

* Upload SSH public key in [PDC login portal](https://loginportal.pdc.kth.se/)

* Login using SSH key
  ```
  ssh -i ~/.ssh/id-ed25519-pdc <your-username>@dardel.pdc.kth.se
  ```

---

# Exercise: Log in to Dardel

---

# File System

Lustre File System (Klemming, total size 12 PB (12,000 TB))

* Open-source massively parallel distributed file system
* Optimized for handling data from many clients
* Home directory (25 GB quota, with backup)
  ```
  /cfs/klemming/home/[u]/[username]
  ```
* Project directory
  ```
  /cfs/klemming/projects/snic/[projectname]
  ```
* Scratch directory
  ```
  /cfs/klemming/scratch/[u]/[username]
  ```

---

# Exercise: Home and project directories

* Home directory
  ```
  cd && pwd
  ```
  or
  ```
  echo $HOME
  ```

* Project directory
  ```
  projinfo
  ```

---

# Find out your groups

In addition to ``projinfo``, your groups also indicate the projects that you have access to.

```
groups
```
* groups starting with ``cac-`` are associated with compute projects
* groups starting with ``pg_`` are associated with storage projects

---

# Find out your storage quota

```
projinfo
```

```
$HOME folder
Path: /cfs/klemming/home/u/user
Storage: ... GiB
Number of files: ...
```

```
Information for storage project: snicYYYY-X-XX (PI: ...)
...
Active from ... to ...
Members: ...
Max quota: ... GiB, ... files
Path: /cfs/klemming/projects/snic/...
Storage: ... TiB
Number of files: ...
```

---

# Use of file system

* Good practice
  - Minimize the number of I/O operations
  - Avoid creating too many files
  - Avoid creating directories with a large numbers of files
* Bad practice
  - Small reads
  - Opening many files
  - Seeking within a file to read a small piece of data

---

# Access Control Lists

### To view the access for a folder:
```
getfacl -a /cfs/klemming/home/u/user/test
```
### The output looks like this:
```
# file: /cfs/klemming/home/u/user/test
# owner: me
# group: users
user::rwx
group::r-x
other::---
```

---

# Access Control Lists

### To grant the access to another user (use "-R" for recursive):
```
setfacl -m u:<uid>:r-x /cfs/klemming/home/u/user/test
```
### To remove the access for another user (use "-R" for recursive):
```
setfacl -x u:<uid> /cfs/klemming/home/u/user/test
```

