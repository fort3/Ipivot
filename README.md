# Ipivot
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
    Addition: Clear the command history in PSReadLine\ConsoleHost_history.txt and sessions
    
    PS: If you happen to find this tool useful then I wouldn't mind a mention ;)

## Instructions for use

    Change the Parameters below depending on your needs:

    PARAMETER ConnectingPort
    #Change this to the connecting port 

    PARAMETER ListeningPort
    #Change this to the listening port 

    PARAMETER ListeningAddress
    #Change this to the listening IP address you want to set the forwarding to 

    PARAMETER Network
    #Change this to the target network you're working on i.e 192.168.0 

    PARAMETER HostRange
    #Change this to determine the range or leave as default depending on your needs

# Script execution example
   .\Ipivot.ps1 -ConnectingPort 9080 -ListeningPort 9999 -Network 127.0.0 -ListeningAddress 127.0.0.1 -HostRange (1..200)

    
# For Errors like below:

![image](https://github.com/user-attachments/assets/f6e6d43b-e397-43e9-b617-0db74ff1cb89)

# Enter the command below in the Powershell CLI
    Set-ExecutionPolicy RemoteSigned -Scope Process

# Example Output:
![Ipivot 2 0_Parameters_5](https://github.com/user-attachments/assets/5b4c8f14-a16f-451f-afcb-560a5cb6a313)


# CAUTION
As this tool performs a high impact action like clearing the command history and PSReadline sessions and file, you will be asked to confirm this action with a prompt.
![Ipivot 2 0_Parameters_3](https://github.com/user-attachments/assets/2acd0d89-770d-4b24-9033-3299b5c5b044)

DISCLAIMER: Thoughts, Opinions and the Information in this script is strictly for educational purposes alone and use of any code or technique for unlawful or unauthorized activities is strictly prohibited.

This project is free to use!!

Would appreciate some feedback though ;)
