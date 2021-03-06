FROM debian
RUN apt-get -yq update
RUN apt-get -yq install unzip wget
RUN apt-get -yq install openjdk-7-jre-headless
RUN mkdir /ftb
COPY modpacks^FTBInfinity^1_2_1^FTBInfinityServer.zip /ftb/
RUN cd /ftb && unzip modpacks*.zip
RUN cd /ftb && /bin/sh FTBInstall.sh
RUN echo eula=true > /ftb/eula.txt
COPY mods/*.jar /ftb/mods/
COPY config /ftb/config/
COPY server.properties /ftb/
VOLUME ["/ftb/world"]
VOLUME ["/config"]
RUN for i in ops whitelist; do ln -s /config/$i.json /ftb/$i.json; done
EXPOSE 25565
WORKDIR /ftb
ENTRYPOINT ["/bin/sh", "ServerStart.sh"]
