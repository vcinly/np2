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

### Jobs listing

![Jobs listing](https://github.com/vcinly/np2/raw/master/src/np2-list.png)


```bash
Usage:

    np2 <options> <action> <command line>

  Available actions:

    np2 list|ls               # list all jobs
    np2 show    <id|name>     # describe all parameters of a process id
    np2 start   <id|name>     # start a nohup job
    np2 pause|stop <id|name>  # stop a process
    np2 resume  <id|name>     # resume a process
    np2 delete|kill <id|name> # kill job
    np2 restart <id|name>     # not implementation
    np2 logs    <id|name>     # stream logs file. Default stream all logs
    np2 update                # get latest version
                              
  Available options:
                              
    Warnning! The following o ptions must in advance of action.
                              
    np2 <options> start
        -h --help             # output usage information
        -n --name <name>      # set a <name> for job
        -l --log <path>       # specify entire log file (error and out are both included)
        -o --output <path>    # specify out log file
        -e --error <path>     # specify error log file
                              
    np2 <options> logs
        --err                 # only shows error output
        --out                 # only shows standard output
        
  Basic Examples:

    Start an script
    $ np2 start ruby ./test/test.rb


  File of interest

    $HOME/.np2                # contain all np2 related files
    $HOME/.np2/logs           # contain all np2 logs
    $HOME/.np2/pids           # contain all np2 pids
    $HOME/.np2/app_list       # contain all np2 jobs
```
