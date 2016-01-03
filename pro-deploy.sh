#!/bin/env bash


#Date/Time
CDATE=$(date "+%Y-%m-%d")
CTIME=$(date "+%Y-%m-%d-%H-%M")

#shell
CODE_DIR="/deploy/code/demo"
CONFIG_DIR="/deploy/config"
TMP_DIR="/deploy/tmp"
TAR_DIR="/deploy/tar"

usage(){
    echo "Usage: $0 [deploy | rollback-list | rollback-pro version ]"

}

git_pull_pro(){
    echo "begin git pull Resource Code"
    cd $CODE_DIR && git pull
    API_VERLEN=$(git show | grep commit | cut -d ' ' -f2)
    API_VER=$(echo ${API_VERLEN:0:5})
}

config_pro(){

}

tar_pro(){

}

scp_pro(){


}

deploy_pro(){

}

test_pro(){


}

rollback_list(){


}

rollback_pro(){


}
main(){
    case $1 in 
    deploy)
        git_pull_pro;
        config_pro;
        tar_pro;
        scp_pro;
        devploy_pro;
        test_pro;
        ;;
    rollback-list)
        rollback_list;
        ;;
    rollback-pro)
        rollback_pro $2;
        ;;
    *)
        usage;;
esac

main $1 $2 
}
