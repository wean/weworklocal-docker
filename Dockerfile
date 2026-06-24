FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=zh_CN.UTF-8

RUN apt update && apt install -y \
    locales \
    ca-certificates \
    dbus-x11 \
    libx11-6 \
    libxrender1 \
    libxext6 \
    libxtst6 \
    libxi6 \
    libxss1 \
    libglib2.0-0 \
    libnss3 \
    libasound2 \
    libgtk-3-0 \
    libdrm2 \
    libgbm1 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    fonts-noto-cjk \
    lsb-release \
    x11-apps \
    libgl1 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libatomic1 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    gstreamer1.0-tools \
    gstreamer1.0-x \
    gstreamer1.0-alsa \
    gstreamer1.0-gl \
    fcitx \
    fcitx-frontend-qt5 \
    fcitx-config-gtk \
    fcitx-ui-classic \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

RUN apt-get update && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY weworklocal_*.deb /tmp/wework.deb

RUN apt update && \
    mkdir -p /home/桌面 && \
    apt install -y /tmp/wework.deb || apt -f install -y

RUN useradd -m wework
USER wework
WORKDIR /home/wework

RUN rm -rf /usr/share/dbus-1/services/org.freedesktop.portal.* || true
RUN rm -rf /usr/share/xdg-desktop-portal || true

CMD ["/opt/企业微信/wwlocal", "--disable-gpu", "--disable-gpu-sandbox"]
#CMD ["xeyes"]
