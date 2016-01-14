TEMPLATE = app

QT += qml quick network core
CONFIG += c++11

SOURCES += src/main.cpp \
           src/downloader.cpp \
           src/qfile.cpp \
    src/qqmlprocess.cpp

HEADERS += \
           src/downloader.h \
           src/qfile.h \
    src/qqmlprocess.h

RESOURCES += \
           qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)



