add port
sudo firewall-cmd --zone=public --add-port=5000/tcp
firewall-cmd --zone=public add-port=2888/tcp
firewall-cmd --reload
