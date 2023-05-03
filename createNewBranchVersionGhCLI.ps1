$myhome = "C:\Users\squar\source\statsamos"
$ignoredirs = @("utils", "skipthis")
$oldbranch = "28"
$newbranch = "29"

Get-ChildItem -Path $myhome -Directory | ForEach-Object {
    $directory = $_.FullName
    if ($ignoredirs -contains $_.Name) {
        Write-Host "Skipping directory: $directory"
        return
    }
    
    Write-Host "Processing directory: $directory"
    Set-Location $directory
    
    git checkout $oldbranch
    git checkout -b $newbranch

    # Push the new branch to GitHub
    git push --set-upstream origin $newbranch

    # Set the new branch as the default branch in GitHub
    gh api -X PATCH /repos/:owner/:repo --field default_branch=$newbranch
}