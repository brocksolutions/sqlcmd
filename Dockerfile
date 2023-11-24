ARG DEBIAN_VERSION=11
FROM debian:$DEBIAN_VERSION-slim

RUN apt-get -qqq update \
    && apt-get install -y curl apt-transport-https locales gnupg2 \
    && locale-gen "en_US.UTF-8" \
    \
    && export `grep "VERSION_ID" /etc/os-release | sed -e 's/^VERSION_ID=\"/VERSION_ID=/' -e 's/\"$//'` \
    && mkdir -p /etc/apt/keyrings/ \
    && curl --fail https://packages.microsoft.com/config/debian/$VERSION_ID/prod.list | \
        sed -E 's#deb\s+\[#deb [signed-by=/etc/apt/keyrings/microsoft.gpg #; t; q1' | \
        tee /etc/apt/sources.list.d/microsoft.list \
    && curl --fail https://packages.microsoft.com/keys/microsoft.asc | \
        gpg --verbose --yes --no-tty --batch --dearmor -o /etc/apt/keyrings/microsoft.gpg \
    \
    && apt-get -qqq update \
    && apt-get install -y sqlcmd \
    && apt-get remove -y curl apt-transport-https gnupg2 \
    && rm -f /etc/apt/sources.list.d/msprod.list \
    && rm -rf /var/lib/apt/lists/*

## should be set after locale was generated, overwise triggers warnings
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"

ENTRYPOINT ["/usr/bin/sqlcmd"]
