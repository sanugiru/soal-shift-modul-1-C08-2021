# !/bin/bash

#dijalankan di dir hasil3a

exec &> Foto.log
for i in {1..23}
do
	wget "https://loremflickr.com/320/240/kitten"
done

declare -A arr
shopt -s globstar

for file in **; do
  [[ -f "$file" ]] || continue
   
  read cksm _ < <(md5sum "$file")
  if ((arr[$cksm]++)); then 
    rm "$file"
  fi
done


flag=1
for X in kitten*; do
  mv "$X" "Koleksi_$flag";
  flag=$(($flag+1));
done
