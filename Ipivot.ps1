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
                            ##                  ####
    IPIVOT  - Red Teaming Tool
    By: @fort3 - Fortune Sam Okon
    Description: A little pivoting tool for when your favourite meterpreter shell fails...
    Prequisites: Identify and Gain Initial Foothold on Target as Administrator
    
    PS: If you happen to find this tool useful then I wouldn't mind a mention ;)

	set Set-ExecutionPolicy RemoteSigned -Scope Process if you can't run scripts on target powershell cli                 
 ******************************************************************************* 
 "

#Change this to the connecting port 
$Conport = (9080)

#Change this to the listening port 
$LisPort = (9999)

#Change this to the listening IP address you want to set the forwarding to 
$LisAddr = "127.0.0.1"

#Change this to the target network you're working on i.e 192.168.0 
$network = "127.0.0"

#Change this to determine the range or leave as default depending on your needs
$range = 1..10

$ErrorActionPreference= 'silentlycontinue'

#list the network and ports found and apply the forwarding
$(Foreach ($add in $range)
{ 
    $ip = "{0}.{1}" -F $network,$add
    Write-Progress "Scanning Network" $ip -PercentComplete (($add/$range.Count)*100)
    If(Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip)
    {
        $socket = new-object System.Net.Sockets.TcpClient($ip, $Conport)
        If($socket.Connected) 
        { "$ip port $Conport is open"
            Write-Progress "Forwarding from listening $LisAddr and $LisPort to target\n"
			Write-Output "Forwarding from listening $LisAddr and $LisPort to target......."

			Write-Output "________________________________________________________"
			#piece of the script that does the forwarding
            Invoke-Expression "netsh interface portproxy add v4tov4 listenaddress=$($LisAddr) listenport=$($LisPort) connectaddress=$($ip) connectport=$($Conport)"
            
			Write-Progress "Checking if host is listening on port $LisPort and $ConPort\n"
			Write-Output "Checking if host is listening on port $LisPort and $ConPort"
			#verify that the port is listening
            Get-NetTCPConnection -LocalPort $LisPort
			Get-NetTCPConnection -LocalPort $ConPort
			Write-Output "*******************************************************************************"
            $socket.Close() 
        }
        else 
        { 
            "$ip port $Conport is not open "
        }
	}
})
