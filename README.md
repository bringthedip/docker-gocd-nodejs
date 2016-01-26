# docker-gocd-nodejs
Docker container image for running a GoCD agent that runs NodeJS application builds.

Based loosely on https://hub.docker.com/r/gocd/gocd-agent/ but:
   
   - Runs CentOS 7.
   - Configures Yum for Thoughtworks repo (since not part of Centos:CentosX builds yet)
   - Installs applicable NodeJS version
   - Installs prerequisites.
 
 Run container with
 
    docker run -ti --link gocd_server:go-server 1f167657f8eb