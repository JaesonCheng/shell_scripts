#!/bin/bash

function OS_Judge()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        SYSTYPE='CentOS'
        SYSVER="$(head -n 1 /etc/redhat-release | awk -F'.' '{print $1}' | awk '{print $NF}')"
        # OSINFO=$(head -n 1 /etc/redhat-release)
        # if [[ "${OSINFO}" =~ "CentOS release 5" ]];then
            # SYSVER=5
        # elif [[ "${OSINFO}" =~ "CentOS release 6" ]];then
            # SYSVER=6
        # elif [[ "${OSINFO}" =~ "CentOS release 7" ]]
            # SYSVER=7
        # fi
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        SYSTYPE='RHEL'
        SYSVER="$(head -n 1 /etc/redhat-release | awk -F'.' '{print $1}' | awk '{print $NF}')"
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        SYSTYPE='Fedora'
        # SYSVER="$(head -n 1 /etc/fedora-release | egrep -o "[0-9]+")"
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        SYSTYPE='Debian'
        SYSVER="$(head -n 1 /etc/debian-release | awk -F'.' '{print $1}' | awk '{print $NF}')"
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        SYSTYPE='Ubuntu'
        # SYSVER="$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")"
    elif grep -Eqi "openSUSE" /etc/issue || grep -Eq "openSUSE" /etc/*-release; then
        SYSTYPE='openSUSE'
        # SYSVER="$(cat /etc/SuSE-release | grep "VERSION")"
    else
        SYSTYPE='unknow'
    fi
    echo ${SYSTYPE} ${SYSVER};
}

OS_Judge