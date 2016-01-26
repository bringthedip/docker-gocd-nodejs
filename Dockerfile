# BringTheDip.com Docker / NodeJS Build Worker Dockerfile
FROM centos:centos7

# Install OpenJDK 1.8.x and which (required to set JAVA_HOME later)
RUN yum -y install \
    which \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

# Install the GoCD Agent Base 
#   1 - Add Repo
#   2 - yum install
#   3 - Copy agent runner script to path
#   4 - Switch agent to run as console app
#   5 - Allow agent script to execute 
ADD thoughtworks-gocd.repo /etc/yum.repos.d/thoughtworks-gocd.repo
RUN yum -y install go-agent
ADD go-agent-runner.sh /go-agent-runner.sh
RUN sed -i 's/DAEMON=Y/DAEMON=N/' /etc/default/go-agent
# Required since docker add leaves permissions unusable.
RUN chmod +777 -R /var/lib/go-agent
RUN chmod +x /go-agent-runner.sh

# Install NodeJS 5.x Latest RPM Source
RUN yum install -y gcc-c++ make
RUN	curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -
RUN 	yum -y install nodejs

# Install Common Helper Packages
RUN     npm install -g gulp

VOLUME /var/lib/go-agent
CMD ["/go-agent-runner.sh"]