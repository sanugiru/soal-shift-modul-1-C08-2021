#a
cut -d":" -f 4 syslog.log

#b
grep ERROR syslog.log | cut -d ":" -f4 | cut -d"(" -f1 | cut -d" " -f3-8 | sort | uniq -c | sort -nr 

#c
echo "ini ERROR"
grep ERROR syslog.log | rev | cut -d"(" -f1 | rev|  cut -d")" -f1 | sort | uniq -c 
echo "ini INFO"
grep INFO syslog.log | rev | cut -d"(" -f1 | rev|  cut -d")" -f1 | sort | uniq -c

#d
echo "Error,Count" > error_message.csv
jenis=`grep ERROR syslog.log | cut -d ":" -f4 | cut -d"(" -f1 | cut -d" " -f3-8 | sort | uniq`
reg=`grep ERROR syslog.log | cut -d ":" -f4 | cut -d"(" -f1 | cut -d" " -f3-8`
while read x
do
	counter=`echo "$reg"|sort | grep -c "$x"`
	hasil=`printf "$hasil\n$x,$counter"`
done<<<`printf "$jenis"`
hasil=`echo "$hasil" | sort -rnk2t',' `
printf "$hasil" >> error_message.csv

#e
echo "Username,INFO,ERROR" > user_statistic.csv
nama=`cut -d":" -f 4 syslog.log | rev | cut -d"(" -f1 | rev | cut -d")" -f1| sort | uniq`
reg=`cut -d":" -f 4 syslog.log | rev | cut -d"(" -f1| rev | cut -d ")" -f1|sort`
while read y
do
	error=`cut -d":" -f4 syslog.log | grep "$y" | grep -c "ERROR"`
	info=`cut -d":" -f4 syslog.log | grep "$y" | grep -c "INFO"`
	stat=`printf "$y,$info,$error\n"`
	hasilstat=`printf "$hasilstat\n$stat"`
done <<< `printf "$nama"`
printf "$hasilstat" >> user_statistic.csv
