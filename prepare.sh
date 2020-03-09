#!/usr/bin/screen -d -m -S prepare /bin/bash
TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'
GREEN='\033[0;32m'

echo && echo
echo -e "${GREEN}██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗"
echo -e "${GREEN}██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝"
echo -e "${GREEN}██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  "
echo -e "${GREEN}██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  "
echo -e "${GREEN}╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗"
echo -e "${GREEN} ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"
echo -e "${NC}                                                                  "
echo && echo && echo

echo -e $GREEN
echo 'This Script Will prepare your VPS and Makes a User, Password Login will be disabled !!!'
echo -e $TEXT_RESET
echo -e $TEXT_YELLOW
read -p "Press enter to continue"
echo -e $TEXT_RESET

clear

echo -e $GREEN
echo 'Adding 2GB Swap if needed'
sleep 3
wget https://raw.githubusercontent.com/Cretezy/Swap/master/swap.sh -O swap > /dev/null 2>&1
sh swap 2G > /dev/null 2>&1
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
echo 'Check the Swap we made or was already made'
echo -e $TEXT_RESET
sleep 3
echo -e $GREEN
yes | free -m
sleep 4
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
PS3='Do You Want to fix locales: '
options=("yes" "No")
echo -e $TEXT_RESET
select opt in "${options[@]}"
do
    case $opt in
        "yes")
            echo -e $TEXT_YELLOW
            echo "fixing locales"
            locale-gen en_US.UTF-8
            export LANGUAGE=en_US.UTF-8
            export LANG=en_US.UTF-8
            export LC_ALL=en_US.UTF-8
            locale-gen en_US.UTF-8
            dpkg-reconfigure locales
            sleep 3
            echo -e $TEXT_RESET
            echo -e $GREEN
            echo "fixed locales"
            sleep 2
            break
            ;;
        "No")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

clear

echo -e $TEXT_YELLOW
echo 'Now we first update ubuntu....'
sleep 3
sudo apt-get update -y > /dev/null
echo -e $TEXT_RESET
echo -e $GREEN
echo 'update finished...'
sleep 2
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
echo 'Now we upgrade ubuntu....'
sleep 3
sudo apt-get upgrade -y
echo -e $TEXT_RESET
echo -e $GREEN
echo 'upgrade finished...'
sleep 2
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
echo 'Now we dist-upgrade ubuntu....'
sleep 3
sudo apt-get dist-upgrade -y
echo -e $TEXT_RESET
echo -e $GREEN
echo 'dist-upgrade finished...'
sleep 2
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
echo 'now we prepare the firewall....'
sleep 3
apt-get install ufw -y > /dev/null
yes | sudo ufw default deny incoming > /dev/null 2>&1
echo 'UFW - Deny incoming...'
yes | sudo ufw default allow outgoing > /dev/null 2>&1
echo 'UFW - Allow outgoing...'
sleep 3
sudo ufw allow ssh
echo -e $TEXT_RESET
echo -e $GREEN
echo 'Port 22 allowed...'
sleep 3
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
PS3='Do you want to Allow another port? Choose 1 or 2: '
options=("YES" "NO")
echo -e $TEXT_RESET
select opt in "${options[@]}"
do
    case $opt in
        "YES")
        echo -e $TEXT_YELLOW
        read -p 'Which other port would you like to Allow: ' portvar
        sudo ufw allow $portvar/tcp > /dev/null
        echo 'Port Allowed...'
        sleep 2
        echo -e $TEXT_RESET
            ;;
        "NO")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

clear

echo -e $TEXT_YELLOW
echo 'now we Enable The firewall....'
yes | sudo ufw enable > /dev/null
echo -e $TEXT_RESET
echo -e $GREEN
echo 'UFW Enabled...'
sleep 3
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
yes | sudo ufw status verbose
echo -e $TEXT_RESET
echo -e $GREEN
echo 'UFW Status...'
sleep 3
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
echo 'Now we will Install NTP'
sleep 3
sudo timedatectl set-ntp no
yes | sudo apt-get remove ntp > /dev/null
yes | sudo apt-get install ntp > /dev/null
echo -e $TEXT_RESET
echo -e $GREEN
echo 'Installed NTP'
sleep 3
ntpq -p
sleep 3
echo 'NTP Tested'
sleep 3
echo -e $TEXT_RESET
clear

echo -e $TEXT_YELLOW
echo 'Now we will Install Fail2Ban...'
sleep 3
yes | sudo apt-get install fail2ban > /dev/null
yes | sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local > /dev/null
yes | sudo service fail2ban restart > /dev/null
echo -e $TEXT_RESET
echo -e $GREEN
echo 'Installed and Restarted Fail2Ban...'
sleep 3
echo -e $TEXT_RESET

clear

echo -e $TEXT_YELLOW
echo 'Now we install unattended-upgrades'
sleep 3
sudo apt-get install unattended-upgrades -y > /dev/null
echo "APT::Periodic::Update-Package-Lists "1";" >> /etc/apt/apt.conf.d/20auto-upgrades 
echo "APT::Periodic::Download-Upgradeable-Packages "1";" >> /etc/apt/apt.conf.d/20auto-upgrades 
echo "APT::Periodic::AutocleanInterval "7";" >> /etc/apt/apt.conf.d/20auto-upgrades 
echo "APT::Periodic::Unattended-Upgrade "1";" >> /etc/apt/apt.conf.d/20auto-upgrades
echo -e $TEXT_RESET
echo -e $GREEN
echo 'Installed unattended-upgrades'
sleep 3
echo -e $TEXT_RESET

clear
echo -e $TEXT_YELLOW
PS3='Do You Want to Install Htop or Glances: '
options=("Htop" "Glances" "None")
echo -e $TEXT_RESET
select opt in "${options[@]}"
do
    case $opt in
        "Htop")
            echo -e $TEXT_YELLOW
            echo "Installing Htop"
            apt-get install htop -y > /dev/null
            sleep 3
            echo -e $TEXT_RESET
            echo -e $GREEN
            echo "installed Htop"
            sleep 2
            break
            ;;
        "Glances")
            echo -e $TEXT_YELLOW
            echo "Installing Glances"
            apt-get install glances -y > /dev/null
            sleep 3
            echo -e $TEXT_RESET
            echo -e $GREEN
            echo "installed Glances"
            sleep 2
            break
            ;;
        "None")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

clear

PS3='Do you want to make a user? Choose 1 or 2: '
options=("YES" "NO")
select opt in "${options[@]}"
do
    case $opt in
        "YES")
echo -e $TEXT_YELLOW
echo 'now we will make a user'
sleep 3
echo -e $TEXT_RESET

echo -e $GREEN
if [ $(id -u) -eq 0 ]; then
        read -p "Enter username : " username
        egrep "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
        else
                adduser --disabled-password --gecos "" $username
                usermod -a -G sudo $username > /dev/null 2>&1
                sudo mkdir /home/$username/.ssh > /dev/null 2>&1
                sudo cp .ssh/authorized_keys /home/$username/.ssh/authorized_keys > /dev/null 2>&1
                sudo chown $username:$username -R /home/$username/ > /dev/null 2>&1
                sudo chmod 700 /home/$username/.ssh/ > /dev/null 2>&1
                sudo chmod 600 /home/$username/.ssh/authorized_keys > /dev/null 2>&1
                sed -re 's/^(\#)(PasswordAuthentication)([[:space:]]+)(.*)/\2\3\4/' -i.`date -I` /etc/ssh/sshd_config
                sed -re 's/^(\#?)(PasswordAuthentication)([[:space:]]+)yes/\2\3no/' -i.`date -I` /etc/ssh/sshd_config
                sed -re 's/^(\#)(PermitEmptyPasswords)([[:space:]]+)(.*)/\2\3\4/' -i.`date -I` /etc/ssh/sshd_config
                sed -re 's/^(\#?)(PermitEmptyPasswords)([[:space:]]+)yes/\2\3no/' -i.`date -I` /etc/ssh/sshd_config
                systemctl reload sshd > /dev/null 2>&1
                echo '%sudo ALL=NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo > /dev/null 2>&1
[ $? -eq 0 ] && echo "User has been added to system as sudo !!! " || echo "Failed to add a user!"
                sleep 4
        fi
else
        echo "Only root may add a user to the system"
        exit 2
fi
echo -e $TEXT_RESET
            break
            ;;
        "NO")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

clear

echo -e $TEXT_YELLOW
echo 'Now we remove unneeded Stuff....'
sleep 3
sudo apt-get autoremove -y > /dev/null
echo -e $TEXT_RESET
echo -e $GREEN
echo 'Unneeded Stuff Vanished...'
sleep 2
echo -e $TEXT_RESET

clear

echo -e $GREEN
rm -rf prepare.sh > /dev/null 2>&1
echo "deleted prepare script"
sleep 3

clear

echo 'Install Complete - Login with the new user "if you made it" after Rebooting !'
echo -e $TEXT_RESET
echo -e $TEXT_YELLOW
read -p "Press enter to Reboot"
echo -e $TEXT_RESET
yes | sudo reboot
