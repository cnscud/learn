import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.3

Instantiator {
    id: windowInstantiator

    model: ListModel {
        id: windowModel
        ListElement {
            title: "Initial Window"
            x: -200
        }
        ListElement {
            title: "Second Window"
            x: 300
        }
    }

    delegate: MyWindow {
        id: window
    }
}
