FROM ubuntu:20.04

RUN sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && sed -i "s/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q git python3 python3-dev python3-pip libusb-1.0-0-dev && rm -rf /var/lib/apt/lists/*
RUN pip install poetry yowasp-yosys yowasp-nextpnr-ecp5 -i https://pypi.tuna.tsinghua.edu.cn/simple/
RUN find $(dirname $(which yowasp-yosys)) -type f -name "yowasp-*" -exec sh -c 'x="{}";mv -v $x ${x##*yowasp-}' \;

RUN git clone --depth=1 https://github.com/greatscottgadgets/luna
WORKDIR ./luna
RUN poetry install

CMD ["poetry","run","applets/interactive-test.py"]
