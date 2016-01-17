FROM java:8-jdk
MAINTAINER Levi Stephen <levi.stephen@gmail.com>

RUN apt-get update && apt-get install -y openssh-server python python-pip

RUN curl -sSL https://get.docker.com/ | sh

COPY VERSION /etc/construi-version
RUN pip install construi==$(cat /etc/construi-version)

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
 && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN mkdir -p /var/run/sshd

RUN echo "root:jenkins" | chpasswd

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

RUN mkdir -p /var/jenkins
VOLUME /var/jenkins
EXPOSE 22

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]

