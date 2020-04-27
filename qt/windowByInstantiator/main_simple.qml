import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.3


Instantiator {
    id: windowInstantiator

    model: ListModel {
        id: windowModel
        ListElement { title: "Initial Window"; x: -200 }
        ListElement { title: "Second Window"; x:300 }
    }

    delegate: Window {
        id: window
        visible: true
        width: 640
        height: 480
        x: Screen.width/2 - window.width/2 + model.x
        y: Screen.height / 2 - window.height/2

        title: model.title

        Rectangle {
            width: 150
            height: 50
            Button {
                text: qsTr("Duplicate Window")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                onClicked: windowModel.append({ "title": "Window #" + (windowModel.count +1)})
            }
        }
    }
}
