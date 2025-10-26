FROM ubuntu:20.04

#Environment variables
ARG SERVER_DIR=/server

ENV DEBIAN_FRONTEND=noninteractive
ENV SERVER_PORT=2302
ENV DAYZ_HOSTNAME="My DayZ Server"
ENV DAYZ_PASSWORD=""
ENV DAYZ_ADMIN_PASSWORD="admin123"
ENV DAYZ_DESCRIPTION="Welcome to my DayZ server!"
ENV DAYZ_ENABLE_WHITELIST=0
ENV DAYZ_MAX_PLAYERS=60
ENV DAYZ_FORCE_SAME_BUILD=1
ENV DAYZ_DISABLE_VON=0
ENV DAYZ_VON_CODEC_QUALITY=20
ENV DAYZ_SHARD_ID="123abc"
ENV DAYZ_DISABLE_3RD_PERSON=0
ENV DAYZ_DISABLE_CROSSHAIR=0
ENV DAYZ_DISABLE_PERSONAL_LIGHT=1
ENV DAYZ_LIGHTING_CONFIG=1
ENV DAYZ_SERVER_TIME="SystemTime"
ENV DAYZ_SERVER_TIME_ACCELERATION=12
ENV DAYZ_SERVER_NIGHT_TIME_ACCELERATION=1
ENV DAYZ_SERVER_TIME_PERSISTENT=1
ENV DAYZ_LOGIN_QUEUE_CONCURRENT_PLAYERS=5
ENV DAYZ_LOGIN_QUEUE_MAX_PLAYERS=500
ENV DAYZ_STORAGE_AUTO_FIX=1
ENV DAYZ_MISSION="dayzOffline.chernarusplus"

EXPOSE ${SERVER_PORT}/udp
EXPOSE 8766/udp
EXPOSE 27016/udp

# Setting up license acceptance for steamcmd
RUN echo steam steam/question select "I AGREE" | debconf-set-selections; echo steam steam/license note '' | debconf-set-selections

# Enable multiverse repository and add i386 architecture
RUN apt update; apt install software-properties-common -y; dpkg --add-architecture i386; apt update; apt install curl wget steamcmd -y

# Installing the dayz standalone server
RUN mkdir ${SERVER_DIR}; mkdir ${SERVER_DIR}/mpmissions; mkdir ${SERVER_DIR}/missions-available; mkdir ${SERVER_DIR}/user-mods;
WORKDIR ${SERVER_DIR}

# Copies over install script and runs it
RUN --mount=type=secret,id=steam_user --mount=type=secret,id=steam_pass  \
    /usr/games/steamcmd +force_install_dir ${SERVER_DIR} \
    +login $(cat /run/secrets/steam_user) $(cat /run/secrets/steam_pass) \
    +app_update 223350 validate \
    +quit

# Downloading the mission files
RUN curl -s https://api.github.com/repos/BohemiaInteractive/DayZ-Central-Economy/releases/latest \
| grep "tarball_url" \
| cut -d : -f 2,3 \
| tr -d \", \
| wget -P /tmp/missions -qi -

RUN tar -xzvf /tmp/missions/DZ_* --strip=1 -C /tmp/missions
RUN cp -r /tmp/missions/dayzOffline.* ${SERVER_DIR}/missions-available/
RUN rm -rf /tmp/missions

# Clean up steamcmd data to remove user information
RUN rm -rf /root/.steam

# Entry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]