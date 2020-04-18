import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.Models 2.1


/**
  方法1: 手动设置控件, 不支持键盘操作
*/
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

                CheckBox {
                    id: chkbox
                    width: 50
                    checked: model.done
                    onClicked: model.done = checked
                }

                Rectangle {
                    id: textSection
                    height: parent.height

                    width: parent.width - chkbox.width
                    anchors.left: chkbox.right

                    Text {
                        id: textShow

                        text: model.description
                        font.underline: true
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter

                        visible: !dragRect.ListView.isCurrentItem
                        color: "black"

                    } //end textShow

                    MouseArea {
                        id: mouseArea
                        width: parent.width
                        height: parent.height
                        hoverEnabled: true

                        //z: -1

                        onClicked: {
                            //方法1: 设置当前
                            //listView.currentIndex = index

                            console.log(("MouseArea listview currentIndex: " + listView.currentIndex +  " index: " + index ))
                            console.log(("MouseArea ListView isCurrentItem: " + dragRect.ListView.isCurrentItem))

                            //光标移动到最后 或者自己判断
                            //textShow.cursorPosition = textShow.text.length


                            //方法2: 手动
                            textShow.visible =false;
                            textinput.visible =true;
                            textinput.enabled = true;

                            textinput.focus = true;
                        }
                    }

                    TextInput {
                        id: textinput

                        anchors.verticalCenter: parent.verticalCenter

                        color: "blue"

                        text:  model.description
                        visible: dragRect.ListView.isCurrentItem
                        enabled: dragRect.ListView.isCurrentItem

                        onAccepted: {

                        }


                        onEditingFinished: {
                            model.description = textinput.text

                            //方法1: 设置index
                            /*
                            if(listView.currentIndex == index){
                                listView.currentIndex = -1;
                            }
                            */

                            //方法2: 手动设置
                            visible = false;
                            textShow.visible = true;

                            console.log(("TextInput listview currentIndex: " + listView.currentIndex +  " index: " + index ))
                            console.log(("TextInput ListView isCurrentItem: " + dragRect.ListView.isCurrentItem))

                        }

                    }


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

            //默认不要是第一个, 否则第一个是可编辑状态(针对方法1)
            Component.onCompleted : currentIndex = -1


            focus: true

        }
    }

    RowLayout {
        Button {
            text: qsTr("Add New Item")
            Layout.fillWidth: true

            onClicked: {
                listView.model.append({
                                          "description": "Buy a new book " + (listView.model.rowCount() + 1),
                                          "done": false
                                      })

            }
        }
    }
}
