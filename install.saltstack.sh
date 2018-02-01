#!/bin/bash
# Author : JaesonCheng
#   Date : 2018/01/30
#    Ver : 0.1
# Readme : install salt master / minion

# curl -L https://bootstrap.saltstack.com -o install_salt.sh

sysinfo="$(head -n 1 /etc/redhat-release)"

if [[ "${sysinfo}" =~ "CentOS release 6" ]] ; then
   sysver=6
elif [[ "${sysinfo}" =~ "CentOS Linux release 7" ]] ; then
   sysver=7
fi

function Help_Menu()
{
    echo "install.saltstack.sh  Ver: 0.1"
    echo ""
    echo "Usage: install.saltstack.sh [-m|-s] [-i <ipaddress>]"
    echo "  -m                Install salt master."
    echo "  -s                Install salt minion."
    echo "  -i <ipaddress>    Set salt master ip."
    echo ""
}


function install_master()
{
    ## install
    yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el${sysver}.noarch.rpm
    if [ $? -eq 0 ] ; then
        yum -y install salt-master salt-minion salt-clound salt-api salt-ssh salt-syndic
    else
        echo "install salt yum repo fail."
        exit
    fi
    ## set minion
    hostname > /etc/salt/minion_id
    sed -i "s/#master:.*/master: ${saltmasterip}/" /etc/salt/minion
    ## set master
    sed -i "/#interface:/s/#//" /etc/salt/master
    sed -i "/#ipv6:/s/#//" /etc/salt/master
    sed -i "/#publish_port:/s/#//" /etc/salt/master
    sed -i "/#user:/s/#//" /etc/salt/master
    sed -i "/#ret_port:/s/#//" /etc/salt/master
    ## run master / minion
    if [[ "${sysver}" == "6" ]] ; then
        chkconfig --level 35 salt-minion on
        chkconfig --level 35 salt-master on
        /etc/init.d/salt-master start
        /etc/init.d/salt-minion start
    fi
    if [[ "${sysver}" == "7" ]] ; then
        systemctl enable salt-master
        systemctl enable salt-minion
        systemctl start salt-master
        systemctl start salt-minion
    fi
}

function install_minion()
{
    ## install 
    yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el${sysver}.noarch.rpm
    if [ $? -eq 0 ] ; then
        yum -y install salt-minion
    else
        echo "install salt yum repo fail."
        exit
    fi
    ## set minion
    hostname > /etc/salt/minion_id
    sed -i "s/#master:.*/master: ${saltmasterip}/" /etc/salt/minion
    ## run
    if [[ "${sysver}" == "6" ]] ; then
        chkconfig --level 35 salt-minion on
        /etc/init.d/salt-minion start
    fi
    if [[ "${sysver}" == "7" ]] ; then
        systemctl enable salt-minion
        systemctl start salt-minion
    fi
}

function Get_Options()
{
	if [ ! -z "$1" ] ; then
		case "$1" in
			--master|-m)
				saltrole="master"
                shift
                Get_Options "$@"
			;;
			--slave|-s)
				saltrole="minion"
                shift
                Get_Options "$@"
			;;
			--ip|-i)
				shift
                saltmasterip="$1"
                shift
                Get_Options "$@"
			;;
			*)
				Help_Menu
				exit 1
			;;
		esac
	fi	
}

Get_Options "$@"

if [[ "x${saltrole}" != "x" ]] && [[ "x${saltmasterip}" != "x" ]] ; then
    if [[ "${saltrole}" == "master" ]] ; then
        install_master
    fi
    if [[ "${saltrole}" == "minion" ]] ; then
        install_minion
    fi
else
    Help_Menu
    exit 1
fi

