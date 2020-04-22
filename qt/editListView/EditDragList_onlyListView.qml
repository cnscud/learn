import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.Models 2.1


/**
  1. 通过设置currentIndex, 属性自动变化. 支持键盘
  2. 支持拖拽
*/
ColumnLayout {
    id:itemRoot
    //id: root
    //width: 300; height: 450

    /*
    Row {
        id: itemRoot
        //width: parent.width
        //height: 400

        Layout.fillHeight: true

        //Layout.leftMargin: 10
        //Layout.rightMargin: 20
        //Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

*/
        Component {
            id: delegateItem


            MouseArea {
                id: mouseArea
                width: itemRoot.width
                anchors { left: parent.left; right: parent.right }
                height: itemRect.height


                //width: parent.width
                //height: 50
                //hoverEnabled: true

                //拖拽设置
                drag.smoothed: false

                drag.target:  itemRect
                drag.axis: Drag.YAxis


                //z: -1 //避免遮住checkbox

                onClicked: {
                    //方法1: 设置当前
                    listView.currentIndex = index

                    console.log(("MouseArea Click listview currentIndex: " + listView.currentIndex +  " index: " + index ))
                    console.log(("MouseArea Click ListView isCurrentItem: " + ListView.isCurrentItem))

                    // 在itemRect的 onFocusChanged 中设置了, 此处不需要了
                    //textinput.focus = true;
                }

                onFocusChanged: {
                    if(focus){
                        console.debug("got focus of mouseArea" );
                        textinput.focus = true;
                    }
                }



            Rectangle {
                id: itemRect
                height: 50
                width: mouseArea.width

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                //border.width: 1
                //border.color: "lightsteelblue"

                //color: mouseArea.drag.active ? "lightsteelblue" : "white"

                //Behavior on color { ColorAnimation { duration: 100 } }
                //radius: 2

                //拖拽设置
                Drag.active: mouseArea.drag.active

                Drag.source: mouseArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    when: itemRect.Drag.active

                    ParentChange { target: itemRect; parent: itemRoot }
                    AnchorChanges {
                        target: itemRect
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }


                onFocusChanged: {
                    if(focus){
                        console.debug("got focus itemRect" );
                        textinput.focus = true;
                    }
                }

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

                        visible: !mouseArea.ListView.isCurrentItem
                        color: "black"


                    } //end textShow


                    TextInput {
                        id: textinput

                        anchors.verticalCenter: parent.verticalCenter

                        color: "blue"

                        text:  model.description
                        visible: mouseArea.ListView.isCurrentItem
                        enabled: mouseArea.ListView.isCurrentItem
                        focus: true
                        selectByMouse: true

                        onFocusChanged: {
                            if(focus){
                                console.debug("got focus " + "textInput");
                            }
                        }

                        onEditingFinished: {
                            model.description = textinput.text

                            //方法1: 设置index
                            if(listView.currentIndex == index){
                                listView.currentIndex = -1;
                            }


                            console.log(("TextInput listview currentIndex: " + listView.currentIndex +  " index: " + index ))
                            console.log(("TextInput ListView isCurrentItem: " + mouseArea.ListView.isCurrentItem))

                        }

                    } //end TextInput


                } //end textSection Rectangle




            } //end itemRect Rectangle

            DropArea {
                anchors { fill: parent; margins: 10 }

                onEntered: {
                    //移动Delegate
                    visualModel.items.move( drag.source.DelegateModel.itemsIndex,
                                            mouseArea.DelegateModel.itemsIndex, 1);

                    //移动Model: 不移动的话model和delegate就不同步了
                    visualModel.model.move( drag.source.DelegateModel.itemsIndex,
                                            mouseArea.DelegateModel.itemsIndex, 1);
                }
            }


            } //end MouseArea




        } //end Component


        DelegateModel {
            id: visualModel

            model: MyModel  {}
            delegate: delegateItem
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            //anchors { fill: parent; margins: 2 }
            //width: parent.width


            keyNavigationEnabled: true

            //clip: true
            model: visualModel
            //delegate: delegateItem

            //默认不要是第一个, 否则第一个是可编辑状态(针对方法1)
            Component.onCompleted : {
                currentIndex = -1;
            }

            //默认焦点
            focus: true
        }

/*
    }

    Row {
        width: parent.width

        Button {
            text: qsTr("Add New Item")
            width: parent.width

            onClicked: {
                var c = listView.model.model.rowCount();
                listView.model.model.append({
                                          "description": "Buy a new book " + (c + 1),
                                          "done": false
                                      })

                //设置焦点, 否则listView就没焦点了
                listView.focus = true;
                listView.currentIndex = c;
            }
        }
    }
*/

}
