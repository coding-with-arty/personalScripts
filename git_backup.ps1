# Define log file location
$logFile = "C:\Scripts\git_backup_log.txt"

# Repositories to back up
$repoPaths = @(
    "C:\Xampp\htdocs\site1",
    "C:\Xampp\htdocs\site2",
    "C:\Xampp\htdocs\site3",
    "C:\laragon\www",
    "C:\Users\arthur.belanger\Exercism",
    "C:\Users\arthur.belanger\source\InvApp",
    "C:\Users\arthur.belanger\source\coding-with-arty",
    "C:\Users\arthur.belanger\source\PythonRepos",
    "C:\Users\arthur.belanger\source\RadioTrack"

)

# Sets safe backup spot (OneDrive GitBackups)
$backupRoot = "C:\Users\arthur.belanger\OneDrive - University of Maine System\GitBackups"

# Keep only the 3 most recent log entries
$logContent = Get-Content $logFile -Raw

# Split log into sections based on the header marker
$sections = $logContent -split "--- Git Metadata Backup with Compression Started:"

# Remove empty entries
$sections = $sections | Where-Object { $_.Trim() -ne "" }

# Keep only the last 3 sections
$recentSections = $sections | Select-Object -Last 10

# Rebuild the log file with the header re-added
$newLog = $recentSections | ForEach-Object {
    "--- Git Metadata Backup with Compression Started:" + $_
}

# Overwrite the log file
$newLog -join "`n" | Out-File -FilePath $logFile -Encoding utf8 -Force

foreach ($repo in $repoPaths) {
    $gitFolder = Join-Path $repo ".git"

    if (-Not (Test-Path $gitFolder)) {
        "`nRepo skipped (no .git folder): $repo`n" | Out-File -Append $logFile
        continue
    }

    $repoName = Split-Path $repo -Leaf
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $zipName = "$repoName.git.$timestamp.zip"
    $zipPath = Join-Path $backupRoot $zipName

    # Create a temp spot to hold .git before zipping
    $tempPath = Join-Path $env:TEMP "$repoName-git-backup"
    if (Test-Path $tempPath) {
        Remove-Item -Path $tempPath -Recurse -Force
    }
    New-Item -ItemType Directory -Path $tempPath | Out-Null

    try {
        # Copy only .git to temp path
        Copy-Item -Path $gitFolder -Destination (Join-Path $tempPath ".git") -Recurse -Force

        # Create .ZIP file
        Compress-Archive -Path "$tempPath\.git" -DestinationPath $zipPath -Force

        "`nRepo: $repo - .git metadata compressed to $zipPath`n" | Out-File -Append $logFile

        # set how many backups to keep
        $maxBackups = 1  

        # Get only backups belonging to THIS repo
        $repoBackups = Get-ChildItem -Path $backupRoot -Filter "$repoName.git.*.zip" |
        Sort-Object LastWriteTime -Descending

        if ($repoBackups.Count -gt $maxBackups) {
            # Skip the newest N, delete everything after
            $oldBackups = $repoBackups[$maxBackups..($repoBackups.Count - 1)]

            foreach ($backup in $oldBackups) {
                try {
                    Remove-Item -Path $backup.FullName -Force
                    "`nRemoved old backup: $($backup.FullName)`n" | Out-File -Append $logFile
                }
                catch {
                    "`nError removing old backup: $($backup.FullName) - $_`n" | Out-File -Append $logFile
                }
            }
        }

    }
    catch {
        "`nError compressing .git from ${repo}: $_`n" | Out-File -Append $logFile
    }
    finally {
        # Clean temp files
        Remove-Item -Path $tempPath -Recurse -Force
    }
}
