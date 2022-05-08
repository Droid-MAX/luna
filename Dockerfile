FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && apk --no-cache add gcc git python3 python3-dev py3-pip libusb libffi-dev libxslt-dev libressl-dev musl-dev rust cargo
RUN mkdir -p ~/.cargo && echo -e "[source.crates-io]\nreplace-with = 'tuna'\n\n[source.tuna]\nregistry = \"https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git\"" > ~/.cargo/config
RUN git clone --depth=1 https://github.com/greatscottgadgets/luna
RUN pip install poetry yowasp-yosys yowasp-nextpnr-ecp5 -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN find $(dirname $(which yowasp-yosys)) -type f -name "yowasp-*" -exec sh -c 'x="{}";mv -v $x ${x##*yowasp-}' \;
WORKDIR ./luna
RUN echo -e "[[tool.poetry.source]]\nname = \"tsinghua\"\nurl = \"https://pypi.tuna.tsinghua.edu.cn/simple/\"" >> pyproject.toml && poetry install

CMD ["poetry","run","applets/interactive-test.py"]
