#!/bin/bash

cp $1 parsemap.txt

#If you would like to see filtered and closed ports
if [[ $2 == -closed ]]; then

	sed -i -E 's/tcp.*closed /tcp <font style=color:red>closed <font style=color:purple>/' parsemap.txt
	sed -i -E 's/udp.*closed /udp <font style=color:red>closed <font style=color:purple>/' parsemap.txt
	sed -i -E 's/tcp.*filtered /tcp <font style=color:red>filtered <font style=color:purple>/' parsemap.txt
	sed -i -E 's/udp.*filtered /udp <font style=color:red>filtered <font style=color:purple>/' parsemap.txt

else
	sed -i -E '/^[0-9].*closed|filtered.*/d' parsemap.txt 

fi

sed -i 's/^Nmap scan report for/#### <font style="color:pink">/g' parsemap.txt
sed -i 's/^# Nmap.*//g' parsemap.txt
#making the ports look nice
sed -i -E 's/^[0-9].*\/(tcp|udp)/##### <font style=color:orange>&/' parsemap.txt
sed -i -E 's/tcp.*open /tcp <font style=color:green>open<font style=color:purple>/' parsemap.txt
sed -i -E 's/udp.*open /udp <font style=color:green>open<font style=color:purple>/' parsemap.txt

#making script output in codeblock
sed -i '/^|/ s/$/ ```/' parsemap.txt
sed -i 's/^|/```&/' parsemap.txt
#sed -i 's/^|/<font style="color:pink">/' parsemap.txt
#removing empty lines
sed -i '/^$/d' parsemap.txt
#Removing output fluff
sed -i '/^#### /a " "' parsemap.txt
sed -i '/^" "$/,/^#### /{/^#####/!{/^|/!{/^```/!{/^<font/!{/^#### /!d}}}}}' parsemap.txt
mv parsemap.txt parsemap.md
