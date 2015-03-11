FROM java:8-jdk
MAINTAINER Levi Stephen <levi.stephen@gmail.com>

RUN apt-get update && apt-get install -y openssh-server ruby

RUN curl -sSL https://get.docker.com/ubuntu/ | sh

RUN gem install construi

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

#TODO move this into an entrypoint
RUN adduser --quiet jenkins && echo "jenkins:jenkins" | chpasswd

RUN mkdir -p /var/jenkins && chown jenkins:jenkins /var/jenkins

COPY git_ssh.sh /usr/bin/git_ssh.sh
RUN chmod +x /usr/bin/git_ssh.sh

ENV GIT_SSH /usr/bin/git_ssh.sh

VOLUME /var/jenkins

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

