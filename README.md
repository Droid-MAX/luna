LUNA
===

apply udev rules to system

```
cp *.rules /etc/udev/rules.d/
udevadm control --reload-rules
```

install docker and build images

```
sudo apt install -y docker.io
sudo systemctl start docker.service
sudo docker build -t LUNA:latest .
```

deploying and running container

```
sudo docker run -it --rm --privileged=true -v /dev/bus/usb:/dev/bus/usb LUNA
```

or pull docker image to run

```
sudo docker pull droidmax61/LUNA
sudo docker run -it --rm --privileged=true -v /dev/bus/usb:/dev/bus/usb droidmax61/LUNA
poetry run luna/applets/interactive-test.py
```
