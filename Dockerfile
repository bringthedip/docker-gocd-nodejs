# BringTheDip.com Docker / NodeJS Build Worker Dockerfile
FROM centos:centos7

# Install NodeJS 5.x Latest RPM Source
RUN	curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -

# Install the GoCD Agent
RUN     yum install -y go-agent

# Install NodeJS
RUN 	yum -y install nodejs

# Install Common Helper Packages
RUN     npm install -g \
            eslint \
            phantomjs \
            rimraf

VOLUME /var/lib/go-agent
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD go-agent-runner.sh /go-agent-runner.sh

CMD ["/go-agent-runner"]