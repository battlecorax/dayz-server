FROM ubuntu:20.04

#Environment variables
ENV DEBIAN_FRONTEND=noninteractive

ENV STEAM_USERNAME=
ENV STEAM_PASSWORD=
ENV STEAM_GUARD=
ENV SERVER_DIR=/dayz-server
ENV SERVER_PORT=2302
ENV SERVER_ARGS=
ENV DAYZ_SERVER_MODS=
ENV DAYZ_MODS=

EXPOSE ${SERVER_PORT}/udp
EXPOSE 8766/udp
EXPOSE 27016/udp

# Enable multiverse repository and add i386 architecture
RUN apt update; apt install software-properties-common -y; dpkg --add-architecture i386; apt update

# Install dependencies
RUN apt install curl wget -y

# Install steamcmd
RUN echo steam steam/question select "I AGREE" | debconf-set-selections; echo steam steam/license note '' | debconf-set-selections
RUN apt install steamcmd -y

# Create server folder
RUN mkdir ${SERVER_DIR}
WORKDIR ${SERVER_DIR}

# Entry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]