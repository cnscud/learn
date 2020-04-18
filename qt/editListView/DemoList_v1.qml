import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.Models 2.1

ColumnLayout {

    RowLayout {

        Layout.fillHeight: true

        Layout.leftMargin: 10
        Layout.rightMargin: 20
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

        Component {
            id: delegateItem

            Rectangle {
                id: dragRect
                height: 50
                width: parent.width

                //color: delegateItem.ListView.isCurrentItem ? "red" : "white"
                CheckBox {
                    id: chkbox
                    width: 50
                    checked: model.done
                    onClicked: model.done = checked
                }

                Rectangle {
                    id: textSection
                    height: parent.height
                    color: "#c8c4c4"
                    width: parent.width - chkbox.width
                    anchors.left: chkbox.right

                    TextEdit {
                        id: textShow

                        text: model.description
                        anchors.verticalCenter: parent.verticalCenter

                        //visible: !delegateItem.ListView.isCurrentItem
                        //elide: Text.ElideRight
                        color: listView.isCurrentItem ? "red" : "black"

                        onFocusChanged: {
                            console.log("[onFocusChanged] should focus me: " + index +" focus:" + focus)
                            if (focus) {
                                listView.currentIndex = index
                                textShow.focus = true
                            }
                        }

                        onEditingFinished: {
                            model.description = textShow.text

                            console.log("[onEditingFinished] current: " + listView.currentIndex)

                            //console.log("swidth:" + textShow.width + " sheight: " + textShow.height)
                            //console.log("sx:" + textShow.x + " sy: " + textShow.y)

                        }
                    } //end textShow

                    MouseArea {
                        id: mouseArea
                        width: parent.width
                        height: parent.height
                        hoverEnabled: true

                        z: -1

                        onClicked: {
                            //选择当前
                            listView.currentIndex = index
                            //激活控件
                            textShow.focus = true
                            //光标移动到最后
                            textShow.cursorPosition = textShow.text.length

                            console.log("[mouseClick] hello index: " + index)
                            console.log("[mouseClick] current: " + listView.currentIndex)
                        }
                    }


                    /*

                        Loader { // Initialize text editor lazily to improve performance

                            id: loaderEditor
                            width: parent.width
                            height: parent.height
                            x: textShow.x

                            Connections {
                                target: loaderEditor.item
                                onAccepted: {
                                  //largeModel.setProperty(styleData.row, styleData.role, loaderEditor.item.text)
                                }
                                onEditingFinished: model.description = loaderEditor.item.text
                            }

                            sourceComponent: delegateItem.ListView.isCurrentItem ? editor : null
                            Component {
                                id: editor
                                TextInput {
                                    id: textinput
                                    text: model.description
                                }
                            } //end Component



                        } //end Loader
                        */
                } //end Rectangle
            }
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true

            //clip: true
            model: MyModel {}
            delegate: delegateItem

            focus: true
            //highlight: Rectangle { color: "lightsteelblue"; radius: 15 }
        }
    }

    RowLayout {
        Button {
            text: qsTr("Add New Item")
            Layout.fillWidth: true

            onClicked: {
                //print("Board count: " + visualModel.model.rowCount())
                listView.model.append({
                                          "description": "Buy a new book " + (listView.model.rowCount() + 1),
                                          "done": false
                                      })

            }
        }
    }
}
