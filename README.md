# NP2

NP2 is a Nohup Jobs Manager

## Installation

### Install script

```sh
curl -o- https://raw.githubusercontent.com/vcinly/np2/master/install.sh | bash
```

or Wget:

```sh
wget -qO- https://raw.githubusercontent.com/vcinly/np2/master/install.sh | bash
```


```bash
Usage:

    np2 <options> <action> <command line>

  Available actions:

    np2 list|ls              # list all jobs
    np2 show                 # describe all parameters of a process id
    np2 start                # start a nohup job
    np2 pause|stop           # stop a process
    np2 resume               # resume a process
    np2 delete|kill          # kill job
    np2 restart              # not implementation
    np2 logs                 # stream logs file. Default stream all logs
    np2 update               # get latest version

  Available options:

    Warnning! The following options must in advance of action.

    np2 <options> start
        -h --help            # output usage information
        -n --name <name>     # set a <name> for job
        -l --log <path>      # specify entire log file (error and out are both included)
        -o --output <path>   # specify out log file
        -e --error <path>    # specify error log file

    np2 <options> logs
        --err                # only shows error output
        --out                # only shows standard output


  File of interest

    $HOME/.np2               # contain all np2 related files
    $HOME/.np2/logs          # contain all np2 logs
    $HOME/.np2/pids          # contain all np2 pids
    $HOME/.np2/app_list      # contain all np2 jobs
```
