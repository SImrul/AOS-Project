if [$1 -eq 0]
then
        echo "Enter No.of jobs"
else
for (( i = 1; i <= $1; i++ ))
do
        hadoop fs -rmr /user/idcuser/cs5531/output$i
        hadoop jar /mnt/biginsights/opt/ibm/biginsights/IHC/WordCount.jar org.apache.hadoop.examples.WordCount /user/idcuser/cs5531/testinput.dat /user/idcuser/cs5531/output$i 4 6 $i &
done
fi