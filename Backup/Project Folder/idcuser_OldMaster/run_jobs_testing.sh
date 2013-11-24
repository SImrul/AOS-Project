#!/bin/bash
# Praveen Rao, UMKC

if [ $# -ne 1 ];
then
  echo "Usage: run_jobs <# of jobs>"
  exit
fi


# change the number of entries depending on the number of jobs
priorityarray=( NORMAL VERY_HIGH NORMAL VERY_LOW NORMAL HIGH NORMAL LOW )
reducearray=( 8 8 5 5 3 3 6 6 )
maparray=( 20 20 20 20 20 20 20 20 )
inputarray=( i0 i1 i2 i3 i4 i5 i6 i7 i8 )
outputarray=( o0 o1 o2 o3 o4 o5 o6 o7 o8 )

TESTINPUT=testinput.dat
# create local input files
if [ -f ${TESTINPUT} ]
then
  echo ${TESTINPUT} " is present. Ok to proceed."
else
  echo ${TESTINPUT} "is not present in the current directory. Copy from Blackboard."
  exit
fi

cp ${TESTINPUT} temp
cat /dev/null > larger
for ((i=0;i<${1};i++))
do
  cat temp >> larger
  cp larger i${i}
done

# setup the input files
for ((i=0;i<${1};i++))
do
  hadoop fs -copyFromLocal i${i} /user/idcuser/i${i} 
  hadoop fs -rmr /user/idcuser/o${i}
done

# run the jobs
for ((i=0;i<${1};i++))
do
  echo "Jobid: " ${i} " Priority: " ${priorityarray[i]} " Maps: " ${maparray[i]} " Reduces: " ${reducearray[i]}
  hadoop jar /home/idcuser/WordCount.jar org.apache.hadoop.examples.WordCount /user/idcuser/i${i} /user/idcuser/o${i} \
	${maparray[i]} ${reducearray[i]} ${priorityarray[i]} &
done
