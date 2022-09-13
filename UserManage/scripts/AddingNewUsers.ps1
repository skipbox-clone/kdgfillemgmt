$groupfolders = @()
$groupfolder = Import-Csv ../information/allgroup.csv |ForEach-Object {$_.DisplayName}
$groupfolders += $groupfolder

$grouparr = @()
$group = Import-Csv ../information/allgroup.csv |ForEach-Object {$_.id}
$grouparr += $group

$newMember = @()
For($f=0;$f -lt $grouparr.Length;$f++){
    $newMember += $groupfolders[$f]+"(newMember)"+".csv"
}

$newOwner = @()
For($f=0;$f -lt $grouparr.Length;$f++){
    $newOwner += $groupfolders[$f]+"(newOwner)"+".csv"
}

$filegroup = @()
For($g=0;$g -lt $grouparr.Length;$g++){
    $filegroup += $groupfolders[$g]+"group"+".csv"
}


For($z = 0;$z -lt $groupfolders.Length;$z++){
    $memberonlyarr = @()
    $memberonly = Import-Csv ../lists/$($groupfolders[$z])/$($newMember[$z]) |ForEach-Object {$_.User}
    $memberonlyarr += $memberonly

    $owneronlyarr = @()
    $owneronly = Import-Csv ../lists/$($groupfolders[$z])/$($newOwner[$z]) |ForEach-Object {$_.User}
    $owneronlyarr += $owneronly

    $grouponlyarr = @()
    $grouponly = Import-Csv ../lists/$($groupfolders[$z])/$($filegroup[$z]) |ForEach-Object {$_.GroupId}
    $grouponlyarr += $grouponly

    if ($memberonlyarr.Length -ne 0) {
        For($v = 0;$v -lt $grouponlyarr.Length;$v++){
            For($u = 0; $u -lt $memberonlyarr.Length;$u++){
                Add-TeamUser -Role Member -GroupId $grouponlyarr[$v] -User $memberonlyarr[$u]
            }
        }  
    } else {
        "There is no member to add in $($groupfolders[$z])."
    }

    if ($owneronlyarr.Length -ne 0) {
        For($v = 0;$v -lt $grouponlyarr.Length;$v++){
            For($u = 0; $u -lt $owneronlyarr.Length;$u++){
                Add-TeamUser -Role Owner -GroupId $grouponlyarr[$v] -User $owneronlyarr[$u]
            }
        }
    } else {
        "There is no owner to add in $($groupfolders[$z])."
    } 
}