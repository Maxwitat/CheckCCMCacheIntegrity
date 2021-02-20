#This code is provided without any warranty

$Cache = get-wmiobject -query "SELECT * FROM CacheInfoEx" -namespace "ROOT\ccm\SoftMgmtAgent"
$WMIInconsistancies = 0;
foreach($item in $Cache)
{
    $foldersize = [math]::truncate(((Get-ChildItem -path $item.Location -recurse | Measure-Object -property length -sum ).sum)/1024)
    $outstring = $item.Location  + '       ' + $item.ContentSize + '       ' + $foldersize 
    if ($foldersize -eq $item.ContentSize){
        Write-Host $outstring -BackgroundColor DarkGreen
    }
    else{
        Write-Host $outstring -BackgroundColor DarkRed
        $WMIInconsistancies++
    }
}

$folders = Get-ChildItem -Path C:\Windows\ccmcache | ?{ $_.PSIsContainer } | Select-Object FullName

$OrphanedFolderCount = 0
foreach($folder in $folders){
    $OrphanedFolder = $true
    foreach($item in $Cache){
        if($item.Location.ToLower() -eq $folder.FullName.ToLower()){
            $OrphanedFolder = $false
            break;
        }
    }
    if($OrphanedFolder -eq $true){
        Write-Host $folder.FullName ' is not in WMI. You may delete it.'  -BackgroundColor DarkYellow
        $OrphanedFolderCount++
    }
}

if($orphanedFolderCount -gt 0 -or $WMIInconsistancies -gt 0)
{
    Write-Host('Inconsistencies found') -BackgroundColor DarkYellow
}
