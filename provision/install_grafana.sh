sudo apt update

sudo apt-get install -y gnupg2 curl software-properties-common

curl https://packages.grafana.com/gpg.key | sudo apt-key add -

sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

sudo apt update

sudo apt -y install grafana

systemctl start grafana-server

systemctl enable grafana-server