# !/bin/bash

#dijalankan di dir hasil3a

# !/bin/bash

#dijalankan di dir hasil3a
len=22
i=0
while [ "$i" -le "$len" ]
do
	if [[ $i -eq 0 ]]; then
		wget -O "kitten" -a Foto.log https://loremflickr.com/320/240/kitten
	else
		wget -O "kitten.$i" -a Foto.log https://loremflickr.com/320/240/kitten
	fi
	
	flag=0
    check=($(awk '/https:\/\/loremflickr.com\/cache\/resized\// {print $3}' ./Foto.log))
    length=(${#check[@]})
    for((j=0; j < ($length-1); j++))
    do
        if [ "${check[j]}" == "${check[$(($length-1))]}" ]
        then
            flag=1
            break
        fi
    done
    if [ $flag -eq 1 ]
    then
        len=$(($len - 1))
        if [[ $i -eq 0 ]]; then
        	rm "kitten"
        fi
        rm "kitten.$i"
    else
        i=$(($i + 1)) 
    fi
done

flag=1
for X in kitten*; do
  mv "$X" "Koleksi_$flag";
  flag=$(($flag+1));
done
