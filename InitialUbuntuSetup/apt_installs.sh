#!/usr/bin/env bash

printStatus() {
    #if [[ $VERBOSE == true ]]; then
    printf "[STATUS] %s\n" "${1}"
    #fi
}

printError() {
    printf "[ERROR] %s\n" "${1}"
}

printWarning() {
    printf "[WARNING] %s\n" "${1}"
}

SUDO=""

if [[ $EUID != 0 ]]; then
    SUDO="sudo"
fi

if ! command curl --version &>/dev/null; then
    printStatus "Curl is not installed but needed for this script"
    printStatus "Installing Curl"
    ${SUDO} apt install curl
fi

if ! command ssh -V &>/dev/null; then
    printStatus "Installing ssh"
    sudo apt install openssh-server
    printStatus "Enabling ssh"
    sudo systemctl enable ssh
else
    printStatus "Openssh-server is already installed"
fi

printStatus "Installing build-essential kit"
${SUDO} apt install build-essential

printStatus "Installing OpenGL"
${SUDO} apt install freeglut3-dev

if ! command git version &>/dev/null; then
    printStatus "Installing git"
    ${SUDO} apt install git-all
else
    printStatus "Git is already installed"
fi

if ! command ninja --version &>/dev/null; then
    printStatus "Installing ninja"
    ${SUDO} apt install ninja-build
else
    printStatus "Ninja is already installed"
fi

if ! command python3 --version &>/dev/null; then
    printStatus "Installing python3"
    ${SUDO} apt install python3
else
    printStatus "Python3 is already installed"
fi

if ! command meld --version &>/dev/null; then
    printStatus "Installing Meld"
    ${SUDO} apt install meld
else
    printStatus "Meld is already installed"
fi

if ! command transmission-gtk --version &>/dev/null; then
    printStatus "Installing Transmission"
    ${SUDO} apt install transmission
else
    printStatus "Transmission is already installed"
fi

if ! command glxinfo -h &>/dev/null; then
    printStatus "Installing glxinfo"
    ${SUDO} apt install mesa-utils
else
    printStatus "glxinfo is already installed"
fi

if ! command perf -h &>/dev/null; then
    printStatus "Installing Perf"
    ${SUDO} apt install linux-tools-$(uname -r) linux-tools-generic
else
    printStatus "Perf is already installed"
fi
