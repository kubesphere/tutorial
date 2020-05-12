#! /bin/bash



BASE_FOLDER=$(dirname $(readlink -f "$0"))

function menu() {

title="gitlab-harbor Installer Menu"
url="https://kubesphere.io/"
time=`date +%Y-%m-%d`

cat << eof


################################################
         `echo -e "\033[36m$title\033[0m"`
################################################
*   1) Harbor
*   2) Gitlab
*   3) Harbor-Gitlab
################################################
$url               $time
################################################
eof

}


function install-harbor(){
        ansible-playbook -i $1 $BASE_FOLDER/../kubesphere/install-gitlab-harbor.yml \
                 -b \
                 -e harbor_enable=true 
        if [[ $? -eq 0 ]]; then
        #statements
        str="successsful!"
        echo -e "\033[30;47m$str\033[0m"  
    else
        str="failed!"
        echo -e "\033[31;47m$str\033[0m"
        exit
    fi
}

function install-gitlab(){
        ansible-playbook -i $1 $BASE_FOLDER/../kubesphere/install-gitlab-harbor.yml \
                 -b \
                 -e gitlab_enable=true 
        if [[ $? -eq 0 ]]; then
        #statements
        str="successsful!"
        echo -e "\033[30;47m$str\033[0m"  
    else
        str="failed!"
        echo -e "\033[31;47m$str\033[0m"
        exit
    fi
}

function install-gitlab-harbor(){
        ansible-playbook -i $1 $BASE_FOLDER/../kubesphere/install-gitlab-harbor.yml \
                 -b \
                 -e gitlab_enable=true \
                                 -e harbor_enable=true 
        if [[ $? -eq 0 ]]; then
        #statements
        str="successsful!"
        echo -e "\033[30;47m$str\033[0m"  
    else
        str="failed!"
        echo -e "\033[31;47m$str\033[0m"
        exit
    fi
}

function exec(){
    menu
       # all-in-one tends to install everything on one node.
    read -p "Please input an option: " option
    echo $option

    case $option in
       1)
            install-harbor $1
            exit
               ;;
       2)
            install-gitlab $1
            exit
               ;;
       3)
            install-gitlab-harbor $1
            exit
               ;;
    esac
}
    

function multinode(){
    hostmultinode=$BASE_FOLDER/../k8s/inventory/my_cluster/hosts.ini
    exec ${hostmultinode}
}

function allinone(){
    hostallinone=$BASE_FOLDER/../k8s/inventory/local/hosts.ini
    exec ${hostallinone}
}

hostname=$(hostname)

if [[ $hostname != "ks-allinone" ]]; then
    multinode
else
    allinone
fi
