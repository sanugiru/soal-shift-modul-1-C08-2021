#!bin/bash

#Nomor-2a
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


#Nomor-2b
echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:" >> hasil.txt

awk -F '\t' '{
	if ($2 ~ /2017/ && $10 ~ /Albuquerque/){
		custName[$7]++
	}

} END { for (i in custName) print i}' Laporan-TokoShiSop.tsv >> hasil.txt



#Nomor-2c
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


#Nomor-2d
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
