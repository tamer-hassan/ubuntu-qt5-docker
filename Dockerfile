FROM ubuntu:16.04

RUN  apt-get update \
  && apt-get install -y wget xz-utils apt-transport-https  autoconf2.13 build-essential ca-certificates cmake curl git glib-2.0-dev libglu1-mesa-dev libgtk-3-dev libpulse-dev libtool p7zip-full subversion gzip libasound2-dev libatspi2.0-dev libcups2-dev libdbus-1-dev libicu-dev libglu1-mesa-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libx11-xcb-dev libxcb* libxi-dev libxrender-dev libxss1 libncurses5 \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /build_tools
WORKDIR /build_tools

RUN wget https://download.qt.io/new_archive/qt/5.9/5.9.9/single/qt-everywhere-opensource-src-5.9.9.tar.xz -O qt_source_5.9.9.tar.xz \
  && tar -xf ./qt_source_5.9.9.tar.xz && cd qt-everywhere-opensource-src-5.9.9 \
  && ./configure -opensource -confirm-license -release -shared -accessibility -prefix ./../qt_build/Qt-5.9.9/gcc_64 \
    -qt-zlib -qt-libpng -qt-libjpeg -qt-xcb -qt-pcre -no-sql-sqlite -no-qml-debug -gstreamer 1.0 \
    -nomake examples -nomake tests -skip qtenginio -skip qtlocation -skip qtserialport -skip qtsensors -skip qtxmlpatterns -skip qt3d -skip qtwebview -skip qtwebengine \
  && make -j 4 && make install && cd .. && rm -rf qt-everywhere-opensource-src-5.9.9 && rm -f qt_source_5.9.9.tar.xz
