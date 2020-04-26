import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: rectangle1
    visible: true
    width: 340
    height: 280
    objectName: "window"


    TextInput {
        id: textInput
        objectName: "textInput"

        x: 84
        y: 104
        width: 256
        height: 20
        text: qsTr("I am Second Windows")
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 24
    }



}
