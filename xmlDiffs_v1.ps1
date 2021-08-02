$filename1 = Read-Host -Prompt 'Enter filename 1 (default "file1.xml")'
if(-not($filename1)){
    $filename1 = "file1.xml"
    Write-Output "Selected filename: $filename1"
}

$filename2 = Read-Host -Prompt 'Enter filename 2 (default "file2.xml")'
if(-not($filename2)){
    $filename2 = "file2.xml"
    Write-Output "Selected filename: $filename2"
}

$caseSensitive = Read-Host -Prompt 'Case sensitive comparison (Y/N) (default Y)'
if(-not($caseSensitive)){
    $caseSensitive = "Y"
    Write-Output "Case sensitivity $caseSensitive"
}
if($caseSensitive -ne "Y" -And $caseSensitive -ne "N"){  
    Write-Output 'Input has to be Y or N'
}

$result
if($caseSensitive -eq "Y"){
    $result = Compare-Object -ReferenceObject (Get-Content ./$filename1) -DifferenceObject (Get-Content ./$filename2) -CaseSensitive | Out-String 
}
elseif ($caseSensitive -eq "N") {
    $result = Compare-Object -ReferenceObject (Get-Content ./$filename1) -DifferenceObject (Get-Content ./$filename2) | Out-String 
}
else{
    Write-Output "Invalid input"
}

Write-Output "`n`n"
if(-not($result)){
    Write-Output "No differences found."
}
else{
    Write-Output "DIFFERENCES FOUND:"
    Write-Output $result
}
if($caseSensitive -ne "Y"){
    Write-Output "Note: case sensitive comparison is not active. Case sensitive differences may occur."
}
Read-Host -Prompt "Press Enter to exit"

