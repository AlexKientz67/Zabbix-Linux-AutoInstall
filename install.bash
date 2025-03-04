#!/bin/bash

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$ID
else
    echo "Impossible de détecter le système d'exploitation."
    exit 1
fi

if [[ -z "$1" ]]; then
    echo "Usage: $0 <IP_ZABBIX_SERVER>"
    exit 1
fi

ZABBIX_SERVER="$1"
ZABBIX_AGENT_CONF="/etc/zabbix/zabbix_agentd.conf"

install_zabbix_agent() {
    case "$OS" in
        ubuntu|debian)
            wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+$(lsb_release -sc)_all.deb
            dpkg -i zabbix-release_6.0-4+$(lsb_release -sc)_all.deb
            apt update
            apt install -y zabbix-agent
            ;;
        centos|rhel|rocky|almalinux|fedora)
            rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/$(rpm -E %rhel)/x86_64/zabbix-release-6.0-2.el$(rpm -E %rhel).noarch.rpm
            dnf clean all
            dnf install -y zabbix-agent
            ;;
        alpine)
            apk update
            apk add curl zabbix-agent
            ;;
        arch|manjaro)
            pacman -Sy --noconfirm zabbix-agent
            ;;
        opensuse|sles)
            zypper refresh
            zypper install -y zabbix-agent
            ;;
        *)
            echo "Système non supporté."
            exit 1
            ;;
    esac
}

configure_zabbix_agent() {
    sed -i "s/^Server=.*/Server=$ZABBIX_SERVER/" "$ZABBIX_AGENT_CONF"
    sed -i "s/^ServerActive=.*/ServerActive=$ZABBIX_SERVER/" "$ZABBIX_AGENT_CONF"
    if [[ "$OS" == "alpine" ]]; then
        rc-update add zabbix-agentd
        service zabbix-agentd start
    elif [[ "$OS" == "arch" || "$OS" == "manjaro" ]]; then
        systemctl enable --now zabbix-agent
    else
        systemctl enable --now zabbix-agent
    fi
}

install_zabbix_agent
configure_zabbix_agent

echo "Installation et configuration terminées."
