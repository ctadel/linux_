# create directory just incase
mkdir /etc/kanata

# copying the service file to etc
cp /home/prajwal/.config/kanata/kanata.service /etc/kanata/kanata.service
echo 'Service file copied to /etc/'

# create the service
install -m 644 /etc/kanata/kanata.service /lib/systemd/system/kanata.service
echo 'Service Installed to systemd'

# add the service to startup
systemctl enable kanata
systemctl start kanata
echo 'Service enabled and started'
