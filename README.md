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
sudo docker build .
```

deploying and running container

```
sudo docker run -it luna-test <image-id>
```
