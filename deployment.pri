unix:!android {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/
        } else {
            target.path = /usr/share/$${TARGET}/
        }
        export(target.path)
    }
    INSTALLS += target
}

export(INSTALLS)

