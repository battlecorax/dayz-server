#!/bin/bash
set -e

dayz_mods_array=${DAYZ_MODS//;/ }
dayz_server_mods_array=${DAYZ_SERVER_MODS//;/ }

# Looping through selected mods and server mods to create the proper launch parameters
steam_mods_string=""
for mod in ${dayz_mods_array}; do
    steam_mods_string+=" +workshop_download_item 221100 ${mod}"
done
for mod in ${dayz_server_mods_array}; do
    steam_mods_string+=" +workshop_download_item 221100 ${mod}"
done

# DayZ server installation and update via steamcmd
/usr/games/steamcmd +force_install_dir ${SERVER_DIR} \
    +login ${STEAM_USERNAME} ${STEAM_PASSWORD} ${STEAM_GUARD} \
    +app_update 223350 \
    ${steam_mods_string} \
    +quit

# Mpmissions might be missing at server download, if so, we will download it from GitHub
if [ ! -d "${SERVER_DIR}/mpmissions" ]; then
    mkdir "/download"
    cd /download
    curl -s https://api.github.com/repos/BohemiaInteractive/DayZ-Central-Economy/releases/latest \
    | grep "tarball_url" \
    | cut -d : -f 2,3 \
    | tr -d \", \
    | wget -qi -

    tar -xzvf DZ_* --strip=1

    mkdir -p ${SERVER_DIR}/mpmissions
    cp -r dayzOffline.* ${SERVER_DIR}/mpmissions/

    cd ${SERVER_DIR}
    rm -rf /download
fi

# Linking mods into the server directory, and copies over the keys if provided
for mod in ${dayz_mods_array} ${dayz_server_mods_array}
do
    if [ ! -d "${SERVER_DIR}/${mod}" ]; then
        ln -s ${SERVER_DIR}/steamapps/workshop/content/221100/${mod} ${SERVER_DIR}/${mod}
        
        if [ -d ${SERVER_DIR}/${mod}/keys ]; then cp -r ${SERVER_DIR}/${mod}/keys/*.bikey ${SERVER_DIR}/keys; fi
        if [ -d ${SERVER_DIR}/${mod}/Keys ]; then cp -r ${SERVER_DIR}/${mod}/Keys/*.bikey ${SERVER_DIR}/keys; fi
    fi
done

./DayZServer -config=serverDZ.cfg -port=${SERVER_PORT} -mod=${DAYZ_MODS} -servermod=${DAYZ_SERVER_MODS} -BEpath=battleye -profiles=profiles -dologs -adminlog -netlog -freezecheck ${SERVER_ARGS}