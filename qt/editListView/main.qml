import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    DemoList {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
    }

}
