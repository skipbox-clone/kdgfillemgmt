$grouparr = @()
$group = Import-Csv .\allgroup.csv |Select-Object id |ForEach-Object {$_.id}
$grouparr += $group

For($g=0;$g -lt $grouparr.Length;$g++){
    Get-TeamUser -GroupId $grouparr[$g]
    $($grouparr[$g])
}