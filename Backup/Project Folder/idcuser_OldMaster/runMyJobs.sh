#!/bin/sh
echo "Runnig 5 jobs now !"
input="/user/idcuser/cs5531/input/testinput"
job=0
for i in 6 8 2 5 1
do
  job=$(echo $job+1 | bc)
  echo "Launching Job No:$job with Reduces:$i"
  hadoop jar /mnt/biginsights/opt/ibm/biginsights/IHC/hadoop-0.20.2-examples.jar \
  wordcount -Dmapred.reduce.tasks=$i /user/idcuser/cs5531/input/testinput$job.dat \
  /user/idcuser/cs5531/output/output$(date +%Y%m%d%H%M%S%N) &
done
echo "Finished launching 5 jobs !"
