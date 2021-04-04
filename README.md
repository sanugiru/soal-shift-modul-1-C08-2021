# Soal Shift Sisop Modul 1 C08 2021
Anggota:
- 05111940000112 Deka Julian Arrizki	    
- 05111940000141 Muhammad Farhan Haykal	
- 05111940000158 Shahnaaz Anisa Firdaus 	

## SOAL 1 
a) Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya

b) Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

c) Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

e) Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.

**_Pembahasan_**
- **NOMOR 1A**
  ```
  cut -d":" -f 4 syslog.log
  ```
   - fungsi cut bertujuan untuk memotong string yang awalnya berbentuk :  
     `<time> <hostname> <app_name>: <log_type> <log_message> (<username>)`  
     menjadi :  
     `<log_type> <log_message> (<username>)`  
     agar cut dapat berjalan dengan benar maka digunakanlah delimiter (-d) dan field (-f), dikarenakan adanya tanda ":" sebelum <log_type> maka delimiter di set ":" dan karenakan log_type merupakan field ke-4 maka digunakan -f 4

- **NOMOR 1B**
  ```
  grep ERROR syslog.log | cut -d ":" -f4 | cut -d"(" -f1 | cut -d" " -f3-8 | sort | uniq -c | sort -nr 
  ```
  - `grep ERROR` bertujuan untuk mendapatkan log_type hanya ERROR dalam syslog.
  - `cut -d":" -f4` bertujuan untuk menghilangkan pola string di belakang <log_type>
  - `cut -d"(" -f1` bertujuan untuk menghilangkan pola (<username>) pada string
  - `cut -d" " -f3-8` bertujuan untuk menghilangkan kata ERROR dan hanya menyisakan <log_message>
setelah hanya menyisakan <log_message>, hasil yang didapat di sort dan dihitung berdasarkan kesamaan <log_message> menggunakan `uniq -c` dan di sort secara descending berdasarkan jumlah kemunculannya dengan `sort -nr`

- **NOMOR 1C**
  ```
  echo "ini ERROR"
  grep ERROR syslog.log | rev | cut -d"(" -f1 | rev|  cut -d")" -f1 | sort | uniq -c 
  echo "ini INFO"
  grep INFO syslog.log | rev | cut -d"(" -f1 | rev|  cut -d")" -f1 | sort | uniq -c
  ```
  - `grep ERROR` bertujuan untuk mendapatkan log_type hanya ERROR dalam syslog.
  - `rev` digunakan untuk mereverse string
  - `cut -d"(" -f1 ` & `cut -d")" -f1` digunakan untuk mendapatkan <username>
  - setelah hanya menyisakan <username> makan username akan di sort dan dihitung berdasarkan kesamaanya menggunakan `uniq-c`
  - `grep INFO` bertujuan untuk mendapatkan log_type hanya INFO dalam syslog.
  - `rev` digunakan untuk mereverse string
  - `cut -d"(" -f1 ` & `cut -d")" -f1` digunakan untuk mendapatkan <username>
  - setelah hanya menyisakan <username> makan username akan di sort dan dihitung berdasarkan kesamaanya menggunakan `uniq-c`

- **NOMOR 1D**
  ```
  echo "Error,Count" > error_message.csv
  ```
  - membuat header file untuk erro_message.csv  
  ```
  jenis=`grep ERROR syslog.log | cut -d ":" -f4 | cut -d"(" -f1 | cut -d" " -f3-8 | sort | uniq`
  reg=`grep ERROR syslog.log | cut -d ":" -f4 | cut -d"(" -f1 | cut -d" " -f3-8`

  while read x
  do
		counter=`echo "$reg"|sort | grep -c "$x"`
		hasil=`printf "$hasil\n$x,$counter"`
  done<<<`printf "$jenis"`
  hasil=`echo "$hasil" | sort -rnk2t',' `
  printf "$hasil" >> error_message.csv
  ```
  - Variabel jenis adalah variabel yang menyimpan jenis error non repitisi, dan variabel reg adalah variabel yang menyimpan jenis error dengan repitisi. Untuk menghilangkan repetisi jenis error maka digunakan  `uniq` pada variabel jenis, selanjutnya kemunculan setiap jenis error akan dihitung di dalam variable counter, lalu variabel hasil digunakan untuk menyimpan `jenis error, jumlah kemunculannya`. lalu hasil akan disort berdasarkan kolom 2 yaitu jumlah kemunculan jenis error dengan urutan dari besar ke kecil.

- **NOMOR 1E**
  ```
  echo "Username,INFO,ERROR"
  ```
  - membuat header file untuk user_statistic.csv
  ```
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
  ```
  - variabel nama adalah variabel yang menyimpan setiap username non repetisi. Variabel error digunakan untuk menghitung jumlah error untuk setiap usernya, variabel info digunakan untuk menghitung jumlah  info untuk setiap usernya, lalu stat akan menunjukkan jumlah info dan error untuk setiap usernya dan akan dimasukkan ke dalam hasilstat dan dikirim ke user_statistic.csv

## SOAL 2
Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

a) Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). 
  ```
  Profit Percentage = (Profit ÷Cost Price) ×100
  ```
  Cost Price didapatkan dari pengurangan Sales dengan Profit (Quantity diabaikan).

b) Daftar nama customer pada transaksi tahun 2017 di Albuquerque.

c) Segment customer dan jumlah transaksinya yang paling sedikit.

d) Wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

**_Pembahasan:_**
- **NOMOR 2A**
  ```
  awk -F '\t' '
  {	
	    if (NR>1) profitPercentage[$1] = $21 / ($18 - $21) * 100
	
	    for (ID in profitPercentage){
		      if(max <= profitPercentage[ID] ){
			        max = profitPercentage[ID]
			        rowID = ID
		      }	
	    }	
  } END {print "Transaksi terakhir dengan percentage profit terbesar yaitu", rowID,"dengan persentase", max,"%\n"}' Laporan-TokoShiSop.tsv > hasil.txt
  ```
   - ` awk -F '\t'`  menandakan penggunaan awk serta field separator yang digunakan yaitu tab.
   - `if (NR>1) profitPercentage[$1] = $21 / ($18 - $21) * 100`  conditional-if supaya line pertama dari record yaitu headernya tidak ikut terproses dalam perhitungan. Array profitPercentage dengan key Row ID menyimpan hasil perhitungan dari rumus yang sudah diberikan soal untuk tiap baris record.
   - Kemudian array profitPercentage di looping sebanyak jumlah record yang ada untuk mencari profit percentage terbesar dengan cara membandingkan tiap baris data dengan variable max yang awalnya bernilai nol, data yang memenuhi syarat profit percentage dan row id-nya akan di simpan ke dalam variabel max dan rowID.
   - `... > hasil.txt` untuk menyimpan hasil output ke dalam file hasil.txt

- **NOMOR 2B**
  ```
  echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:" >> hasil.txt

  awk -F '\t' '{
	if ($2 ~ /2017/ && $10 ~ /Albuquerque/){
		custName[$7]++
	}
  } END { for (i in custName) print i}' Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  - `if ($2 ~ /2017/ && $10 ~ /Albuquerque/)` untuk mencari baris data yang memiliki '2017' pada kolom ke-2 (Order ID) untuk mendapatkan customer yang melakukan transaksi si tahun 2017 dan mencari baris data yang memiliki nilai 'Albuquerque' pada kolom ke-10 (City) 
  - Jika memenuhi kondisi, nama disimpan dalam array key `custName`, untuk setiap transaksi yang dilakukan oleh orang yang sama tambahkan +1 ke dalam array.
  - `for (i in custName) print i` loop untuk print key 'i' yang menyimpan nama dari customer yang melakukan transaksi pada tahun 2017 di Albuquerque.
  - `... >> hasil.txt` menambahkan hasil output ke dalam file hasil.txt yang telah dibuat saat nomor 2a sebelumnya.

- **NOMOR 2C**
  ```
  awk -F "\t" '
  {	
	min = segCust[$8]
	segCust[$8]++
	for (seg in segCust){
		if(min>segCust[seg] && seg!="Segment")
		{
			min = segCust[seg]
			segment = seg
		}
	}
  } END {print "\nTipe segmen customer yang penjualannya paling sedikit adalah", segment, "dengan", min, "transaksi."}' Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  - `min = segCust[$8]` inisialisasi variabel 'min' yang nantinya akan digunakan untuk mencari segmen customer yang jumlah transaksinya paling sedikit.
  - `segCust[$8]++` array segCust dengan key kolom ke-8 (Segment) untuk menghitung jumlah baris yang dimiliki dari setiap segment.
  - `for (seg in segCust)` looping untuk membandingkan jumlah transaksi
  - apabila nilai dari suatu segment lebih kecil dari variabel 'min', nilai dari array key segment tersebut akan disimpan ke dalam variable 'min' dan array key-nya akan disimpan ke dalam variabel 'segment.'
  - `seg!="Segment"` kondisi tambahan agar line pertama yang merupakan header, tidak terhitung dalam perbandingan.
  -   - Hasil output ditambahkan ke dalam file hasil.txt yang telah dibuat pada nomor sebelumnya.

- **NOMOR 2D**
  ```
  awk -F '\t' '
  {	
	min = profit[$13]	
	profit[$13] += $21
	for(reg in profit)
	{
		if(min>profit[reg] && reg!="Region")
		{
			min = profit[reg]
			region = reg
		}
	}
  } END {print "\nWilayah bagian (region) yang memiliki keuntungan (profit) paling sedikit adalah", region,"dengan total keuntungan",min}' Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  - `min = profit[$13]` inisialisasi variabel min untuk nantinya dijadikan perbandingan untuk mencari region yang memiliki profit paling sedikit.
  - `profit[$13] += $21` array profit dengan key kolom ke-13 (Region) menambahkan nilai dari kolom ke-21 (profit) untuk setiap baris dengan region yang sama.
  - Kemudian array di-loop untuk mencari region yang memiliki nilai profit terdikit, apabila nilai array lebih kecil dari variabel 'min' maka nilai dari array key region tersebut akan disimpan ke dalam variabel 'min' dan array key-nya akan disimpan ke dalam variabel 'region'
  - `reg!="Region"` kondisi tambahan agar line pertama yang merupakan header, tidak terhitung dalam perbandingan.
  - Hasil output ditambahkan ke dalam file hasil.txt yang telah dibuat pada nomor sebelumnya.

## SOAL 3

a) Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada 
kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian 
menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)

b) Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").

c) Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

d) Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

e) Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya 
ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.

**_Pembahasan_**
- **NOMOR 3A**
  ```
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
  ```
  - pertama perlu mendownload file dengan format kitten dan menyimpan lognya di Foto.log.
  ```
  if [[ $i -eq 0 ]]; then
 	  wget -O "kitten" -a Foto.log https://loremflickr.com/320/240/kitten
  else
	  wget -O "kitten.$i" -a Foto.log https://loremflickr.com/320/240/kitten
  fi
	
  ```
  - Kemudian mengecek apakah file sama berdasarkan riwayat log tersebut dan menandai dengan flag = 1 apabila terdapat file yang sama
  ```
  flag=0
  check=($(awk '/https:\/\/loremflickr.com\/cache\/resized\// {print $3}' ./Foto.log))
  length=(${#check[@]})

  for((j=0; j < ($length-1); j++)) do
 	if [ "${check[j]}" == "${check[$(($length-1))]}" ]
        then
            flag=1
            break
	fi
  done
  ```
  - hapus file ketika diketahui ada file yang sama
  ```
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
  ```
  - Untuk merename file keformat soal pertama di deklarasikan nilai `flag=1` yang merupakan file pertama hasil rename. kemudian dilakukan looping untuk setiap nama filenya terdapat kata kitten. `mv "$X" "Koleksi_$flag"` dengan perintah ini maka setiap nama file yang ada kata kitten diganti dengan Koleksi_1 dst. Angka 1 menyesuaikan nilai flagnya.
  ```
  flag=1
  for X in kitten*; do
    mv "$X" "Koleksi_$flag";
    flag=$(($flag+1));
  done
  ```

- **NOMOR 3B**  
  **_SHELL SCRIPT_**
  ```
  #!/bin/bash

  mkdir ~/Documents/SISOP/modul1/soal3/$(date +%d-%m-%Y)
  mv  ~/Documents/SISOP/modul1/soal3/hasil3a/* ~/Documents/SISOP/modul1/soal3/$(date +%d-%m-%Y)
  ```
  **_CRONTAB_**
  ```
  0 20 1-30/7,2-30/4 * * /bin/bash /home/deka/Documents/SISOP/modul1/soal3/soal3a.sh
  ```
  - `mkdir ~/Documents/SISOP/modul1/soal3/$(date +%d-%m-%Y)` membuat folder dengan nama sesuai tanggal di hari tersebut. Untuk direktori menyesuaikan
  - `mv  ~/Documents/SISOP/modul1/soal3/hasil3a/* ~/Documents/SISOP/modul1/soal3/$(date +%d-%m-%Y)` dengan ini maka semua file yang ada di direktori hasil3a (direktori menyesuaikan) dipindah ke direktori yang sebelumnya dibuat
  - `0 20 */7 * * /bin/bash /home/deka/Documents/SISOP/modul1/soal3/soal3a.sh` menjalankan shell script soal3a.sh setiap jam 20:00 pada tujuh hari sekali setiap bulan
  - `0 20 */4 * * /bin/bash /home/deka/Documents/SISOP/modul1/soal3/soal3a.sh` menjalankan shell script soal3a.sh setiap jam 20:00 pada empat hari sekali setiap bulan

- **NOMOR 3C**
  ```
  #!/bin/bash

  cd /home/deka/Documents/SISOP/modul1/soal3/output

  #PROSES 3.1
  #PROSES 3.1.1
  flag_kucing=0
  for i in x*;
  do
	flag_kucing=$(($flag_kucing+1));
  done

  #PROSES 3.1.2
  flag_kelinci=0
  for i in y*;
  do
	flag_kelinci=$(($flag_kelinci+1));
  done
  #PROSES 3.1 END
 
  # echo $flag_kucing
  # echo $flag_kelinci

  #PROSES 3.2
  exec &> Foto.log
  if [[ $flag_kucing -le $flag_kelinci ]];
  then
	#PROSES 3.2.1
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
	#PROSES 3.2.2
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
  ```  
  - Pada proses 3.1.1 digunakan untuk menghitung jumlah file yang terdapat kata x `flag_kucing=$(($flag_kucing+1))` dimana file x dibuat ketika terdapat di direktori `/Documents/SISOP/modul1/soal3/output/` setelah pemindahan semua file output ke direktori `/Documents/SISOP/modul1/soal3/solve/Kucing_$(date +%d-%m-%Y)`.
  - Pada proses 3.1.2 digunakan untuk menghitung jumlah file yang terdapat kata y `flag_kelinci=$(($flag_kelinci+1))` dimana file x dibuat ketika terdapat di direktori `/Documents/SISOP/modul1/soal3/output/` setelah pemindahan semua file output ke direktori `/Documents/SISOP/modul1/soal3/solve/Kelinci_$(date +%d-%m-%Y)`.
  - `exec &> Foto.log` untuk menyimpan log ke Foto.log
  - Pada proses 3.2 melakukan proses download file, rename file dan memindahkan semua hasil download di direktori output ke folder sesuai ketentuan soal. Untuk 3.2.1 bertugas pada file kitten dan 3.2.2 untuk file bunny

- **NOMOR 3D**
  ```
  #!/bin/bash

  cd /home/deka/Documents/SISOP/modul1/soal3/solve
  zip -P $(date +%m%d%Y) -r Koleksi.zip  *
  find . -type d -name 'Kucing*' -exec rm -r {} +
  find . -type d -name 'Kelinci*' -exec rm -r {} +
  ```  
  - `cd /home/deka/Documents/SISOP/modul1/soal3/solve` pindah ke direktori solve tempat dimana folder `Kucing_$(date +%d-%m-%Y)` dan `Kelinci_$(date +%d-%m-%Y)` berada.
  - `zip -P $(date +%m%d%Y) -r Koleksi.zip  *` zip semua folder yang ada di direktori solve tersebut dengan nama Koleksi.zip
  - `find . -type d -name 'Kucing*' -exec rm -r {} +` karena di soal diminta untuk tidak meninggalkan folder apapun kecuali zip maka semua folder yang ada nama Kucingnya dihapus
  - `find . -type d -name 'Kelinci*' -exec rm -r {} +` begitu juga dengan folder yang ada namanya Kelinci

- **NOMOR 3E**
  ```
  0 7 * * 1-5 /bin/bash /home/deka/Documents/SISOP/modul1/soal3/soal3d.sh
  0 18 * * * unzip -P "$(date -d "yesterday" '+%m%d%Y')" /home/deka/Documents/SISOP/modul1/soal3/solve/Koleksi.zip
  ```  
  - `0 7 * * 1-5 /bin/bash /home/deka/Documents/SISOP/modul1/soal3/soal3d.sh` menjalankan program soal3d.sh sekali mulai jam 07:00 - 16:00 setiap hari Senin-Jumat
  - `0 18 * * * unzip -P "$(date -d "yesterday" '+%m%d%Y')" /home/deka/Documents/SISOP/modul1/soal3/solve/Koleksi.zip` melakukan unzip file yang terdapat di direktori solve dengan ketentuan password `$(date -d '+%m%d%Y')`. unzip dilakukan mulai pukul 18.00 karena pada jam tersebut perkuliahan berakhir

## KENDALA

NOMOR 3
1. di nomor 3C saya tidak tau cara looping melewati folder, sehingga harus mengakali membuat file lain untuk menjembatani. 
2. saya masih fail kalau menjalankan shell script dengan crontab dan menyimpan hasilnya ke folder tertentu sehingga saya mengakali untuk mengubah direktori di shell script

## SCREENSHOT OUTPUT
#### HASIL 2    
Output berupa file `hasil.txt` yang berisi laporan hasil dari nomor 2a, 2b, 2c, dan 2d  
![hasil2](https://user-images.githubusercontent.com/72660860/113497550-71317400-952f-11eb-9370-8251b58be5c3.png)

#### HASIL 3A  
![Screenshot from 2021-04-02 22-42-55](https://user-images.githubusercontent.com/55046884/113430709-cd4ba980-9404-11eb-9ea6-0d83b752841a.png)

#### HASIL 3B  
Digambar diketahui kalau semua koleksi gambar di pindah ke folder waktu folder tersebut dibuat yakni 02-04-2021  
![Screenshot from 2021-04-02 22-45-13](https://user-images.githubusercontent.com/55046884/113430882-20256100-9405-11eb-83f1-be398a50c555.png)

#### HASIL 3C  
Hasil berupa folder kucing atau kelinci yang didownload bergantian beda hari dan penamaan sesusai apa yang didownload dengan tanggal pendownloadan  
![Screenshot from 2021-04-02 22-51-55](https://user-images.githubusercontent.com/55046884/113431510-0df7f280-9406-11eb-8af3-e00ff58726c5.png)

#### HASIL 3D  
Semua folder hasil dari 3C dijadikan satu file zip dengan nama Koleksi.zip dan password sesuai tanggal pembuatan zip tersebut  
![Screenshot from 2021-04-02 22-52-34](https://user-images.githubusercontent.com/55046884/113431576-2405b300-9406-11eb-8439-7b6e10db616b.png)

#### HASIL 3E  
Hasil berupa unzip file dengan password yang sama dengan pembuatan zip tersebut  
![Screenshot from 2021-04-02 22-56-35](https://user-images.githubusercontent.com/55046884/113431947-bad26f80-9406-11eb-82f8-23b9c7cbcc75.png)
