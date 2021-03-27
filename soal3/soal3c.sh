#!/bin/bash


cd /home/deka/Documents/SISOP/modul1/soal3/output

flag_kucing=0
for i in x*;
do
	flag_kucing=$(($flag_kucing+1));
done

flag_kelinci=0
for i in y*;
do
	flag_kelinci=$(($flag_kelinci+1));
done


# echo $flag_kucing
# echo $flag_kelinci


exec &> Foto.log
if [[ $flag_kucing -le $flag_kelinci ]];
then
	flag=1
	for i in {1..23}
	do
		wget "https://loremflickr.com/320/240/kitten"
	done

	for X in kitten* 
	do
		mv "$X" "Koleksi_$flag";
  		flag=$(($flag+1));
  	done
  	mkdir ~/Documents/SISOP/modul1/soal3/solve/Kucing_$(date +%d-%m-%Y)
	mv ~/Documents/SISOP/modul1/soal3/output/* ~/Documents/SISOP/modul1/soal3/solve/Kucing_$(date +%d-%m-%Y)
	touch ~/Documents/SISOP/modul1/soal3/output/x_"$flag_kucing"{1..2}.txt

else
	flag=1
	for i in {1..23}
	do
		wget "https://loremflickr.com/320/240/bunny"
	done
	
	for X in bunny* 
	do
  		mv "$X" "Koleksi_$flag";
  		flag=$(($flag+1));
  	done
  	mkdir ~/Documents/SISOP/modul1/soal3/solve/Kelinci_$(date +%d-%m-%Y)
	mv ~/Documents/SISOP/modul1/soal3/output/* ~/Documents/SISOP/modul1/soal3/solve/Kelinci_$(date +%d-%m-%Y)
	touch ~/Documents/SISOP/modul1/soal3/output/y_"$flag_kelinci"{1..2}.txt
fi
 
