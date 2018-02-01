#!/bin/bash
# install centos yum repo

function install_yum_repo()
{
    sysver="$(head -n 1 /etc/redhat-release | awk -F'.' '{print $1}' | awk '{print $NF}')"
    # 备份
    mkdir -p /etc/yum.repos.d/bak/
    mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak/
    
    # yum 163
    wget -P /etc/yum.repos.d/ http://mirrors.163.com/.help/CentOS${sysver}-Base-163.repo
    
    # yum aliyun
    wget -P /etc/yum.repos.d/ http://mirrors.aliyun.com/repo/Centos-${sysver}.repo
    
    # yum epel
    yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-${sysver}.noarch.rpm
    
}

install_yum_repo
