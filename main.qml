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
    Component.onCompleted: progressBar.visible = false
    ColumnLayout{
        width: parent.width
        height: parent.height - 20

        Text {
            text: qsTr("File to download")
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField{
            id: filetoDownload
            text: "http://www.gnu.org/licenses/gpl-3.0.txt"
            Layout.preferredWidth: parent.width / 1.07
            Layout.alignment: Qt.AlignHCenter
        }

        Button{
            text: qsTr("Download file")
            Layout.preferredWidth: parent.width / 1.07
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                progressBar.visible = true
                // set the download file
                downloader.file = filetoDownload.text
                //download the file
                downloader.doDownload()
            }

        }

        RowLayout{
            width: parent.width / 1.07
            Layout.alignment: Qt.AlignHCenter

            ProgressBar{
                id: progressBar
            }
            Text {
                id: whatIsLeft
                visible: progressBar.visible
                text:{
                    var dis = downloader.incommingSpeed
                    var toFixed = dis.toFixed(2)
                    "Speed " + toFixed + " " + downloader.units
                }
            }
        }

        Text {
            text: qsTr("Where to save the file")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField{
            id: savePath
            text: downladFolder + "/"
            Layout.preferredWidth: parent.width / 1.07
            Layout.alignment: Qt.AlignHCenter

        }

        TextArea{
            id: editFile
            Layout.preferredWidth: parent.width / 1.07
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
        }


        Button{
            id: saveButton
            text: qsTr("Save")
            Layout.preferredWidth: parent.width / 2.1
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                writer.exec()
            }
        }

    }//col



    // The c++ classes
    Downloader{
        id: downloader
        savePath: savePath.text
        onFinished: {
            progressBar.visible = false
            // open the file now that we downloaded it
            reader.fileName =  savedFile
            reader.exec()
        }
        onBytesReceivedChanged:{
            progressBar.value =  bytesReceived
        }
        onBytesTotalChanged:{
            progressBar.maximumValue = bytesTotal
        }

    }
    QQmlFile{
        id: reader
        onError: console.log("There has been a error " + errorString +" "+ fileName)
        onTextChanged: editFile.text = outPut
    }
    QQmlFile{
        id: writer
        fileName: reader.fileName
        onError: console.log("There has been a error " + errorString)
        type: QQmlFile.Write
    }

}
