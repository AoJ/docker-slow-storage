#!/bin/bash

mkdir -p ${LOCAL_DIR}
ssh ${REMOTE_HOST} mkdir -p ${REMOTE_DIR}/${HOSTNAME}
sshfs ${REMOTE_HOST}:${REMOTE_DIR}/${HOSTNAME} ${LOCAL_DIR} -o reconnect,idmap=user,dev,suid,nonempty
echo $(date +%F--%T) started >> ${LOCAL_DIR}/log
