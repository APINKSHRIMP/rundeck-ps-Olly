[String]$LogfileName = "OneDriveDetection"
[String]$Logfile = "c:\Tools\onedrive\$LogfileName.log"
Function Write-Log {
    Param ([string]$logstring)
    If (Test-Path $Logfile) {
        If ((Get-Item $Logfile).Length -gt 2MB) {
            Rename-Item $Logfile $Logfile".bak" -Force
        }
    }
    $WriteLine = (Get-Date).ToString() + " " + $logstring
    Add-content $Logfile -value $WriteLine
}
$OneDrive = "c:\program files\microsoft Onedrive\onedrive.exe"
# Parameter to Log
Write-Log "Start Script Execution"
Write-Log "Detection-String: $OneDrive"
If (Test-Path $OneDrive) {
    Write-Log "Found DetectionFile"
    $OneDriveFile = Get-Item $OneDrive
    $OneDriveVersion = $OneDriveFile.VersionInfo.FileVersion
    Write-Log "Version found:$OneDriveFile.VersionInfo.FileVersion"
    Write-Log "Version found variable:$OneDriveVersion"
    $OnedriveSplit = $OnedriveVersion.split(".")
    $Onedrivecheck = $OnedriveSplit[0]

    If ($Onedrivecheck -ge "24") {
        Write-Log "Get File Details"
        Write-Log "Version found:$OneDriveFile.VersionInfo.FileVersion"
        Write-Log "Script Execution End!"
        Write-Log "True"
        Return $true
    }
 
    Else {
        Write-Log "Warning: OneDrive.exe is an old version – need to install App!"
    }
}
Else {
    Write-Log "Warning: OneDrive.exe not found – need to install App!"
}