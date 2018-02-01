#!/bin/bash

function install_redis()
{
    version="$1"
    if ! type redis-server  > /dev/null 2>&1 ; then
        test -f redis-${version}.tar.gz && rm -f redis-${version}.tar.gz
        wget -c http://download.redis.io/releases/redis-${version}.tar.gz
        if [[ $? -eq 0 ]] && [[ -f redis-${version}.tar.gz ]] ; then
            tar zxvf redis-${version}.tar.gz && cd redis-${version}
            make && make install PREFIX=/usr/local/redis-${version}
            test -d /usr/local/redis && rm -rf /usr/local/redis
            ln -s /usr/local/redis-${version} /usr/local/redis
            ln -s /usr/local/redis/bin/* /usr/bin/
            cp -f redis.conf /etc/
        fi
    else
        echo "You have already installed redis"
        exit 0
    fi
}

# yum -y install redis
# install_redis 3.2.11
install_redis 4.0.7