echo off
cls
echo "Script bat para atualizar labmet increment diario"


echo "### Retira dia atual vazio ###"


foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv" -or $_.Extension -eq ".jpg"})){

    echo $A.FullName
   
	$Conteudo = Get-Content -path $A.FullName

#Retira ultima linha
$tmp = $Conteudo[0..($Conteudo.Length-3)]
#$tmp = $tmp[0..($tmp.Length+1)]
$tmp > $A
	

}

foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv"})){

   
	#$Conteudo = Get-Content -path $A.FullName
	Add-Content -path $A.FullName "`n" -NoNewline


}


echo "end"
pause
