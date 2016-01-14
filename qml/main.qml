import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import MyApp 1.0

Window {
    visible: true
    width: Screen.width / 2
    height: Screen.height / 2
    color: "#c7c7c7"
    //NetworkTab
    property string networkTabString
    property int max
    property int val
    property bool showProgression: false

    // process Tab
    property string systemCallOutPut

    TabView{
        anchors.fill: parent
        Tab{
            title: qsTr("Downloading and Viewing a File")
                NetworkTab{
                    id: networkTab
                }
        }
        Tab{
            title: qsTr("Running a System Command")
            Rectangle{
                color: "#c7c7c7"
                ProcessTab{
                    id: processTab
                }
            }
        }
    }

    // The c++ classes
    Downloader{
        id: downloader
        onFinished: {
            showProgression = false
            // open the file now that we downloaded it
            reader.fileName =  savedFile
            reader.exec()
        }
        onBytesReceivedChanged:{
            val =  bytesReceived
        }
        onBytesTotalChanged:{
            max = bytesTotal
        }

    }
    QQmlFile{
        id: reader
        onError: console.log("There has been a error " + errorString +" "+ fileName)
        onTextChanged: networkTabString = outPut
    }
    QQmlFile{
        id: writer
        fileName: reader.fileName
        onError: console.log("There has been a error " + errorString)
        type: QQmlFile.Write
    }

}
