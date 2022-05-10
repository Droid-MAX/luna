FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q git python3 python3-dev python3-pip libusb-1.0-0-dev && rm -rf /var/lib/apt/lists/*
RUN pip install poetry yowasp-yosys yowasp-nextpnr-ecp5
RUN find $(dirname $(which yowasp-yosys)) -type f -name "yowasp-*" -execdir bash -c 'x="{}";mv -v $x ${x##*yowasp-}' \;

RUN git clone --depth=1 https://github.com/greatscottgadgets/luna
WORKDIR /luna
RUN poetry install

ENTRYPOINT ["/bin/bash"]
