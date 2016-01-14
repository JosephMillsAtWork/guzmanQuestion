import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

ColumnLayout{
    width: parent.width
    height: parent.height - 20
    property bool showProgress: false
    property alias maximumValue: progressBar.maximumValue
    property alias value: progressBar.value
    property string editString
    Component.onCompleted: progressBar.visible = false

    Text {
        text: qsTr("\nFile to download")
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
            visible: showProgression
            maximumValue: max
            value: val
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
        onTextChanged: downloader.savePath = text
        Component.onCompleted: downloader.savePath = text
    }

    TextArea{
        id: editFile
        text: networkTabString
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

