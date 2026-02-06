# --- Backup current user PATH ---
$backupFile = "$env:USERPROFILE\Documents\PATH_backup.reg"
try {
    reg export "HKCU\Environment" $backupFile /y
    Write-Host "PATH backup saved to $backupFile"
} catch {
    Write-Warning "Failed to backup PATH: $_"
}

# --- Detect Python installations ---
$pythonFolders = @()
$possiblePythonPaths = $env:Path -split ';' | Where-Object { $_ -and $_ -ne '' }

foreach ($p in $possiblePythonPaths) {
    if (Test-Path $p -PathType Container) {
        # Check if python.exe exists here
        if (Test-Path (Join-Path $p "python.exe")) {
            $pythonFolders += $p
        }
    }
}

# Decide which Python to keep
# Priority: Conda > User-installed Python > System Python
$keepPython = $pythonFolders | Where-Object { $_ -like "*anaconda3*" } |
              Select-Object -First 1
if (-not $keepPython) {
    $keepPython = $pythonFolders | Where-Object { $_ -like "*Python*" } | Select-Object -First 1
}

# --- Define essential folders to keep ---
$essentialFolders = @(
    "$env:USERPROFILE\bin",
    "$env:LOCALAPPDATA\anaconda3",
    "$env:LOCALAPPDATA\anaconda3\Scripts",
    "$env:LOCALAPPDATA\anaconda3\Library\bin",
    "$env:LOCALAPPDATA\anaconda3\Library\usr\bin",
    "C:\Program Files\Git\cmd",
    "C:\Program Files\nodejs",
    "C:\Program Files\Microsoft VS Code\bin"
)

# Include the chosen Python folder only
if ($keepPython -and (-not ($essentialFolders -contains $keepPython))) {
    $essentialFolders += $keepPython
}

# --- Clean current PATH ---
try {
    $currentPath = $env:Path -split ';' | Where-Object { $_ -and $_ -ne '' }

    # Keep only essential folders (ignore other Python/exe folders)
    $cleanPath = $currentPath | Where-Object {
        ($essentialFolders -contains $_) -or (Test-Path $_ -PathType Container)
    } | Select-Object -Unique

    # Ensure all essential folders are present
    foreach ($folder in $essentialFolders) {
        if (-not ($cleanPath -contains $folder)) {
            $cleanPath += $folder
        }
    }

    # Apply cleaned PATH for this session
    $env:Path = ($cleanPath -join ';')
    Write-Host "PATH cleaned for this session."

    # Apply permanently to user environment
    setx Path ($cleanPath -join ';') | Out-Null
    Write-Host "PATH updated permanently for user. You may need to restart your shell."
} catch {
    Write-Warning "Failed to clean PATH: $_"
}

# --- Verify result ---
Write-Host "Final PATH entries:"
$env:Path -split ';'
