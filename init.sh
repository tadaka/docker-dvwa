#!/bin/bash

# get DVWA
DVWA_URL=https://github.com/ethicalhack3r/DVWA/archive/master.zip
wget $DVWA_URL 

# unzip DVWA
unzip master.zip
mv DVWA-master/ dvwa/
