import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3

Instantiator {
    id: windowInstantiator

    model: rootModel

    delegate: Window {
        id: window
        visible: true
        width: 640
        height: 480
        x: Screen.width/2 - window.width/2 + modelData.x
        y: Screen.height / 2 - window.height/2


        title: modelData.title + " (Window Count: " + count + " )"

        ListView{
            width: 100; height: 100

            id: listView
            objectName: "listView"

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: modelData.listModel

            delegate: Rectangle {
                height: 25
                width: 100
                Text { text: "hello " + model.name }
            }

        }

    }
}
