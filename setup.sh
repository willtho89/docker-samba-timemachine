#!/usr/bin/env sh

#defaults
TM_USER="${TM_USER:-timemachine}"
TM_PW="${TM_PW:-timemachine}"
TM_ID="${TM_ID:-1000}"
TM_SIZE="${TM_SIZE:-512000}"
#Add smb user
    grep -q "^${TM_USER}:" /etc/passwd ||
        adduser -D -H ${TM_GROUP:+-G $TM_GROUP} ${TM_ID:+-u $TM_ID} "${TM_USER}"
    echo -e "${TM_PW}\n${TM_PW}" | smbpasswd -s -a "${TM_USER}"

## timemachine location
if [ ! -d "/timemachine" ]; then
    mkdir "/timemachine"
fi


chown -R ${TM_USER} "/timemachine"

sed "s#REPLACE_TM_SIZE#${TM_SIZE}#" /tmp/template_quota > /timemachine/.com.apple.TimeMachine.quota.plist

# run CMD
exec "${@}"