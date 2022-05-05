# Set up variables
Write-Output "######################"
Write-Output "# Audit-FileHash 1.0 #"
Write-Output "######################"
$FolderPath = Read-Host "Enter full path of directory to scan"
$Identifiers = Get-Content -Path $(Read-Host "Enter full path to identifiers.txt")
$HashPrompt = Read-Host "Select hashing algorithm to search by"
# Variables for loading bar
$TotalItems = (Get-ChildItem -Path $FolderPath.Count -Recurse | Measure-Object).Count
$CurrentItems = 0
$PercentComplete = 0
#
Get-ChildItem -Path $FolderPath -Recurse |
ForEach-Object {
    # Loading bar
    Write-Progress -Activity "Comparing hashed files in $FolderPath..." -Status "$PercentComplete% Complete" -CurrentOperation $_.FullName
    $CurrentItems++
    $PercentComplete = [int](($CurrentItems/$TotalItems)*100)
    # Hash each file in every subfolder under $FolderPath
    $TargetPath = $_.FullName
    $SuspectHash = Get-FileHash -Path $TargetPath -Algorithm $HashPrompt
    # If anything in our $Identifiers matches the hashed $TargetPath...
    if ($Identifiers -contains $SuspectHash) {
        # Add path to array for later
        Write-Output "$TargetPath has been identified as a potential match!" -ForegroundColor Black -BackgroundColor Yellow
        $Suspects += $TargetPath
    }
}
# If we found anything...
if ($Suspects -gt 0) {
    Write-Output "One or more files in $FolderPath were detected with a matching signature." -ForegroundColor White -BackgroundColor Red
    Write-Output $Suspects
}else {
    Write-Output "No files were found in $FolderPath with a matching signature." -ForegroundColor White -BackgroundColor -Green
} > | Out-File -Append .\audit_log.txt
#
Write-Output "Console output has been exported as audit_log.txt to local directory."
Start-Sleep -s 5