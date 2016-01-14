import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import MyApp 1.0

ColumnLayout{
    id: rootProcess
    width: parent.width
    height: parent.height - 20
    property string output
    Text {
        text:{
            if(systemCall.processState === QQmlProcess.Running){
                qsTr("\nRunning Command " + systemCall.program + "With the Pid of " + systemCall.pid)
            }else if( systemCall.processState !== QQmlProcess.Running){
                qsTr("\nCommand to Run")
            }
        }
    }
    TextField{
        id: cmdTxt
        text: "ls"
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }
    Text {
        text: qsTr("Arguments")
    }
    TextField{
        id: argumentsTxt
        text: qsTr("-al %1").arg(downladFolder)
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
    }


    GridLayout{
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        columns: 2
        rows: 2
        Text {
            text: qsTr("Run Types")
        }
        Text {
            text: qsTr("Input Channel")
        }
        ComboBox{
            model: runtypesModel
            Layout.preferredWidth: parent.width / 2.1
            Layout.alignment: Qt.AlignHCenter
            currentIndex: QQmlProcess.Attached
            onCurrentIndexChanged: systemCall.runType = currentIndex
        }

        ComboBox{
            model: inputChannelModel
            Layout.preferredWidth: parent.width / 2.1
            Layout.alignment: Qt.AlignHCenter
            currentIndex: QQmlProcess.inputChannelMode
            onCurrentIndexChanged: systemCall.inputChannelMode = currentIndex
        }

    }

    GridLayout{
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        columns: 2
        rows: 2
        Text {
            text: qsTr("Channel Mode")
        }

        Text {
            text: qsTr("Channel")
        }
        ComboBox{
            model: processChannelModeModel
            Layout.preferredWidth: parent.width / 2.07
            Layout.alignment: Qt.AlignHCenter
        }
        ComboBox{
            model: processChannelModel
            Layout.preferredWidth: parent.width / 2.07
            Layout.alignment: Qt.AlignHCenter
        }
    }



    TextArea{
        id: cmdOutPut
        Layout.preferredWidth: parent.width / 1.07
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        text: systemCallOutPut
    }

    RowLayout{
        Layout.preferredWidth: parent.width / 1.07
        Layout.alignment: Qt.AlignHCenter
        Button{
            text: qsTr("Kill Command")
            Layout.preferredWidth: rootProcess.width / 2.2
            onClicked: {
                systemCall.kill()
            }
        }
        Button{
            text: qsTr("Run Command")
            Layout.preferredWidth: rootProcess.width / 2.2
            tooltip: "use this button to run a system command"
            onClicked: {
                systemCall.program = cmdTxt.text
                // We have to make this into a string
                var args = argumentsTxt.text
                var argToList = args.split(" ");
                systemCall.arguments = argToList
                systemCall.start()
            }
        }
    }

    QQmlProcess{
        id: systemCall
        onFinished: {
            console.log("The Qml System Runner has Finished")
        }
        onPidChanged: console.log(pid)
        onRunning: {
            console.log("The Qml System call is running")
        }
        onError: {
            systemCallOutPut = ""
            systemCallOutPut = "<b>The Qml System Runner got a error </b>" + errorString
        }

        onMessageChanged:{
            // Clear the message
            systemCallOutPut = ""
            systemCallOutPut =  message

        }
        onProcessStateChanged: {
            console.log("the state " +processState)
        }
        Component.onCompleted: {
            // set the models
            for(var i = 0 ; i < runTypes.length; i++){
                runtypesModel.append({"text": runTypes[i] })
            }
            for(var o=0; o< inputChannelModeTypes.length ; o++ ){
                inputChannelModel.append({"text": inputChannelModeTypes[o]})
            }

            for(var p = 0 ; p < processChannelModeTypes.length; p++){
                processChannelModeModel.append({"text":processChannelModeTypes[p]})
            }
            for (var q= 0 ; q < processChannelTypes.length; q++){
                processChannelModel.append({"text":processChannelTypes[q]})
            }


        }


    }
    ListModel{id: runtypesModel}
    ListModel{id: inputChannelModel}
    ListModel{id: processChannelModeModel}
    ListModel{id: processChannelModel}
}//col





