#!/bin/bash

if [ $# -ne 1 ];
then
  echo "Usage: run_jobs <# of jobs>"
  exit
fi

hadoop fs -rmr /user/idcuser/output*

# change the number of entries depending on the number of jobs
priorityarray=( NORMAL LOW VERY_LOW HIGH HIGH NORMAL )
reducesarray=( 5 10 15 20 25 )

for ((i=0;i<${1};i++))
do
  # Assuming 20 maps and 5 reduces
  # you can change the priority
  echo "Jobid: " ${i} " Priority: " ${priorityarray[i]} " No Of Reduces: " ${reducesarray[i]}
  hadoop jar /home/idcuser/WordCount.jar org.apache.hadoop.examples.WordCount /user/idcuser/cs5531/input1/testinput1.dat /user/idcuser/cs5531/output/output$(date +%Y%m%d%H%M%S%N) 20 ${reducesarray[i]} ${priorityarray[i]} &
done
