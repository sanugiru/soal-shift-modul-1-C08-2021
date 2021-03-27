# Soal Shift Sisop Modul 1 C08 2021
Anggota:
- Deka Julian Arrizki	    05111940000112
- Muhammad Farhan Haykal	05111940000141
- Shahnaaz Anisa Firdaus 	05111940000158


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
    - `awk -F 't' `


## SOAL 3 
