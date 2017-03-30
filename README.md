## Dockerized DVWA

This repo holds only a few files. But those files are pretty handy dandy.
The idea is to provide a simple way to spool up an instance of [DVWA](https://github.com/ethicalhack3r/DVWA) for toying around with to keep them h@ck3r sk!11z 1337... sorry.

```
__/\\\\\_____/\\\__/\\\\\\\\\\\\\\\_____/\\\\\\\\\_____/\\\\\\\\\\\\\\\_______/\\\\\_________________________/\\\____/\\\_____        
 _\/\\\\\\___\/\\\_\/\\\///////////____/\\\\\\\\\\\\\__\///////\\\/////______/\\\///\\\______________________/\\/\\__\///\\\___       
  _\/\\\/\\\__\/\\\_\/\\\______________/\\\/////////\\\_______\/\\\_________/\\\/__\///\\\___________________/\\\//\\___\//\\\__      
   _\/\\\//\\\_\/\\\_\/\\\\\\\\\\\_____\/\\\_______\/\\\_______\/\\\________/\\\______\//\\\_________________\//__\//_____\//\\\_     
    _\/\\\\//\\\\/\\\_\/\\\///////______\/\\\\\\\\\\\\\\\_______\/\\\_______\/\\\_______\/\\\____________/\\\_______________\/\\\_    
     _\/\\\_\//\\\/\\\_\/\\\_____________\/\\\/////////\\\_______\/\\\_______\//\\\______/\\\____________\///________________/\\\__   
      _\/\\\__\//\\\\\\_\/\\\_____________\/\\\_______\/\\\_______\/\\\________\///\\\__/\\\_________________________________/\\\___  
       _\/\\\___\//\\\\\_\/\\\\\\\\\\\\\\\_\/\\\_______\/\\\_______\/\\\__________\///\\\\\/________________/\\\____________/\\\/____ 
        _\///_____\/////__\///////////////__\///________\///________\///_____________\/////_________________\///____________\///______
```

### Whatchu gon' need
- Linux (of some kind)
- Docker `apt-get install docker.io`
- a computer might be useful to have as well... :D

You could probably run this on windows, but you won't have use of the init.sh script, which is probably fine
as it only marginally makes the process easier and in some cases probably makes it harder.

### How to get going on your way
- run `./ddvwa` to build the docker container which will contain DVWA.
 - you may need to configure the container to use your organizations DNS server, for example on some univeristy networks
   docker won't be able to reach out to the net to get deps to build your container
 - ex: `./ddvwa -d 152.13.18.154 -r` to run it nicely
- now run `./ddvwa -r` to actually start the container up.

### Some notes on ddvwa script
- I really didn't test many combinations of the arguments, so some combinations/permutations might not work as expected.
- View the source before using it to make sure you're cool with what it does ("you should do this before running any scripts, really).

#### USAGE:
``` sh
ddvwa [-h] [-r] [-d ipv4addr] [-b]
          -h : Display this help
          -r : run the docker image
          -d ipv4addr : set the docker deamon DNS option
          -b : force a rebuild
          -c : restore the default DNS settings
```
