/**
  samples changed from Qt tutorial "dynamicview3"
*/

import QtQuick 2.0
import QtQml.Models 2.1


Rectangle {
    id: root

    width: 300; height: 400

    Component {
        id: dragDelegate

        MouseArea {
            id: dragArea


            anchors { left: parent.left; right: parent.right }
            height: content.height

            // Disable smoothed so that the Item pixel from where we started the drag remains under the mouse cursor
            drag.smoothed: false


            drag.target:  content

            drag.axis: Drag.YAxis

            Rectangle {
                id: content

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: dragArea.width; height: column.implicitHeight + 4

                border.width: 1
                border.color: "lightsteelblue"

                color: dragArea.drag.active ? "lightsteelblue" : "white"

                Behavior on color { ColorAnimation { duration: 100 } }

                radius: 2

                Drag.active: dragArea.drag.active

                Drag.source: dragArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    when: content.Drag.active

                    ParentChange { target: content; parent: root }
                    AnchorChanges {
                        target: content
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }

                Column {
                    id: column
                    anchors { fill: parent; margins: 2 }
                    Text { text: 'Name: ' + name }
                }

            }

            DropArea {
                anchors { fill: parent; margins: 10 }

                onEntered: {
                    visualModel.items.move(
                            drag.source.DelegateModel.itemsIndex,
                            dragArea.DelegateModel.itemsIndex)
                }
            }

        }
    }

    DelegateModel {
        id: visualModel

        model: PetsModel {}
        delegate: dragDelegate
    }

    ListView {
        id: view

        anchors { fill: parent; margins: 2 }

        model: visualModel

        spacing: 4

        cacheBuffer: 50

        moveDisplaced: Transition {
                  NumberAnimation { properties: "x,y"; duration: 200 }
              }

    }

}

