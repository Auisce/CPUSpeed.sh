# CPUSpeed.sh

Bash command line tool for changing CPU speed.

This shell script is to select new maximum cpu speed.

Written by Alyssa.

Notes:

Originally written for Debian 9 AMD64 with the Linux kernel
* Adapted for fedora support aswell

Will not work without the Linux kernel.

This script assumes 4 cpus [0-3].

This script assumes cpu throttling is already working.

This script assumes 7 cpu speeds are available in /sys/devices/system/cpu/cpu[0-3]/cpufreq/scaling_available_frequencies

This script does not enable cpu speeds other than those already supported; it is not for over/underclocking or correcting cpu upper or lower limits.

This script requires cpufrequtils which is a Linux Kernel module, and will install it (Debian) if it's not installed.
