FROM python:3-slim

# Install JDK 21 (Elcipse Temurin)
RUN apt-get update \
    && apt-get install apt-transport-https gpg wget -y \
    && wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null \
    && echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list \
    && apt-get update \
    && apt-get install temurin-21-jdk -y \
    && rm -f /etc/apt/trusted.gpg.d/adoptium.gpg \
    && rm -f /etc/apt/sources.list.d/adoptium.list \
    && rm -rf /var/lib/apt/lists/*

# Install required tools for F-Droid
RUN apt-get update \
    && apt-get install ca-certificates apksigner git rsync curl -y \
    && rm -rf /var/lib/apt/lists/*

# Install fdroidserver (latest versions to fix some bugs)
RUN pip install --no-cache-dir androguard \
    && rm -rf /root/.cache
RUN pip install --no-cache-dir git+https://gitlab.com/fdroid/fdroidserver.git \
    && rm -rf /root/.cache

COPY ./build.sh /build.sh
RUN chmod +x /build.sh

ENTRYPOINT [ "/bin/bash", "-c", "/build.sh" ]