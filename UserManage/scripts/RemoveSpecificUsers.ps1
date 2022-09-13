$groupid = Read-Host "Enter GroupID"

$userarr = @()
$user = Import-Csv ../information/SameUsers.csv |ForEach-Object {$_.User}
$userarr += $user


for ($u=0;$u -lt $userarr.Length;$u++) {
  Remove-TeamUser -GroupId $groupid -User $userarr[$u]
}