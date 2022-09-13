$groupfolders = @()
$groupfolder = Import-Csv .\groupfolders.csv |ForEach-Object {$_.Name}
$groupfolders += $groupfolder

$grouparr = @()
$group = Import-Csv .\allgroup.csv |ForEach-Object {$_.id}
$grouparr += $group

$member = @()
For($f=0;$f -lt $grouparr.Length;$f++){
    $member += $groupfolders[$f]+"member"+".csv"
}
$owner = @()
For($o=0;$o -lt $grouparr.Length;$o++){
    $owner += $groupfolders[$o]+"owner"+".csv"
}

$filegroup = @()
For($g=0;$g -lt $grouparr.Length;$g++){
    $filegroup += $groupfolders[$g]+"group"+".csv"
}

For($z = 0;$z -lt $groupfolders.Length;$z++){
    $memberonlyarr = @()
    $memberonly = Import-Csv .\lists\$($groupfolders[$z])\$($member[$z]) |ForEach-Object {$_.User}
    $memberonlyarr += $memberonly

    $owneronlyarr = @()
    $owneronly = Import-Csv .\lists\$($groupfolders[$z])\$($owner[$z]) |ForEach-Object {$_.User}
    $owneronlyarr += $owneronly

    $grouponlyarr = @()
    $grouponly = Import-Csv .\lists\$($groupfolders[$z])\$($filegroup[$z]) |ForEach-Object {$_.GroupId}
    $grouponlyarr += $grouponly

    "-----Removing Member and Owner in $($groupfolders[$z])-----"

    For($v = 0;$v -lt $grouponlyarr.Length;$v++){
        For($u = 0; $u -lt $memberonlyarr.Length;$u++){
            Remove-TeamUser -GroupId $grouponlyarr[$v] -User $memberonlyarr[$u]
            "Member $($memberonlyarr[$u]) has been removed from $($groupfolders[$z])"
        }
    }

    For($v = 0;$v -lt $grouponlyarr.Length;$v++){
        For($u = 0; $u -lt $owneronlyarr.Length;$u++){
            if ($owneronlyarr[$u] -ne "meetingorganizer@kbtc.edu.mm" -and $owneronlyarr[$u] -ne "demostudent@kbtc.edu.mm") {
                Remove-TeamUser -GroupId $grouponlyarr[$v] -User $owneronlyarr[$u]
                "Owner $($owneronlyarr[$u]) has been removed from $($groupfolders[$z])"
            } else {
                "$($owneronlyarr[$u]) is remained as owner"
            }
        }
    }
}