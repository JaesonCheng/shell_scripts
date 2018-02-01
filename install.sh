#!/bin/bash


function main()
{
    while true :
    do
        tput clear
        echo -e ""
        echo -e "--------------------------------------------"
        echo -e "   1. install lrzsz / tree / vim / jq"
        echo -e "   2. install python2.7"
        echo -e "   3. install python3.5"
        echo -e "   4. install saltstack"
        echo -e "   5. install redis"
        echo -e "   0. exit"
        echo -e "--------------------------------------------"
        echo -e ""
        read -p "Your choice > " Num
        
        case ${Num} in
            1)
                yum -y install lrzsz tree vim jq bash-completion wget ngrep iftop
            ;;
            2)
                /bin/bash ./install_Python2.7.11.sh
            ;;
            3)
                /bin/bash ./install/install_python27.sh
            ;;
            4)
                /bin/bash ./install_saltstack.sh
            ;;
            5)
                /bin/bash ./install_redis.sh
            ;;
            6)
                exit
            ;;
            7)
                exit
            ;;
            8)
                exit
            ;;
            9)
                exit
            ;;
            0)
                exit
            ;;
            *)
                continue
            ;;
        esac
    done
}

main
