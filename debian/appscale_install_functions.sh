#!/bin/sh
# Common functions for build and installer
#
# This should work in bourne shell (/bin/sh)
# The function name should not include non alphabet charactor.
#
# Written by Yoshi <nomura@pobox.com>

set -e

if [ -z "$APPSCALE_TOOLS_HOME" ]; then
    export APPSCALE_TOOLS_HOME=/root/appscale
fi

installappscaletools()
{
    # add to path
    mkdir -p ${DESTDIR}/etc/profile.d
    cat > ${DESTDIR}/etc/profile.d/appscale-tools.sh <<EOF
export TOOLS_PATH=/usr/local/appscale-tools
export PATH=\${PATH}:\${TOOLS_PATH}/bin
EOF

    cat >> ~/.bashrc <<EOF
export TOOLS_PATH=/usr/local/appscale-tools
export PATH=\${PATH}:\${TOOLS_PATH}/bin
EOF
}

keygen()
{
    # create ssh private key if it does not exist
    test -e /root/.ssh/id_rsa || ssh-keygen -q -t rsa -f /root/.ssh/id_rsa -N ""
}
