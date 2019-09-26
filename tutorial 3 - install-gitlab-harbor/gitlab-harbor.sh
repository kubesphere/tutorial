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
	ansible-playbook -i $BASE_FOLDER/../k8s/inventory/local/hosts.ini $BASE_FOLDER/../kubesphere/install-gitlab-harbor.yml \
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
	ansible-playbook -i $BASE_FOLDER/../k8s/inventory/local/hosts.ini $BASE_FOLDER/../kubesphere/install-gitlab-harbor.yml \
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
	ansible-playbook -i $BASE_FOLDER/../k8s/inventory/my_cluster/hosts.ini $BASE_FOLDER/../kubesphere/install-gitlab-harbor.yml \
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

while true
do
    menu
       # all-in-one tends to install everything on one node.
    read -p "Please input an option: " option
    echo $option

    case $option in
       1)
            install-harbor
            exit
               ;;
       2)
            install-gitlab
            exit
               ;;
       3)
            install-gitlab-harbor
            break
               ;;
    esac
done