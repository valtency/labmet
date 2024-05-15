
echo "### Step 03/09 ### Retira excedente base dayhour ###"


foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv" -or $_.Extension -eq ".jpg"})){

    echo $A.FullName
   
	$Conteudo = Get-Content -path $A.FullName

#Retira ultima linha
$tmp = $Conteudo[0..($Conteudo.Length-2)]
#Write-Output $tmp
#$tmp = $tmp -replace '"',''
#Grava Modificações
$tmp > $A
	

}


echo "end"
pause
