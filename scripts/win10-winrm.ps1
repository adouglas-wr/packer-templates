ni -ItemType file -Path C:\test.txt
$NetProfile = Get-NetConnectionProfile
$WinRMService = Get-Service winrm

Set-NetConnectionProfile -Name ($NetProfile).Name -NetworkCategory Private
$WinRMService | Start-Service
$WinRMService | Set-Service -StartupType Automatic

netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
