FROM ubuntu:trusty

MAINTAINER Matthew Newton <contact@mnewton.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update
RUN apt-get -qy install apt-transport-https
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
RUN echo "deb https://apt.sonarr.tv/ develop main" | sudo tee /etc/apt/sources.list.d/sonarr.list
RUN apt-get -q update
RUN apt-get install -qy nzbdrone

RUN chown -R nobody:users /opt/NzbDrone \
  ; mkdir -p /config/sonarr /data/complete /data/media

EXPOSE 8989
VOLUME /config
VOLUME /data

ADD start.sh /start.sh
RUN chmod +x /start.sh

ADD sonarr-update.sh /sonarr-update.sh
RUN chmod 755 /sonarr-update.sh \
  && chown nobody:users /sonarr-update.sh

USER nobody
WORKDIR /opt/NzbDrone

ENTRYPOINT ["/start.sh"]
