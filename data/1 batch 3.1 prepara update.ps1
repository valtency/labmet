echo off
cls
echo "Script bat para atualizar labmet"

echo "### Step 01/09 ### Retirando cabeçalhos day ###"

cd day_increment

foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv" -or $_.Extension -eq ".jpg"})){

    echo $A.FullName
    #Rename-Item -Path $A.FullName -NewName ( ($A.BaseName -replace $A.BaseName.Substring(10,24),"") + ".csv")
	$Conteudo = Get-Content -path $A.FullName

#Retira primeira linha
$tmp = $Conteudo[11..($Conteudo.Length-1)]
#Write-Output $tmp
#$tmp = $tmp -replace '"',''
#Grava Modificações
$tmp > $A

Rename-Item -Path $A.FullName -NewName ( ($A.BaseName -replace $A.BaseName.Substring(10,24),"_increment") + ".csv2")
	

}


cd ../hour_increment

echo "### Step 02/09 ### Retirando cabeçalhos hour ###"

foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv" -or $_.Extension -eq ".jpg"})){

    echo $A.FullName
    #Rename-Item -Path $A.FullName -NewName ( ($A.BaseName -replace $A.BaseName.Substring(10,24),"") + ".csv")
	$Conteudo = Get-Content -path $A.FullName

#Retira primeira linha
$tmp = $Conteudo[11..($Conteudo.Length-1)]
#Write-Output $tmp
#$tmp = $tmp -replace '"',''
#Grava Modificações
$tmp > $A

Rename-Item -Path $A.FullName -NewName ( ($A.BaseName -replace $A.BaseName.Substring(12,22),"_increment") + ".csv2")	

}

#voltando pra base
cd ..


#copiando increment para base
cp ./day_increment/* ./
cp ./hour_increment/* ./
echo "### Step 04/09 ### Copiando increment para base ###"


echo "### Step 05/09 ### Executando merge ###"
#pause

foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv" -or $_.Extension -eq ".jpg"})){
$increment = $A.BaseName+'_increment.csv2'
$merge = $A.BaseName+'_merge.csv3'
    Write-Output $A.BaseName
   
	$Base = Get-Content -path $A.FullName
Get-Content $A.FullName, $increment | Set-Content $merge

#$tmp > $A
	

}

#pasta atual base
echo "### Step 06/09 ### Removendo arquivos antigos ###"
foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv" -or $_.Extension -eq ".csv2"})){

    Remove-Item -path $A -recurse
        
    
}


#pasta atual base
echo "### Step 07/09 ### Renomeando extensões ###"
foreach($A in (dir ".\" | ?{$_.Extension -eq ".csv3"})){
    $newName = $A.BaseName.Replace("_merge","")
    echo $newName
    Rename-Item -Path $A.FullName -NewName $newName".csv"
        
    
}

#pasta atual base
echo "### Step 08/09 ### Excluíndo day increment e hour increment ###"
#rm -r ./day_increment/*
#preserva na pasta o script daily
Remove-Item ./day_increment/* -Include *.csv2

rm -r ./hour_increment/*

#pasta atual base
echo "### Step 09/09 ### Atualizando token ###"
foreach($A in (dir ".\" | ?{$_.Extension -eq ".vr"})){
    echo $A.FullName
   
	$Conteudo = Get-Content -path $A.FullName  -Raw #-TotalCount 1
    $add = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "a", "b", "c", "d", "e", "f" | Get-Random

#$Conteudo, $add | Set-Content $A
Add-Content -path $A.FullName -Value $add -NoNewline
        
    
}



echo "end"
pause
