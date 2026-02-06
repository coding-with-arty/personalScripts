Get-ChildItem -Recurse -Directory -Filter ".git" | ForEach-Object {
    $repoPath = $_.Parent.FullName
    Write-Host "Fixing $repoPath"
    cd $repoPath
    $remote = git remote get-url origin
    if ($remote -match "MusicalViking") {
        $newRemote = $remote -replace "MusicalViking","coding-with-arty"
        git remote set-url origin $newRemote
    }
}
