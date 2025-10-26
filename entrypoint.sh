#!/bin/bash
set -e

# Copy the selected mission from mpmissions-available to mpmissions if it doesn't already exist
if [ ! -d "/server/mpmissions/${DAYZ_MISSION}" ]; then
    if [ -d "/server/missions-available/${DAYZ_MISSION}" ]; then
        cp -r "/server/missions-available/${DAYZ_MISSION}" "/server/mpmissions/${DAYZ_MISSION}"
    else
        echo "Warning: Specified mission ${DAYZ_MISSION} not found in mpmissions-available. The mpmissions folder will remain empty."
    fi
fi

# Generates the config file from environment variables
echo "" > serverDZ.cfg
echo "hostname = \"${DAYZ_HOSTNAME}\";" >> serverDZ.cfg
echo "password = \"${DAYZ_PASSWORD}\";" >> serverDZ.cfg
echo "passwordAdmin = \"${DAYZ_ADMIN_PASSWORD}\";" >> serverDZ.cfg
echo "description = \"${DAYZ_DESCRIPTION}\";" >> serverDZ.cfg
echo "enableWhitelist = ${DAYZ_ENABLE_WHITELIST};" >> serverDZ.cfg
echo "maxPlayers = ${DAYZ_MAX_PLAYERS};" >> serverDZ.cfg
echo "verifySignatures = 2;" >> serverDZ.cfg
echo "forceSameBuild = ${DAYZ_FORCE_SAME_BUILD};" >> serverDZ.cfg
echo "disableVoN = ${DAYZ_DISABLE_VON};" >> serverDZ.cfg
echo "vonCodecQuality = ${DAYZ_VON_CODEC_QUALITY};" >> serverDZ.cfg
echo "shardId = \"${DAYZ_SHARD_ID}\";" >> serverDZ.cfg
echo "disable3rdPerson = ${DAYZ_DISABLE_3RD_PERSON};" >> serverDZ.cfg
echo "disableCrosshair = ${DAYZ_DISABLE_CROSSHAIR};" >> serverDZ.cfg
echo "disablePersonalLight = ${DAYZ_DISABLE_PERSONAL_LIGHT};" >> serverDZ.cfg
echo "lightingConfig = ${DAYZ_LIGHTING_CONFIG};" >> serverDZ.cfg
echo "serverTime = \"${DAYZ_SERVER_TIME}\";" >> serverDZ.cfg
echo "serverTimeAcceleration = ${DAYZ_SERVER_TIME_ACCELERATION};" >> serverDZ.cfg
echo "serverNightTimeAcceleration=${DAYZ_SERVER_NIGHT_TIME_ACCELERATION};" >> serverDZ.cfg
echo "serverTimePersistent = ${DAYZ_SERVER_TIME_PERSISTENT};" >> serverDZ.cfg
echo "guaranteedUpdates = 1;" >> serverDZ.cfg
echo "loginQueueConcurrentPlayers = ${DAYZ_LOGIN_QUEUE_CONCURRENT_PLAYERS};" >> serverDZ.cfg
echo "loginQueueMaxPlayers = ${DAYZ_LOGIN_QUEUE_MAX_PLAYERS};" >> serverDZ.cfg
echo "instanceId = 1;" >> serverDZ.cfg
echo "storageAutoFix = ${DAYZ_STORAGE_AUTO_FIX};" >> serverDZ.cfg
echo "class Missions { class DayZ { template=\"${DAYZ_MISSION}\"}; };" >> serverDZ.cfg

./DayZServer -config=serverDZ.cfg -port=${SERVER_PORT} -mod=${DAYZ_MODS} -servermod=${DAYZ_SERVER_MODS} -BEpath=battleye -profiles=profiles -dologs -adminlog -netlog -freezecheck ${SERVER_ARGS}