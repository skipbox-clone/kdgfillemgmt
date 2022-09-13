# Import Group id first
$grouparr = @()
$group = Import-Csv .\allgroup.csv |Select-Object id |ForEach-Object {$_.id}
$grouparr += $group


# Creating folder as group display name
$foldername = @()
$displayname = Import-Csv .\allgroup.csv |Select-Object DisplayName |ForEach-Object {$_.displayName}
$foldername += $displayname

For($d=0;$d -lt $foldername.Length;$d++){
    mkdir .\lists\$($foldername[$d])
}

"Done Creating Folder As Group Display Name"

For($d=0;$d -lt $foldername.Length;$d++){
    ni .\lists\$($foldername[$d])\$($foldername[$d])"newMember.csv"
    ni .\lists\$($foldername[$d])\$($foldername[$d])"newOwner.csv"
}

#Export Group
#first create filename for group
$filegroup = @()
For($g=0;$g -lt $grouparr.Length;$g++){
    $filegroup += $foldername[$g]+"group"+".csv"
}

For($gp=0;$gp -lt $grouparr.Length;$gp++){
    Get-Team -GroupId $grouparr[$gp] |Export-Csv .\lists\$($foldername[$gp])\$($filegroup[$gp])
    # if ($LASTEXITCODE -eq 0) {
    #     "Done $($filegroup[$gp])"
    # } else {
    #     "Error $($filegroup[$gp])"
    # }
}

# Export Users
#first create filename
$memberfile = @()
For($f=0;$f -lt $grouparr.Length;$f++){
    $memberfile += $foldername[$f]+"member"+".csv"
}

$ownerfile = @()
For($o=0;$o -lt $grouparr.Length;$o++){
    $ownerfile += $foldername[$o]+"owner"+".csv"
}

For($u=0;$u -lt $grouparr.Length;$u++){
    Get-TeamUser -GroupId $grouparr[$u] -Role Member |Export-Csv .\lists\$($foldername[$u])\$($memberfile[$u])
    
    # if ($LASTEXITCODE -eq 0) {
    #     "Done $($memberfile[$u])"
    # } else {
    #     "Error $($memberfile[$u])"
    # }
}

For($k=0;$k -lt $grouparr.Length;$k++){
    Get-TeamUser -GroupId $grouparr[$k] -Role Owner |Export-Csv .\lists\$($foldername[$k])\$($ownerfile[$k])
    
    # if ($LASTEXITCODE -eq 0) {
    #     "Done $($ownerfile[$k])"
    # } else {
    #     "Error $($ownerfile[$k])"
    # }
}