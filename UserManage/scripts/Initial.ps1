$foldername = @()
$displayname = Import-Csv ../information/allgroup.csv |ForEach-Object {$_.displayName}
$foldername += $displayname

For($d=0;$d -lt $foldername.Length;$d++){
    mkdir ../lists/$($foldername[$d])
}

For($d=0;$d -lt $foldername.Length;$d++){
    touch ../lists/$($foldername[$d])/$($foldername[$d])"(newMember).csv"
    touch ../lists/$($foldername[$d])/$($foldername[$d])"(newOwner).csv"
}