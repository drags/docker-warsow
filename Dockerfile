FROM ubuntu:14.04
MAINTAINER Tim Sogard <docker@timsogard.com>

ADD cfg /opt/wsw_cfg/
RUN apt-get update
RUN apt-get install wget libcurl3 libcurl3-gnutls -y

# Install game from warsow.net
RUN wget --progress=dot:giga -O warsow_1.51_unified.tar.gz http://www.warsow.eu/warsow_1.51_unified.tar.gz

RUN tar zxvf warsow_1.51_unified.tar.gz -C /opt/
RUN chmod +x /opt/warsow_15/wsw_server*

# Setup user
RUN useradd -m -s /bin/bash warsow
RUN chown -R warsow:warsow /opt/warsow_15

# Copy server config into place
RUN cp /opt/wsw_cfg/dedicated_autoexec.cfg /opt/warsow_15/basewsw/

# Setup server
WORKDIR /opt/warsow_15
USER warsow
EXPOSE 44400/udp

CMD ./wsw_server +set fs_usehomedir 0 +set fs_basepath /opt/warsow_15/ +set dedicated 1
