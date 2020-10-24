#!/bin/bash
#LE0MX

if [ $1 == ""]
then
echo "How to use : ./sub_finder.sh <Domain> <main domain> <result folder  name>"
echo "Ex : ./sub_finder.sh domain.com domain scope"
else
wget $1 && mkdir result_$3 |cat index.html | grep href | cut -d ":" -f 2 | cut -d "/" -f 3 | grep "$2"| cut -d '"' -f 1 | grep -v '$1' | uniq >> sub.txt


for sub in $(cat sub.txt)
do
if [[ $(ping -c 1 $sub 2> /dev/null ) ]]
then
echo "$sub ++++++ pingo"
echo $sub >> valid_sub.txt
else
echo "$sub ------ Error"
fi
done

for ip in $(cat valid_sub.txt)
do
host $ip | cut -d " " -f 4|grep "." |uniq  >> ips.txt 
done

mv ips.txt sub.txt valid_sub.txt index.html  result_$3

echo "Done"
fi

