#! bash

env > /tmp/wofi-env.txt

xhost +local:

exec docker run --rm \
  --name wework \
  --security-opt seccomp=unconfined \
  -e DISPLAY=$DISPLAY \
  -e LIBGL_ALWAYS_SOFTWARE=1 \
  -e QT_DEBUG_PLUGINS=1 \
  -e QT_XCB_GL_INTEGRATION=none \
  -e XAUTHORITY=/tmp/.Xauthority \
  -e QT_XCB_GL_INTEGRATION=none \
  -e GDK_SCALE=1 \
  -e GDK_DPI_SCALE=1 \
  -e XMODIFIERS=@im=fcitx \
  -e GTK_IM_MODULE=fcitx5 \
  -e QT_IM_MODULE=fcitx5 \
  -e SDL_IM_MODULE=fcitx5 \
  -e XIM=fcitx \
  -e XIM_PROGRAM=fcitx \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /run/user/$(id -u)/pulse:/run/user/1000/pulse \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native \
  -v /run/user/$(id -u)/bus:/run/user/1000/bus \
  -e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
  -v ~/.wework/.WXWorkLocalPro:/home/wework/.WXWorkLocalPro \
  wework-ubuntu
