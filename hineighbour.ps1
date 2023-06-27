# Retrieve the ARP table
$arpTable = Get-NetNeighbor | Where-Object {$_.State -eq 'Reachable'}

# Display the ARP table with hostname and domain
Write-Host "`nARP Table:`n"
Write-Host "IP Address      MAC Address         Hostname                 Domain"
Write-Host "-----------     -----------------  -----------------------  ------------------------"
$arpTable | ForEach-Object {
    $ipAddress = $_.IPAddress
    $macAddress = $_.LinkLayerAddress
    $hostName = (Resolve-DnsName -Name $ipAddress -ErrorAction SilentlyContinue).NameHost
    $domain = (Resolve-DnsName -Name $ipAddress -Type PTR -ErrorAction SilentlyContinue).NameHost
    Write-Host ("{0,-15} {1,-19} {2,-24} {3}" -f $ipAddress, $macAddress, $hostName, $domain)
}
