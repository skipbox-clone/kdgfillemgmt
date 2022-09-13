$role = Read-Host "Enter Role"

$grouparr = @()
$group = Import-Csv ../information/allgroup.csv |ForEach-Object {$_.id}
$grouparr += $group

$userarr = @()
$user = Import-Csv ../information/SameUsers.csv |ForEach-Object {$_.User}
$userarr += $user

for ($d=0;$d -lt $grouparr.Length;$d++) {
  for ($u=0;$u -lt $userarr.Length;$u++) {
    Add-TeamUser -Role Owner -GroupId $grouparr[$d] -User $userarr[$u]
  }
}