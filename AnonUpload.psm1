<#PSScriptInfo

.VERSION 1.4

.GUID cabe1358-d9ac-43fc-9b8e-4917152718a1

.AUTHOR simeononsecurity.ch

.COMPANYNAME SimeonOnSecurity

.COPYRIGHT (c) 2020 SimeonOnSecurity.. All rights reserved.

.TAGS AnonFiles Upload File Share FileShare

.PROJECTURI https://github.com/simeononsecurity/AnonUpload

.DESCRIPTION "Upload to AnonFiles.com easily Ex. 'AnonUpload -File 'C:\temp\test.txt'"

.RELEASENOTES
Init

#>

function AnonUpload {
    #Requires -Version 6.0
    param(
        [string]$File 
    )
    If (!$File) {
        Write-Host "Please provide the a file. Ex: AnonUpload -File 'C:\temp\test.txt'"
    }
    Else {
        Write-Host "Please wait wile the file is uploaded"
        (Invoke-WebRequest -Method "Post" -Uri "https://api.anonfiles.com/upload" -Form @{file = (Get-Item $File) }).content -Split { $_ -eq '"' -or $_ -eq "{" -or $_ -eq "}" -or $_ -eq ',' -or $_ -eq ' ' } | Select-String -NoEmphasis -Pattern 'https' | Out-String | Set-Variable -Name links
        Write-Host "`n"
        Write-Host "Share your files with either of the following links:"
        Write-Host "$links"
    }
}
