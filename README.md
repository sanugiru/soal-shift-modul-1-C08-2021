# Soal Shift Sisop Modul 1 C08 2021
Anggota:
- 05111940000112 Deka Julian Arrizki	    
- 05111940000141 Muhammad Farhan Haykal	
- 05111940000158 Shahnaaz Anisa Firdaus 	

## SOAL 1 


## SOAL 2
Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

a. Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). 
  ```
  Profit Percentage = (Profit ÷Cost Price) ×100
  ```
  Cost Price didapatkan dari pengurangan Sales dengan Profit (Quantity diabaikan).

b. Daftar nama customer pada transaksi tahun 2017 di Albuquerque.

c. Segment customer dan jumlah transaksinya yang paling sedikit.

d. Wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

**_Pembahasan:_**
- Nomor 2a
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

- Nomor 2b
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

- Nomor 2c
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

- Nomor 2d
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
