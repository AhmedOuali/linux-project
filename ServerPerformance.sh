#/bin/bash
clear
declare -rx BC="/usr/bin/bc"

if test -f $HOME/.gtkrc-2.0;then
    GTK=$HOME/.gtkrc-2.0
else
    GTK=$HOME/.gtkrc-3.0
fi

if test ! -x $BC; then
    echo -e "\e[0;5;31m$BC is not available, please install before continuing."
    exit 192
fi

host=`cat /proc/sys/kernel/hostname`
mem_total=`free -m | grep "Mem" | awk '{print $2}'`
mem_used=`free -m | grep "buffers/" | awk '{print $3}'`
hd_used=`df | grep "sda" | awk '{print $3}'`
hd_total=`df | grep "sda" | awk '{print $2}'`
type=`df -T | grep "sda" | awk '{print $2}'`
idle=`cat /proc/uptime | awk '{print $2}'`
kernel=`cat /proc/version | awk '{print $3}'`
cpu=`cat /proc/cpuinfo | grep "model name" | awk '{print $4,$5,$6, $7}'`
theme=`cat $GTK | grep "gtk-theme-name" | cut -d= -f2 | tr -d '"'`
icon=`cat $GTK | grep "gtk-icon-theme-name" | cut -d= -f2 | tr -d '"'`
font=`cat $GTK | grep "gtk-font-name" | cut -d= -f2 | tr -d '"'`

function uptime() {
	uptime=$(</proc/uptime)
    uptime=${uptime%%.*}

    seconds=$(( uptime%60 ))
    minutes=$(( uptime/60%60 ))
    hours=$(( uptime/60/60%24 ))
    days=$(( uptime/60/60/24 ))
    echo -e $days"-jours", $hours"-hrs" $minutes"-mins" $seconds"-s"
}
percent=$((($mem_used*100)/$mem_total))
zenity --info --title="Server ToolBox (Server Informations)"  --text "
<span color=\"green\">Hostname: $host</span>
<span color=\"green\">Kernel: $kernel</span>
<span color=\"gray\">-------------------------------------------------</span>
<span color=\"blue\">Uptime : $(uptime) </span>
<span color=\"blue\">RAM : $mem_used Mb / $mem_total Mb <span color=\"red\">($percent%)</span></span>
<span color=\"gray\">-------------------------------------------------</span>
<span color=\"black\">$cpu</span>
<span color=\"gray\">-------------------------------------------------</span>"
if [ "$?" -eq 0 ]; then
		bash main.sh
fi
