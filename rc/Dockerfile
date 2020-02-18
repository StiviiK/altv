FROM mcr.microsoft.com/dotnet/core/sdk:3.1
LABEL maintainer="StiviK <docker@stivik.de>"

# small fix for debian ci builds
ARG DEBIAN_FRONTEND=noninteractive

# Environment
ENV PORT 7788
ENV SERVER_DIR /var/altv/server/

# Install deps
RUN apt update && \
    apt install -y wget libc-bin libatomic1
    
# Download binaries
ARG CDN_BASE_URL=https://cdn.altv.mp
ARG BRANCH=rc
ARG SALT=s7w8ov

# Prepare server folder
RUN mkdir -p ${SERVER_DIR}/data && \
    mkdir -p ${SERVER_DIR}/modules && \
    mkdir -p ${SERVER_DIR}/resources-data && \
    mkdir -p ${SERVER_DIR}/config && \
    mkdir -p ${SERVER_DIR}/bin
ENV PATH="${SERVER_DIR}/bin:${PATH}"

# Download required binaries
RUN wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/altv-server                       ${CDN_BASE_URL}/server/${BRANCH}/x64_linux/altv-server?salt=${SALT} && \
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/config/server.cfg                 ${CDN_BASE_URL}/others/server.cfg?salt=${SALT} && \
    # NodeJS
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/modules/libnode-module.so         ${CDN_BASE_URL}/node-module/${BRANCH}/x64_linux/modules/libnode-module.so?salt=${SALT} && \
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/libnode.so.72                     ${CDN_BASE_URL}/node-module/${BRANCH}/x64_linux/libnode.so.72?salt=${SALT} && \
    # .NET
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/modules/libcsharp-module.so       ${CDN_BASE_URL}/coreclr-module/${BRANCH}/x64_linux/modules/libcsharp-module.so?salt=${SALT} && \
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/AltV.Net.Host.dll                 ${CDN_BASE_URL}/coreclr-module/${BRANCH}/x64_linux/AltV.Net.Host.dll?salt=${SALT} && \
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/AltV.Net.Host.runtimeconfig.json  ${CDN_BASE_URL}/coreclr-module/${BRANCH}/x64_linux/AltV.Net.Host.runtimeconfig.json?salt=${SALT} && \
    # DATA
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/data/vehmodels.bin                ${CDN_BASE_URL}/server/${BRANCH}/x64_linux/data/vehmodels.bin?salt=${SALT} && \
    wget --no-cache -nv --show-progress --progress=bar:force:noscroll -O ${SERVER_DIR}/data/vehmods.bin                  ${CDN_BASE_URL}/server/${BRANCH}/x64_linux/data/vehmods.bin?salt=${SALT}

# Remove unused packages
RUN apt purge -y wget && \
    apt clean && \
    apt autoremove -y

# Expose ports and start the Server
WORKDIR ${SERVER_DIR}
EXPOSE ${PORT}/tcp
EXPOSE ${PORT}/udp

# Add altv-server to PATH
RUN ln -s ${SERVER_DIR}/altv-server ${SERVER_DIR}/bin/altv-server

# Fix libaries
ENV LD_LIBRARY_PATH=${SERVER_DIR}

# Fix permissions
RUN chmod +x altv-server

ENTRYPOINT ["altv-server", "--config", "config/server.cfg", "--logfile", "logs/server.log"]