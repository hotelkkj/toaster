#!/bin/bash

success() {
    echo -e "$(tput setaf 2)$1$(tput sgr0)"
}

warning() {
    echo -e "$(tput setaf 1)$1$(tput sgr0)"
}

################################################################################

# linux
OS_NAME="$(uname)"
OS_FULL="$(uname -a)"
if [ "${OS_NAME}" == "Linux" ]; then
    if [ $(echo "${OS_FULL}" | grep -c "amzn1") -gt 0 ]; then
        OS_TYPE="amzn1"
    elif [ $(echo "${OS_FULL}" | grep -c "el6") -gt 0 ]; then
        OS_TYPE="el6"
    elif [ $(echo "${OS_FULL}" | grep -c "el7") -gt 0 ]; then
        OS_TYPE="el7"
    elif [ $(echo "${OS_FULL}" | grep -c "generic") -gt 0 ]; then
        OS_TYPE="generic"
    elif [ $(echo "${OS_FULL}" | grep -c "coreos") -gt 0 ]; then
        OS_TYPE="coreos"
    fi
elif [ "${OS_NAME}" == "Darwin" ]; then
    OS_TYPE="${OS_NAME}"
fi

if [ "${OS_TYPE}" == "" ]; then
    warning "${OS_FULL}"
    warning "Not supported OS. [${OS_NAME}][${OS_TYPE}]"
    exit 1
fi

# root
if [ "${HOME}" == "/root" ]; then
    warning "ROOT account is not supported."
    #exit 1
fi

################################################################################

REPO="http://toast.sh"

################################################################################

if [ ! -d ~/toaster ]; then
    mkdir ~/toaster
fi

# version
curl -s -o /tmp/toaster.new ${REPO}/toaster.txt

if [ ! -f /tmp/toaster.new ]; then
    warning "Can not download. [version]"
    exit 1
fi

if [ -f /tmp/toaster.old ]; then
    NEW="$(cat /tmp/toaster.new)"
    OLD="$(cat /tmp/toaster.old)"

    if [ "${NEW}" == "${OLD}" ]; then
        success "Already have latest version. [${OLD}]"
        exit 0
    fi

    MSG="Latest version updated. [${OLD} -> ${NEW}]"
else
    MSG="Toast.sh installed."
fi

# download
curl -s -o /tmp/toaster.tar.gz ${REPO}/toaster.tar.gz

if [ ! -f /tmp/toaster.tar.gz ]; then
    warning "Can not download. [toast.sh]"
    exit 1
fi

# install
tar -zxf /tmp/toaster.tar.gz -C ~/toaster

# cp version
cp -rf /tmp/toaster.new /tmp/toaster.old

# done
success "${MSG}"
