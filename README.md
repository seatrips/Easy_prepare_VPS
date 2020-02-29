# Easy_prepare_VPS

Prepare VPS with Sudo User and login with ssh key

### How to setup ssh key:

- [DigitalOcean guide](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2)

Tested on Ubuntu 18.04 and 16.04 with following hosts 

- [Vultr](https://www.vultr.com/?ref=7008700)
- [Hetzner](https://hetzner.com)
- [Hostwinds](https://hostwinds.com)

### Install:

```
wget https://raw.githubusercontent.com/seatrips/Easy_prepare_VPS/master/prepare.sh > /dev/null 2>&1 && bash prepare.sh
```

### What happens:
- add 2G SWAP ( change script for more or less )
- update
- upgrade
- dist-upgrade
- install fail2ban
- install htop or glances
- install/set UFW 
- allow 22 for ssh
- set custom ports
- possibility to make User with sudo rights
- copy ssh key to new User
- set passpword authentigation no
- set empty password no

@seatrips
