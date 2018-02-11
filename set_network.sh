#! /bin/bash

# importing script help_functions.sh (point is equals to => source)
. ./help_functions.sh

# declaring constants
NETWORK_CONF_FILE=/etc/sysconfig/network-scripts/ifcfg-enp0s3
PARAMS=./params
POSTES=./postes
HOSTS=/etc/hosts
HOST_NAME="serveur"

function set_network {
	
	echo $HOST_NAME > /etc/hostname
	for l in `cat $POSTES`
	do
		host_name=`echo $l | cut -f1 -d:`
		ip=`echo $l | cut -f2 -d:`
		line="$ip	$host_name.ubo.local $host_name"
		if [ -n "$(grep $line $HOSTS)" ]
		then
			echo "ce hoste déjà existe"
		else
			$(add_line "$HOSTS" "$line")
		fi
	done
	
	if [ -e $NETWORK_CONF_FILE ]
		then
			for f in `cat $PARAMS`
			do
				line=`echo $f | cut -f1 -d =`
	 			$(replace_line $NETWORK_CONF_FILE $line $f)
			done
		fi
}

function verify_network {
	for h in `cat $POSTES`
	do
		ip=`echo $h | cut -f2 -d:`
		if [ -n "$(grep $h $HOSTS)" ]
		then
			echo "ligne n'existe pas"
		else
			ping -c5 $ip
		fi
	done
}

# function set_nfs {
# 	echo
# }

# function verify_nfs {
# 	echo
# }

# function set_nis {
# 	echo
# }

# function verify_nis {
# 	echo
# }

# function set_autofs {
# 	echo
# }

# function verify_autofs {
# 	echo
# }

# function set_iptables {
# 	echo
# }

# function verify_iptables {
# 	echo
# }
