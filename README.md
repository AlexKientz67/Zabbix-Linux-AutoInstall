# Installation et Configuration de Zabbix Agent

Ce script permet d'installer et de configurer automatiquement l'agent Zabbix sur plusieurs distributions Linux.

## Compatibilité
Le script prend en charge les distributions suivantes :
- Ubuntu
- Debian
- CentOS
- RHEL
- Rocky Linux
- AlmaLinux
- Fedora
- Alpine Linux
- Arch Linux
- Manjaro
- openSUSE
- SLES

## Prérequis
- Accès root ou sudo
- Connexion Internet pour télécharger les paquets

## Installation

### Méthode 1 : 

Exécutez la commande : 
```curl -sSL https://raw.githubusercontent.com/AlexKientz67/Zabbix-Linux-AutoInstall/main/install.bash | bash -s <IP_ZABBIX_SERVER>``` 

### Méthode 2 :

Clonez le dépôt et exécutez le script :

```bash
git clone <URL_DU_REPO>
cd <NOM_DU_REPO>
chmod +x install_zabbix.sh
./install_zabbix.sh <IP_ZABBIX_SERVER>
```

Remplacez `<IP_ZABBIX_SERVER>` par l'adresse IP du serveur Zabbix.

## Fonctionnement
1. Détecte automatiquement la distribution Linux.
2. Installe Zabbix Agent en fonction de la distribution.
3. Configure le fichier `zabbix_agentd.conf` avec l'IP fournie en argument.
4. Active et démarre le service Zabbix Agent.

## Vérification
Après installation, vérifiez que l'agent fonctionne correctement :

```bash
systemctl status zabbix-agent
```

Sur Alpine Linux :
```bash
service zabbix-agentd status
```

## Désinstallation
Si nécessaire, vous pouvez supprimer l'agent Zabbix avec la commande adaptée à votre distribution. Exemple pour Debian/Ubuntu :

```bash
apt remove --purge -y zabbix-agent
```

## Licence
Ce projet n'est pas soumis a license.