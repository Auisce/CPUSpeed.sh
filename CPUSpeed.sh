#!/bin/bash

# This shell script is to select new maximum cpu speed.
# Written by Alyssa.
# Notes:
# Originally written for Debian 9 AMD64 with the Linux kernel
# This script assumes 4 cpus [0-3].
# This script assumes cpu throttling is already working.
# This script assumes 7 cpu speeds are available in /sys/devices/system/cpu/cpu[0-3]/cpufreq/scaling_available_frequencies
# This script does not enable cpu speeds other than those already supported; it is not for over/underclocking or correcting cpu upper or lower limits.
#
# This script requires cpufrequtils and will install it (Debian).
echo '****************************************************************'
echo '****************************************************************'
echo 'CPU Speed Script'
echo 'Written by Alyssa'
echo ''
#############################################################################################
# check os type
OS_TYPE=$( cat /etc/*-release | grep '^ID=' | cut -d'=' -f2- | tr '[:upper:]' '[:lower:]')
#############################################################################################
# check if cpufrequtils is installed, and if not, install it.
echo 'Checking script dependencies...'
if [[ "${OS_TYPE}" == 'debian' ]]; then
echo 'Detected the Operating system as a Debian flavour'
#create variable $installed and give a value base on an the output of a dpkg query piped to grep.
installed=$(dpkg-query -W --showformat='${Status}\n' cpufrequtils|grep "install ok installed")
echo Checking for cpufrequtils: $installed
#IF statement. IF $installed isn’t true - download and install dependencies.
if [ "" == "$installed" ]; then
echo "Dependencies missing. Installing now..."
sudo apt-get --force-yes --yes install cpufrequtils
fi
elif [[ "${OS_TYPE}" == 'fedora' ]]; then
echo 'Detected the Operating system as a Fedora flavour'
# if statement that checks if the kernel-tools exists locally, enters if when it doesn't
if [[ ! $(yum list --installed kernel-tools >/dev/null 2>&1) ]]; then
echo "Dependencies 'kernel-tools'  missing. Installing now"
sudo yum install --assumeyes kernel-tools
fi
fi
echo 'Dependencies installed.'
#############################################################################################
#echo 'Current settings:'
#echo '****************************************************************'
#cpufreq-info
#echo '****************************************************************'
#############################################################################################
echo ''
cd /sys/devices/system/cpu 
echo 'Checking cpu frequency options in'; pwd
#############################################################################################

#Create 7 variables and assign values to them based on the data in /sys/devices/system/cpu/cpu[0-3]/cpufreq/scaling_available_frequencies.

speedOne=`awk '{print $1}' ./cpu0/cpufreq/scaling_available_frequencies`
speedTwo=`awk '{print $2}' ./cpu0/cpufreq/scaling_available_frequencies`
speedThree=`awk '{print $3}' ./cpu0/cpufreq/scaling_available_frequencies`
speedFour=`awk '{print $4}' ./cpu0/cpufreq/scaling_available_frequencies`
speedFive=`awk '{print $5}' ./cpu0/cpufreq/scaling_available_frequencies`
speedSix=`awk '{print $6}' ./cpu0/cpufreq/scaling_available_frequencies`
speedSeven=`awk '{print $7}' ./cpu0/cpufreq/scaling_available_frequencies`
#############################################################################################
#print the seven variables numbered as an options list.
echo '****************************************************************'
echo '****************************************************************'
echo 'Select new max frequency.'
echo 'Press 1) for' $speedOne kHz
echo 'Press 2) for' $speedTwo kHz
echo 'Press 3) for' $speedThree kHz
echo 'Press 4) for' $speedFour kHz
echo 'Press 5) for' $speedFive kHz
echo 'Press 6) for' $speedSix kHz
echo 'Press 7) for' $speedSeven kHz
echo 'Enter any other value to exit without making changes.'
echo 'Waiting for response...'
#############################################################################################
#We now have 7 options with values taken from the Available frequencies list printed to screen
#Create new variable "n" and get user to select the value of another variable for it. 
#Depending on the case selected, use spufrequtils to set the governer, and max frequency for all 4 cores.
#frequency is still the same value taken from the available frequencies list.
read n
case $n in
1) sudo cpufreq-set -g ondemand -c 0 -u $speedOne'kHz'
sudo cpufreq-set -g ondemand -c 1 -u $speedOne'kHz'
sudo cpufreq-set -g ondemand -c 2 -u $speedOne'kHz'
sudo cpufreq-set -g ondemand -c 3 -u $speedOne'kHz'
echo 'CPU set to' $speedOne'kHz';;
2) sudo cpufreq-set -g ondemand -c 0 -u $speedTwo'kHz'
sudo cpufreq-set -g ondemand -c 1 -u $speedTwo'kHz'
sudo cpufreq-set -g ondemand -c 2 -u $speedTwo'kHz'
sudo cpufreq-set -g ondemand -c 3 -u $speedTwo'kHz'
echo 'CPU set to' $speedTwo'kHz';;
3) sudo cpufreq-set -g ondemand -c 0 -u $speedThree'kHz'
sudo cpufreq-set -g ondemand -c 1 -u $speedThree'kHz'
sudo cpufreq-set -g ondemand -c 2 -u $speedThree'kHz'
sudo cpufreq-set -g ondemand -c 3 -u $speedThree'kHz'
echo 'CPU set to' $speedThree'kHz';;
4) sudo cpufreq-set -g ondemand -c 0 -u $speedFour'kHz'
sudo cpufreq-set -g ondemand -c 1 -u $speedFour'kHz'
sudo cpufreq-set -g ondemand -c 2 -u $speedFour'kHz'
sudo cpufreq-set -g ondemand -c 3 -u $speedFour'kHz'
echo 'CPU set to' $speedFour'kHz';;
5) sudo cpufreq-set -g ondemand -c 0 -u $speedFive'kHz'
sudo cpufreq-set -g ondemand -c 1 -u $speedFive'kHz'
sudo cpufreq-set -g ondemand -c 2 -u $speedFive'kHz'
sudo cpufreq-set -g ondemand -c 3 -u $speedFive'kHz'
echo 'CPU set to' $speedFive'kHz';;
6) sudo cpufreq-set -g ondemand -c 0 -u $speedSix'kHz'
sudo cpufreq-set -g ondemand -c 1 -u $speedSix'kHz'
sudo cpufreq-set -g ondemand -c 2 -u $speedSix'kHz'
sudo cpufreq-set -g ondemand -c 3 -u $speedSix'kHz'
echo 'CPU set to' $speedSix'kHz';;
7) sudo cpufreq-set -g ondemand -c 0 -u $speedSeven'kHz'
sudo cpufreq-set -g ondemand -c 1 -u $speedSeven'kHz'
sudo cpufreq-set -g ondemand -c 2 -u $speedSeven'kHz'
sudo cpufreq-set -g ondemand -c 3 -u $speedSeven'kHz'
echo 'CPU set to' $speedSeven'kHz';;
*) echo 'Exiting without making changes';;
esac
#############################################################################################
cd
#echo '****************************************************************'
#echo 'New settings:'
#echo '****************************************************************'
#cpufreq-info
echo '****************************************************************'
echo '****************************************************************'
