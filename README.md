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

    Instructions for use
    #Change this to the connecting port 
    $Conport = (9080)

    #Change this to the listening port 
    $LisPort = (9999)

    #Change this to the listening IP address you want to set the forwarding to 
    $LisAddr = "127.0.0.1"

    #Change this to the target network you're working on i.e 192.168.0 
    $network = "127.0.0"

    #Change this to determine the network range or leave as default depending on your needs
    $range = 1..10
    
For Errors like below:

![image](https://github.com/user-attachments/assets/f6e6d43b-e397-43e9-b617-0db74ff1cb89)

    #Enter the command below in the Powershell CLI
	  Set-ExecutionPolicy RemoteSigned -Scope Process

Example Output:
![image](https://github.com/user-attachments/assets/2c45cd1f-0415-46b4-b686-5c3a7100fee9)

DISCLAIMER: Thoughts, Opinions and the Information in this script is strictly for educational purposes alone and use of any code or technique for unlawful or unauthorized activities is strictly prohibited.
This project is free to use!!

Would appreciate some feedback ;)
