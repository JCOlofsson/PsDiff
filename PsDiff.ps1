Write-Host "
############################################################
    Script: PsDiff
    Description: Check for differences in xml/csv-files 
                 while ignoring sort order.
############################################################`n" -ForegroundColor Green


$filename1 = Read-Host -Prompt 'Enter filename 1 (default "file1.xml")'
if(-not($filename1)){
    $filename1 = "file1.xml"
    Write-Host "Selected filename: $filename1" -ForegroundColor Green
}
Write-Host "`n"

$filename2 = Read-Host -Prompt 'Enter filename 2 (default "file2.xml")'
if(-not($filename2)){
    $filename2 = "file2.xml"
    Write-Host "Selected filename: $filename2" -ForegroundColor Green
}
Write-Host "`n"

$caseSensitive = Read-Host -Prompt 'Case sensitive comparison (Y/N) (default Y)'
if(-not($caseSensitive)){
    $caseSensitive = "Y"
    Write-Host "Case sensitivity: $caseSensitive" -ForegroundColor Green
}
Write-Host "`n"

if($caseSensitive -eq "Y"){
    $result = Compare-Object -ReferenceObject (Get-Content ./$filename1) -DifferenceObject (Get-Content ./$filename2) -CaseSensitive | Out-String 
}
elseif ($caseSensitive -eq "N") {
    $result = Compare-Object -ReferenceObject (Get-Content ./$filename1) -DifferenceObject (Get-Content ./$filename2) | Out-String 
}
else{
    if($caseSensitive -ne "Y" -And $caseSensitive -ne "N"){  
        Write-Host 'Input has to be Y or N' -ForegroundColor Red
    }
    else{
        Write-Host 'Unknown input error' -ForegroundColor Red
    }
}

Write-Host "`n"
if(-not($result)){
    Write-Host "--- NO DIFFERENCES FOUND ---" -ForegroundColor Green
}
else{
    Write-Host "--- DIFFERENCES FOUND ---" -ForegroundColor Red
    Write-Host "$result" -ForegroundColor Yellow
}
if($caseSensitive -ne "Y"){
    Write-Host "Note: case sensitive comparison is not active. Case sensitive differences may occur." -ForegroundColor Yellow
}
Read-Host -Prompt "Press Enter to exit"

