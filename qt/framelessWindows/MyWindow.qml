import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.3

Window {
    id: window

    //Designer 竟然不支持..., 设计模式时要注意
    flags: Qt.FramelessWindowHint

    visible: true
    width: 640
    height: 480
    x: Screen.width / 2 - window.width / 2 + model.x
    y: Screen.height / 2 - window.height / 2

    title: model.title

    Rectangle {
        id: titleBarRectangle
        x: 0
        y: 0
        width: parent.width
        height: 20
        color: "#3b4852"

        MouseArea {
            id: mouseMoveWindowArea
            //height: 20
            anchors.fill: parent

            acceptedButtons: Qt.LeftButton

            property point clickPos: "0,0"

            onPressed: {
                clickPos = Qt.point(mouse.x, mouse.y)
                //isMoveWindow = true
            }
            onReleased: {

                //isMoveWindow = false
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)

                //如果mainwindow继承自QWidget,用setPos
                window.setX(window.x + delta.x)
                window.setY(window.y + delta.y)
            }
        }

        Button {
            id: closeButton

            width: 23
            height: 18
            text: "X"
            anchors.right: parent.right
            anchors.rightMargin: 0

            onClicked: window.close()
        }
    }

    Rectangle {
        anchors.top: titleBarRectangle.bottom
        width: 150
        height: 50
        Button {
            text: qsTr("Duplicate Window ")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            onClicked: {
                windowModel.append({
                                       "title": "Window #" + (windowModel.count + 1)
                                   })
            }
        }
    }
}
