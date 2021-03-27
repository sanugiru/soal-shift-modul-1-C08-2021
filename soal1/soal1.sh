#a
cut -d":" -f 4 syslog.log
list=($(cut -d ":" -f 4 syslog.log))

#b
grep ERROR syslog.log | cut -d ":" -f4 | cut -d"(" -f1 | cut -d" " -f3-8 | sort | uniq -c | sort -nr 

#c
echo "ini ERROR"
grep ERROR syslog.log | rev | cut -d"(" -f1 | rev|  cut -d")" -f1 | sort | uniq -c 
echo "ini INFO"
grep INFO syslog.log | rev | cut -d"(" -f1 | rev|  cut -d")" -f1 | sort | uniq -c
