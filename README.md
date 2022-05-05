# Audit-FileHash
This is a PowerShell script I wrote to find files that match a provided list of file hashes.
It's original use was to find files suspected to do with ransomware, and it was designed to scan the directories of the C: drive of a Windows server.
The script was written using PowerShell 7 and therefore should be cross-compatible with other PowerShell 7 platforms (MacOS and Linux).

## How to Use
1. Save Audit-FileHash.ps1 to an accessible directory.
2. Create and save a .txt file of the suspected file hash values*, broken by returns, ideally to the same directory.
3. Run a PowerShell prompt with elevated priviledges and run Audit-FileHash.ps1.
4. The script will prompt for a target directory to scan. Enter the full path as if navigating in a terminal (For example: `C:\Windows\system32\`). Press Enter.
5. The script will prompt for the location of the .txt file from Step 2. Provide the full path of the file and press Enter.
6. The script will prompt for the type of hashing algorithm to use for its scan. This script uses the Get-FileHash cmdlet, which supports the SHA1, SHA256, SHA384, SHA512, and MD5 hashing algorithms. Enter your preferred option and press Enter.
7. The script will display a progress bar with a percentage of completion and a readout of what file/directory is currently being scanned.
8. The script will also print any files that were unable to be scanned to the console. The console output and any results of the scan will be saved as a `log.txt` file that will be exported to the same directory as the Audit-FileHash.ps1 file.

## Version History
- 1.0: First release! Proven working script.