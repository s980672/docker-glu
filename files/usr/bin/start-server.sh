#!/bin/bash

cd /
echo "Starting server..."
#python -m SimpleHTTPServer &
#sleep 2
#echo "done sleeping, starting nginx"
nginx
echo "nginx is started?"
echo $(ps -eaf | grep nginx)
while true; do echo -n '.'; sleep 30; done;
