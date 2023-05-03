$myhome = "C:\Users\squar\source\statsamos"
$ignoredirs = @("utils", "skipthis")
$oldbranch = "master"
$newbranch = "28"

Get-ChildItem -Path $myhome -Directory | ForEach-Object {
    $directory = $_.FullName
    if ($ignoredirs -contains $_.Name) {
        Write-Host "Skipping directory: $directory"
        return
    }
    
    Write-Host "Processing directory: $directory"
    Set-Location $directory
    
    git branch -m $oldbranch $newbranch
    git fetch
    git branch -u origin/$newbranch $newbranch
    git remote set-head origin -a
}