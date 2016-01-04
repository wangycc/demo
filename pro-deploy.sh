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
    cp -r "$CODE_DIR" "$TMP_DIR"
}

config_pro(){
    echo "add Confiure File "
    /bin/cp -r "$CONFIG_DIR" "$TMP_DIR/demo/"
    TAR_VER="$API_VER"_"$CTIME"
    cd "$TMP_DIR" && mv demo pro_demo_$TAR_VER""

}

tar_pro(){
    echo "tar pro art"
    cd "$TMP_DIR" && tar czf pro_demo_"$TAR_VER".tar.gz pro_demo_"$TAR_VER"
    echo 'tar finished pro_demo_"$TAR_VER".tar.gz'
}

scp_pro(){
    #/bin/scp $TMP_DIR/pro_demo_"$TAR_VER".tar.gz $user@$remote_ip:/var/www/html
    /bin/cp $TMP_DIR/pro_demo_"$TAR_VER".tar.gz /tmp
    

}

deploy_pro(){
    echo "start Deploy..."
    cd /tmp && tar xf pro_demo_"$TAR_VER".tar.gz 
    rm -rf /var/www/html/demo
    ln -s /tmp/pro_demo_"$TAR_VER" /var/www/html/demo
     
    

}

test_pro(){
    echo "start test"
    curl -I 127.0.0.1 | grep "200"
    echo "tet ok"

}

rollback_list(){
    ls -l /tmp/*.tar.gz

}

rollback_pro(){
    rm -rf /var/www/html/demo
    ln -s /tmp/$1 /var/www/html/demo


}
main(){
    case $1 in 
    deploy)
        git_pull_pro;
        config_pro;
        tar_pro;
        scp_pro;
        deploy_pro;
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
}
main $1 $2 

