FROM python:3-alpine
WORKDIR /app
RUN apk add --virtual=.run-deps git bash findutils jq ca-certificates && \
    mkdir -p /data && \
    pip install PyGithub && \
    wget -O- https://github.com/c4milo/github-release/releases/download/v1.1.0/github-release_v1.1.0_linux_amd64.tar.gz | tar zxvf - && \
    mv github-release /usr/local/bin/github-release

ENV ORGANIZATION=libretro \
    PARALLEL=10 \
    PYTHONUNBUFFERED=1 \
    REPO=chauffer/libretro-snapshots

COPY . /app
CMD /app/run.sh
