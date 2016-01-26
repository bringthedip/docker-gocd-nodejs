#!/bin/bash
set -e

GO_SERVER=${GO_SERVER:-go-server}

COLOR_START="[01;34m"
COLOR_END="[00m"

echo Creating config path
mkdir -p /var/lib/go-agent/config

echo -e "${COLOR_START}Starting Go Agent to connect to server $GO_SERVER ...${COLOR_END}"
sed -i -e 's/GO_SERVER=.*/GO_SERVER='$GO_SERVER'/' /etc/default/go-agent

# echo export DAEMON=N >> /etc/default/go-agent 
echo Adding Go to sudoers
echo go ALL=NOPASSWD: /usr/bin/docker >> /etc/sudoers 

echo Removing old registration files
/bin/rm -f /var/lib/go-agent/config/autoregister.properties

AGENT_KEY="${AGENT_KEY:-123456789abcdef}"
echo Building new agent config for registration
echo "agent.auto.register.key=$AGENT_KEY" >/var/lib/go-agent/config/autoregister.properties
if [ -n "$AGENT_RESOURCES" ]; then echo "agent.auto.register.resources=$AGENT_RESOURCES" >>/var/lib/go-agent/config/autoregister.properties; fi
if [ -n "$AGENT_ENVIRONMENTS" ]; then echo "agent.auto.register.environments=$AGENT_ENVIRONMENTS" >>/var/lib/go-agent/config/autoregister.properties; fi
if [ -n "$AGENT_NAME" ]; then echo "agent.auto.register.hostname=$AGENT_NAME" >>/var/lib/go-agent/config/autoregister.properties; fi

echo Starting agent
/etc/init.d/go-agent start