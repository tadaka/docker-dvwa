#!/bin/bash
# uncg DNS = 152.13.18.154

# get DVWA
USAGE="init.sh [-h] [-r] [-d ipv4addr] [-b]
          -h : Display this help
          -r : run the docker image
          -d ipv4addr : set the 
          -b : force a rebuild
          -c : restore the default DNS settings
      "
DVWA_URL=https://github.com/ethicalhack3r/DVWA/archive/master.zip
IMAGE="dvwa"
TAG="hack"
DOCKER_BUILD="docker build -t $IMAGE:$TAG ."
DOCKER_RUN="docker run -p 8080:80 -p 3306:3306 $IMAGE:$TAG"
RUN=NO
CLEANUP=NO
REBUILD=NO

# use getopts to handle the args
while getopts "hrd:bc" opt; do
  case $opt in
    h) 
      echo "$USAGE" >&2
      ;;
    r)
      # run the image
      RUN=YES >&2
      ;;
    d)
      # do some hacky stuff...
      # modify /etc/default/docker
      # must be root
      if [ "$EUID" -ne 0 ]
      then echo "This option must be run as root." >&2
        exit 1
      fi
      DNS=$OPTARG
      # should check if the file exists. too lazy for now
      cp /etc/default/docker /etc/default/docker_old 
      echo "DOCKER_OPTS=\"--dns $DNS\"" > /etc/default/docker
      echo "restarting docker service..."
      sleep 2
      systemctl restart docker.service
      ;;        
    b)
      echo "Forcing rebuild of container..." >&2
      REBUILD=YES
      ;;
    c)
      CLEANUP=YES
      ;;
    \?)
      echo "$USAGE" >&2
      exit 1
      ;;
  esac
done

# check if the container is already built
if [[ "$(docker images -q $IMAGE:$TAG 2> /dev/null)" == "" ]] || [[ $REBUILD == YES ]]; then
  # build the image
  eval $DOCKER_BUILD 
fi

if [[ $RUN == YES ]]; then
  eval $DOCKER_RUN
fi

if [[ $CLEANUP == YES ]]; then
  # must be root
  if [ "$EUID" -ne 0 ]
  then echo "This option must be run as root." >&2
    exit 1
  fi
  echo "restoring docker settings"
  cat /etc/default/docker_old > /etc/default/docker
  echo "default restored"
  cat /etc/default/docker
  echo "restarting docker daemon"
  systemctl restart docker.service
fi
