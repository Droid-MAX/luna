FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && apk --no-cache add gcc git python3 python3-dev py3-pip libusb libffi-dev libxslt-dev libressl-dev musl-dev rust cargo
RUN cat > ~/.cargo/config << EOF \
[source.crates-io] \
replace-with = 'tuna' \
[source.tuna] \
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git" \
EOF
RUN git clone --depth=1 https://github.com/greatscottgadgets/luna
RUN pip install poetry yowasp-yosys yowasp-nextpnr-ecp5 -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN find $(dirname $(which yowasp-yosys)) -type f -name "yowasp-*" -exec sh -c 'x="{}";mv -v $x ${x##*yowasp-}' \;
WORKDIR ./luna
RUN cat >> pyproject.toml << EOF \
[[tool.poetry.source]] \
name = "tsinghua" \
url = "https://pypi.tuna.tsinghua.edu.cn/simple/" \
EOF
RUN poetry install

CMD ["poetry","run","applets/interactive-test.py"]
