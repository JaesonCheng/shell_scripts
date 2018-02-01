#!/bin/bash


if ! type docker  > /dev/null 2>&1 ; then
    test -f /etc/yum.repos.d/docker-ce.repo && rm -f /etc/yum.repos.d/docker-ce.repo
    wget -P /etc/yum.repos.d/ https://download.docker.com/linux/centos/docker-ce.repo
    if [[ $? -eq 0 ]] ; then
        yum -y install docker-ce
        if type docker > /dev/null 2>&1 ; then
            echo "docker install succeed."
            docker version | grep "Version"
            systemctl enable docker
            systemctl start docker
            exit 0
        else
            echo "docker install fail."
            exit 1
        fi
    else
        echo "download docker yum repo fail."
        exit 1
    fi
else
    echo "You have already installed docker"
    docker version | grep "Version"
    exit 0
fi
