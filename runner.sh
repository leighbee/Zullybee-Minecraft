reset_server()
{
    echo "Resetting server..."
    rm -rf logs/ crash-reports/ l_m_modded_*/ backups/
}

stage_mods()
{
    if [ "$(ls /mnt/c/Users/mattc/Downloads/ | grep ".jar")" ]; then
        echo "Staging mods..."
        mv /mnt/c/Users/mattc/Downloads/*.jar ../mod-staging/
    fi
}

staged_mods()
{
    echo "The following mods are staged:"
    diff mods ../mod-staging
}

commit_mods()
{
    echo "Committing mods..."
    cp ../mod-staging/* mods/
}

launch_server()
{
    echo "Launching server..."
    java -Xmx6G -Xms6G -jar forge-1.12.2-14.23.5.2847-universal.jar nogui
}

show_help()
{
    echo "Usage: ./runner.sh [reset, rm-mod, stage-mods, staged-mods commit-mods, launch, all]"
}

rm_mod()
{
    if [ -n "$1" ]; then
        echo "Removing $1"
        rm mods/$1 ../mod-staging/$1
    else
        echo "No filename provided"
    fi
}

case $1 in
    reset )         reset_server;;
    rm-mod )        rm_mod $2;;
    stage-mods )    stage_mods;;
    staged-mods )   staged_mods;;
    commit-mods )   commit_mods;;
    launch )        launch_server;;
    all )           reset_server; stage_mods; staged_mods; commit_mods; launch_server;;
    * )             show_help;;
esac
    
