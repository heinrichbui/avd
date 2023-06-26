$LocalAVDpath            = "c:\temp"
$AVDBootURI              = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH'
$AVDAgentURI             = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv'
$AVDAgentInstaller       = 'AVD-Agent.msi'
$AVDBootInstaller        = 'AVD-Bootloader.msi'
$regToken                = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ4Q0Y2MjhENTM5OUYzNTMwQkM5MzI0RjgyMzVFNEY1RkEyOTQxNkIiLCJ0eXAiOiJKV1QifQ.eyJSZWdpc3RyYXRpb25JZCI6IjhhNGZkMzgyLTYxOWEtNGU0NS04MTg4LWM1YTI3NmJiNzkzYSIsIkJyb2tlclVyaSI6Imh0dHBzOi8vcmRicm9rZXItZy1ldS1yMC53dmQubWljcm9zb2Z0LmNvbS8iLCJEaWFnbm9zdGljc1VyaSI6Imh0dHBzOi8vcmRkaWFnbm9zdGljcy1nLWV1LXIwLnd2ZC5taWNyb3NvZnQuY29tLyIsIkVuZHBvaW50UG9vbElkIjoiOWZhOTBlMjktMzgwZC00MDI0LWE3MmUtYTg2ZGI3ZTgwNTY1IiwiR2xvYmFsQnJva2VyVXJpIjoiaHR0cHM6Ly9yZGJyb2tlci53dmQubWljcm9zb2Z0LmNvbS8iLCJHZW9ncmFwaHkiOiJFVSIsIkdsb2JhbEJyb2tlclJlc291cmNlSWRVcmkiOiJodHRwczovLzlmYTkwZTI5LTM4MGQtNDAyNC1hNzJlLWE4NmRiN2U4MDU2NS5yZGJyb2tlci53dmQubWljcm9zb2Z0LmNvbS8iLCJCcm9rZXJSZXNvdXJjZUlkVXJpIjoiaHR0cHM6Ly85ZmE5MGUyOS0zODBkLTQwMjQtYTcyZS1hODZkYjdlODA1NjUucmRicm9rZXItZy1ldS1yMC53dmQubWljcm9zb2Z0LmNvbS8iLCJEaWFnbm9zdGljc1Jlc291cmNlSWRVcmkiOiJodHRwczovLzlmYTkwZTI5LTM4MGQtNDAyNC1hNzJlLWE4NmRiN2U4MDU2NS5yZGRpYWdub3N0aWNzLWctZXUtcjAud3ZkLm1pY3Jvc29mdC5jb20vIiwiQUFEVGVuYW50SWQiOiI0YTIxYjJjNy0wNTllLTRiZDAtYTNmZS1kODI5MjYyYjNiY2MiLCJuYmYiOjE2ODc2MzQ2OTEsImV4cCI6MTY4ODE2MjQwMCwiaXNzIjoiUkRJbmZyYVRva2VuTWFuYWdlciIsImF1ZCI6IlJEbWkifQ.eDzSd3y5Td92P_BBlQy1I4zqu45zBhc0tF5ii615x3cRfh3c-67XIvCRU9XXdKtQHJ7p9qlReVAWnoO9Yu-arnxsWr8O-Pfave9vkdYikRoQDpcLP6KnQ7zvp-zfevGtPIZ8YJ2vOSJ4_4v444qML8hDQcaZG2MZZdkUqrlAGVK76C1WcBZeeGv3uLaqBMaks3dkkhQ7klfsaIZ_OjjOLzkXvtUEDtkusZfvzCE3Noh9T4Lrci1o1GtoAkucpR1Ag3f9ypVYaN-x7Lgu6r10w_EgQyMAOZqqUsEyAnNC71kfVa59ESqFAygCP31YvLDEFSg9iACms3zow8GgsXU4WA'

#Download AVD Agents
Add-Content -LiteralPath C:\New-AVDSessionHost.log "Downloading AVD Boot Loader"
    Invoke-WebRequest -Uri $AVDBootURI -OutFile "$LocalAVDpath$AVDBootInstaller"
Add-Content -LiteralPath C:\New-AVDSessionHost.log "Downloading AVD Agent"
    Invoke-WebRequest -Uri $AVDAgentURI -OutFile "$LocalAVDpath$AVDAgentInstaller"

Set-Location C:\temp
Start-Process msiexec.exe -ArgumentList "/i $AVDAgentInstaller", "/quiet", "/qn", "/norestart", "/passive", "REGISTRATIONTOKEN=$regToken", "/l* $LocalAVDPath\AgentInstallLog.txt" | Wait-Process
Start-Process msiexec.exe -ArgumentList "/i $AVDBootInstaller", "/quiet", "/qn", "/norestart", "/passive", "/l* $LocalAVDPath\BootLoaderLog.txt" | Wait-Process
