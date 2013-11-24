#!/bin/sh
echo "Runnig 5 jobs now !"
input="/user/idcuser/cs5531/input/testinput55.dat"
#echo $input
for ((  i = 1 ;  i <= 5;  i++  ))
do
  export HADOOP_CONF_DIR=/mnt/biginsights/opt/ibm/biginsights/hadoop-conf$i
  #echo $HADOOP_CONF_DIR
  echo "Launching Job No:$i"
  hadoop jar /mnt/biginsights/opt/ibm/biginsights/IHC/hadoop-0.20.2-examples.jar wordcount $input /user/idcuser/cs5531/output/output$(date +%Y%m%d%H%M%S%N) &
  #echo output$(date +%Y%m%d%H%M%S)

done
echo "Finished launching 5 jobs !"
