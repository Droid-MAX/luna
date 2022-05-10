luna-test
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
sudo docker build -t luna-test:latest .
```

deploying and running container

```
sudo docker run -it --device=/dev/ttyUSB0 luna-test
```

or pull docker image to run

```
sudo docker pull droidmax61/luna-test
sudo docker run -it --device=/dev/ttyUSB0 droidmax61/luna-test
poetry run applets/interactive-test.py
```