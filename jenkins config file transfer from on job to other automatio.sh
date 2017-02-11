#!/bin/bash
# assumes folder is created and job does not exist
set -e
set -x

FROM="http:jenkins-server1"
fromUsername="userID"  #"admin"
fromAPIToken="APIToken number"
fromCreds="$userID:$fromAPIToken"


TO="https://jenkins-server2" 
toUsername="userID"
toAPIToken="APIToken" 
toCreds="$userID:$toAPIToken"

project="Project name"    
jobs="job_name" 

for job in $jobs ; do
 getMe="$FROM/job/folder/job/folder/job/$project/job/$job/config.xml"
 curl --insecure -X GET -u $fromCreds "$getMe" 1> $job.xml 2> err.log
 curl -H "Content-Type: application/xml" \
   --insecure \
   -X POST \
   -u $toCreds \
   --data-binary @${job}.xml "$TO/job/folder/job/folder/job/$project/createItem?name=$job"
done