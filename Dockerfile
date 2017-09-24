FROM alpine:latest

#Both these ports are only exposed on the internal docker network

# This is the port we're going to reverse tunnel
EXPOSE 8080

# This is the normal SSHd port (this gets mapped to 
#  external port 2222 in the docker-compose.yml file)
EXPOSE 22

RUN apk --update add openssh \
  && sed -i 's/#GatewayPorts no.*/GatewayPorts\ yes/' /etc/ssh/sshd_config \
  && rm -rf /var/cache/apk/*

RUN \
  passwd -d root && \
  adduser -D -s /bin/ash tunnel && \
  passwd -u tunnel && \
  chown -R tunnel:tunnel /home/tunnel && \
  ssh-keygen -A

COPY identity.pub /home/tunnel/.ssh/authorized_keys

CMD /usr/sbin/sshd -D
