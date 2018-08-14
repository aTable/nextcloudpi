sudo apt-get install -y git
## docker
# https://medium.freecodecamp.org/the-easy-way-to-set-up-docker-on-a-raspberry-pi-7d24ced073ef
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
sudo groupadd docker
sudo gpasswd -a $USER docker

## docker compose
sudo apt-get install python python-pip -y
sudo pip install docker-compose

## mount hdd
mkdir /media/externalhdd
# modify /etc/fstab but do it SAFELY, errors here will require a re-image

## nextcloud
git clone https://github.com/nextcloud/nextcloudrpi.git
cd nextcloudrpi
# modify the docker-compose-armhf.yml file to contain your newly mounted volume e.g.
# volumes:
  # - ncdata:/data
  # - /media/externalhdd:/media/externalhdd
# https://unix.stackexchange.com/questions/8518/how-to-get-my-own-ip-address-and-save-it-to-a-variable-in-a-shell-script
ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
IP=${ip4} docker-compose -f docker-compose-armhf.yml up -d

## nextcloud ui 
# enable official external storage app
# https://docs.nextcloud.com/server/12/admin_manual/configuration_files/external_storage_configuration_gui.html
# Top right > settings > browse admin settings (NOT user settings) for "External Storages" 
# add the external folder to /media/externalhdd/data

######## commands
IP="192.168.1.103" docker-compose -f docker-compose-armhf.yml up -d
IP="192.168.1.103" docker-compose -f docker-compose-armhf.yml down

