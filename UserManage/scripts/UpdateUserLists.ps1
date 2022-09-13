$grouparr = @()
$group = Import-Csv ../information/allgroup.csv |ForEach-Object {$_.id}
$grouparr += $group

$foldername = @()
$displayname = Import-Csv ../information/allgroup.csv |ForEach-Object {$_.displayName}
$foldername += $displayname

$filegroup = @()
For($g=0;$g -lt $grouparr.Length;$g++){
    $filegroup += $foldername[$g]+"group"+".csv"
}

For($gp=0;$gp -lt $grouparr.Length;$gp++){
    Get-Team -GroupId $grouparr[$gp] |Export-Csv ../lists/$($foldername[$gp])/$($filegroup[$gp])
}

$memberfile = @()
For($f=0;$f -lt $grouparr.Length;$f++){
    $memberfile += $foldername[$f]+"member"+".csv"
}

$ownerfile = @()
For($o=0;$o -lt $grouparr.Length;$o++){
    $ownerfile += $foldername[$o]+"owner"+".csv"
}

For($u=0;$u -lt $grouparr.Length;$u++){
    Get-TeamUser -GroupId $grouparr[$u] -Role Member |Export-Csv ../lists/$($foldername[$u])/$($memberfile[$u])
}

For($k=0;$k -lt $grouparr.Length;$k++){
    Get-TeamUser -GroupId $grouparr[$k] -Role Owner |Export-Csv ../lists/$($foldername[$k])/$($ownerfile[$k])
}