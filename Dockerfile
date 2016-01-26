# BringTheDip.com Docker / NodeJS Build Worker Dockerfile
FROM centos:centos7

# Install OpenJDK 1.8.x
RUN yum -y install java-1.8.0-openjdk 

# Install the GoCD Agent Base
ADD thoughtworks-gocd.repo /etc/yum.repos.d/thoughtworks-gocd.repo
RUN yum -y install go-agent
ADD go-agent-runner.sh /go-agent-runner.sh

# Install NodeJS 5.x Latest RPM Source
RUN yum install -y gcc-c++ make
RUN	curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -
RUN 	yum -y install nodejs

# Install Common Helper Packages
RUN     npm install -g \
            eslint \
            phantomjs \
            rimraf

VOLUME /var/lib/go-agent
CMD ["/go-agent-runner"]