#!/bin/bash

        #############################
        #                           #
        #   Floofy Shield DDoS GRE  #
        #    Installation Script    #
        #                           #
        #############################


echo "Welcome to the official Floofy Shield DDoS GRE tunnel automated installation script!!! Please execute this"
echo "script as root. NOT SUDO! Do "sudo su", then run this script."
read -p "Please enter YOUR server's IP address: " local
read -p "Please enter your PROTECTED IP address: " remote
read -p "Please enter your 'subnet value' (i.e. 10.0.0): " subnet
echo "Running script with local IP $local..."
echo "Running script with remote IP $remote..."

apt update
apt upgrade
apt install curl
ip tunnel add gre1 mode gre local $local remote $remote ttl 255
ip addr add $subnet.2/24 dev gre1
ip link set gre1 up
echo '100 FLOOFYGRE' >> /etc/iproute2/rt_tables
ip rule add from $subnet.0/24 table FLOOFYGRE
ip route add default via $subnet.1 table FLOOFYGRE

echo "DDoS tunnel successfully configured! Please make sure that the next line displayed says the following: $remote"
curl http://www.cpanel.net/showip.cgi --interface $subnet.2
echo "If the line above says: $remote, then you are good to go! If not, please contact support."
echo "Thank you for choosing Floofy Shield!"
echo "Script created with blood and sweat by HaloFloof."