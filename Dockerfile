FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y gdb

RUN mkdir -p /app

# RUN mkdir .steam/
# COPY ./.steam /app/.steam/

# COPY ./csds/ /app/

# RUN cd /home/app/csds/

RUN apt-get install -y lib32gcc-s1 && apt-get install -y lib32stdc++6
RUN wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" -P /steam && \
    tar zxvf /steam/steamcmd_linux.tar.gz --directory /steam
# RUN ./steam/steamcmd.sh +force_install_dir /app/ +login anonymous +app_update 232330 validate  +quit
RUN ./steam/steamcmd.sh +force_install_dir /app/ +login anonymous +app_update 232330 validate  +quit

WORKDIR /app

CMD ["./srcds_run", "-game cstrike", "-console", "-insecure", "-nomaster", "+sv_lan 1", "+maxplayers 12", "+map de_dust2", "-debug"]
