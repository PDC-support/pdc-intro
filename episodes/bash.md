---

<!-- Section: Using Bash shell -->

# Using Bash shell
## Introduction for beginners
### Tor Kjellsson Lindblom
---
## How can I run my program on Dardel?
### Content (minimal prerequisites)
* Bash shell and basic commands
* Files and Folders
* Input/output
* File/directory permissions
* Environment variables


### Bonus material for self-studying
* Processes (including programs)
* Searching in text
* Finding files
* Hotkeys
* File archiving

---
### What is a shell?
* What you get when the terminal window is open

* A "layer" (shell) around the operating system

* **Frequently used to interact with remote systems, such as Dardel**

* Multiple types of shells exist - this is about **bash shell**

* This presentation contains the very basics with hands-on exercises and type-alongs.

* **No need to finish all exercises now**.

---
### Getting a bash shell
* Linux and Mac users - just open a terminal window (or login to Dardel)
* Windows users - please login to Dardel.
---
### Your very first commands (type along)
Explore the following commands, one at a time.

```
pwd                 (print work directory)
ls                  (list files)
ls -l               (+ extra flag)
mkdir bash_tutorial (create directory)
cd bash_tutorial    (change directory)
cd ..               (cd one step above current directory)
wget  https://swcarpentry.github.io/shell-novice/data/shell-lesson-data.zip (download file from specified location)
unzip shell-lesson-data.zip
```
The last two lines downloads and extracts tutorial material we have borrowed from Software Carpentry
https://carpentries.org/

---
### Exercise 1 (3 min)
```
$ ls -l shell-lesson-data
* Move back and forth into the subdirectories
* Move into exercise-data and type
$ cp numbers.txt numbers_copy.txt
```
verify that the new file was created.
 **NB! Do not use whitespace in file/folder names.**

```
* Create a new directory with some name. Then type:
$ mv numbers_copy.txt your_new_folder/.
* what happened?
```
---
### Exercise 2: Some more commands (5 min)

```
cp -r dir1 dir2   (copy directory, NB "-r")
man ls            (prints manual for ls)
rm file_example   (remove file_example (careful! can not be undone))
history           (prints command line history)
cat file_example  (print all contents of file)
less file_example (view contents of file in pager)
head file_example (print first lines of file)
tail file_example (print last lines of file)

* Copy an existing directory
* Display "numbers_copy.txt" in some way
* Print your command line history
* Open manual for the command ls and then
- press up/down keys to scroll
- Type / to start search mode
- Search for the flag: -F
- Type q to quit
```
---
### Relative vs. absolute paths
You can specify a location in two ways:

```
(Relative)            
cd exercise_data    

(Absolute)
cd /home/tkl/shell-lesson-data/exercise-data
```
Both ways are useful. Determine which is best for the situation at hand.
---

### Text editors
Very good idea to master at least one (non-graphical) editor in the terminal.

List of common editors:

* nano - easiest, minimal functionality
* vi/vim - a bit more involved, but more functionality
* emacs - even a bit more involved, but a lot of functionality
* HOMEWORK: get used to one text editor.
---

### Input & Output: redirect and pipes
* Programs can display something, e.g. **"echo hello world"**

* Programs can take input, e.g. **less**

* $ cat numbers_copy.txt

 dumps contents of numbers_copy.txt to *stdout*

* $ cat numbers_copy.txt | less

 gives the text as input to *less* (i.e. pipe it)
---
### Try it: pipes (3 min)
```
# what sessions are logged in?
$ w

# count number of sessions
$ w -h | wc -l

# list all matching commands
$ history | grep -w 'ls'

# print the name of the newest file in the directory (non-dot)
$ ls -1tF | grep -v -E '*/|@' | head -1

```
---
### Redirects
* Like pipes, but data is sent to/from files and not processes

* Replace a file:

 command > file.txt

* Append to a file:

 command >> file.txt (be careful to **not** mix them up!)

* Redirect file as STDIN:

 command < file (in case program accepts STDIN only)

---
### Try it: Redirects (3 min)
```
$ echo Hello World > hello.txt

$ ls -lH >> current_dir_ls.txt

# join two files (e.g. the two above) into one
$ cat file1 file2 > file3

# go through file1 and replace spaces with a new line mark, then output to file2
$ tr -s ' ' '\n' < file1 > file2

# -or- in more readable format
$ cat file1 | tr -s ' ' '\n' > file2
```
---
### File/directory permissions
#### The basics
Important to set access permission on shared objects

```
Example
$ ls -l exercise_data

drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 proteins
-rw-rw-r-- 1 tkl tkl   13 sep 16  2021 numbers.txt
drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 animal-counts
drwxrwxr-x 2 tkl tkl 4096 sep 16  2021 creatures
drwxrwxr-x 2 tkl tkl 4096 sep 28 12:23 writing

```
Tell you who can: **r**ead, **w**rite and e**x**ecute a file/list a directory

*d* is for directory - then 3 groups of triple fields: user, group, others

---
#### Basic file permission manipulation
```
chmod u+rwx fileA      (add read, write, execute rights to fileA for user)

chmod o+r fileA        (add read permission for others)       

chmod o-wx fileA       (remove write and execectue for others)

chmod -R <perms> <dir> (recursively apply permission changes on all of dir)

chgrp group_name fileA (change group ownership)

chown -R folder        (Change owner of folder)

```
**NB: On Dardel, we also use ACLs (next slide)**

---
#### Access control lists (ACLs)
```
* On Lustre (Klemming) we use more advanced access permissions.

* Normal unix permission have only one owner and group.
 With ACLs, this restriction is lifted.

* ACLs are controlled via getfacl and setfacl.

$ getfacl file                   (get current stage)
$ setfacl -m u:<user>:r file    (Allow read access for user)
```

In many support cases we ask users to apply the last line so we can access files.

---
### Environment variables
Defined text strings that your programs may use

```
* In the shell, these variables define your environment
* Common practice: capital letters, e.g. $HOME, $PATH, $OMP_NUM_THREADS
* List all defined variables with printenv

Try it:
$ echo $HOME
$ echo $HOSTNAME
$ echo $PATH
```

---
## Bonus material
* Processes (including Programs)
* Initialization and configuration
* Finding files and text patterns within files
* Hotkeys
* File archiving

 [Jump to next section](#68)

 ---
 ### Processes [bonus slide]
 Uptil now we only discussed files/folders.
 But we also want to run **programs.**
 * All running programs and commands are *processes*
 * Processes have:
   * Process ID, NAME, Command line arguments
   * input and output, Return code (integer) when complete
   * Working directory, Environment variables
 * These concepts bind together all UNIX programs
 * To see some runnings processes, type *top*

 ---
 ### Foreground and background processes [bonus slide]

 **Foreground**

  * Example: *top*
  * Keyboard is connected as input, screen to output.
  * Only one such process active at a time.
  * Kill it: Ctrl-c

 **Background**
  * No input connected
  * You can have as many as resources allow
  * Add an *&* after a command to put it in background
  * To kill: use *kill* or *pkill*, or do it from within *top*

 ---
 ### Foreground and background processes [bonus slide cont]

  ```
  Example:
  ./my_prog.ex
  ./my_prog.ex 1> output.txt 2>error.txt &

  ```

 **NB: You will most likely not use Dardel like this, but it is possible to do so by logging into a compute node.**


---
### Exercise: some more redirects [bonus slide]
```
* Step into the data-shell folder
* Type history
* Type history > history.txt
* Type ls -l and then check time stamp of history.txt
* Print the last 4 lines of history.txt using the tail command
(explore the manpage if needed)
* Instead of creating an intermediate file, find a more clever
way to print the last 4 commands by piping history into tail
```
---
### Initialization and configuration [bonus slide]
* When the shell first starts (e.g. at login) it reads shell config files.

* The config files give you power to customize your shell to your liking.

* You can always manually test things in an open shell before putting it in the config files (recommended!)

Config files are located in $HOME and are called:

 * .bashrc
 * .bash_profile

---
#### Example to try [bonus slide]
```
* Try to customize your shell to your liking. It can for instance be
- define some environmental you will often used
- get certain color scheme
- get date and time information when typing the command history
```

---

### Findings patterns in files: grep  [bonus slide]
This command is for searching keyword inside files.

```
grep <pattern> <filename>  # grep lines that match <pattern>
 -or-
command | grep <pattern>  # grep lines from stdin

```
---
### Exercise 5 [grep]  [bonus slide]
```
* Go back to the data-shell directory
* Type grep rabbit exercise-data/animal-counts/animals.csv
* Try finding all occurences of the string “rabbit” using
recursive search (adding the -R flag)

grep + pipes:
* Make a pipe that displays all files ending with "pdb" in the
 data-shell directory.

```
---


### Finding things [bonus slide]
Command: *find*

```
# search for pentane.pdb in current directory
find . -name pentane.pdb

# one can search more than one dir at once
find . /cfs/klemming/nobackup/u/username -name pentane.pdb

```

---
### Exercise 5 [bonus slide]

Bonus (for interested to do later):

* On a Lustre system, *lfs find* is faster. Same syntax.

* On a workstation: *locate* may be useful. Read manual for information.


* Type find . -name animals.csv.

* Type find . -name *.pdb

* Make a pipe that counts number of files/directories in the
 data-shell directory.

* Count unique logged in users on Dardel.

Tip: **w** or **users** give you a list of all currently login users,
many of them have several sessions open.

Tip: You may have to use **uniq**, **tr -s**, **cut -f 1 -d " "**, and **wc -l**

---

### Hotkeys [bonus slide]
* Shortcuts
* Most important key: **tab** for autocompletion
* You should never type full filenames or command names - **tab** can complete almost anything.

---
Some common commands
```
TAB            (autocompletion)
Home/Ctrl-a    (move to start of command line)
End/Ctrl-e     (move to end)
up/down        (traverse command history)
Ctrl-l         (clear the screen)
Ctrl-Shift-c   (copy)
Ctrl-Shift-v   (paste)
Ctrl-r         (command history search: backwards)

```
---
### Exercise 6 [bonus slide]
#### TAB autocompletion

We will here display contents of a file using its full path, but try to type as few characters as possible.

First find your absolute path to "numbers.txt"
```
* Type find $HOME -name numbers.text
Say the path was /home/tkl/shell-lesson-data/exercise-data/numbers.txt

* Type cat /home/tk and then start hitting TAB.
 Add characters when needed to reach full path.
(use your own path)
```


---
### File archiving [bonus slide]
```
# create tar archive gzipped on the way
tar -caf archive_name.tar.gz dir/

# extract files
tar -xaf archive_name.tar.gz -C /path/to/directory
```

* *tar* is the standard tool to save many files or directories into a single archive
* Archive files may have extensions .tar, .tar.gz etc depending on compression used.
* "f" is for filename, "a" selects compression based on suffix
* With no compression, files are simply packed
* "r" will append files to end of archive, "t" will list archive
* Individual files can be compressed directly with e.g. gzip. (gzip file, gunzip file.gz)

---
### Exercise 7 [bonus slide]
```
* Make a tar.gz archive of shell-lesson-data
* Make a tar archive, compare sizes
* List the files inside the archive
```
