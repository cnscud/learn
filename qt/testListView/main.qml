import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Rectangle {
          width: 180; height: 200


          ListView {
                id: listView
                width: 180; height: 200

                Component {
                    id: contactsDelegate
                    Rectangle {
                        id: wrapper
                        width: 180
                        height: contactInfo.height
                        color: ListView.isCurrentItem ? "black" : "red"
                        TextEdit {
                            id: contactInfo
                            text: name + ": " + number
                            //focus: true
                            color: wrapper.ListView.isCurrentItem ? "red" : "black"
                            onFocusChanged: {
                                if(focus){
                                    listView.currentIndex = index;
                                    contactInfo.focus = true;
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            z: -2
                            onClicked: {
                                listView.currentIndex = index
                            }
                        }

                    }
                }

                model: ContactModel {}
                delegate: contactsDelegate
                focus: true
            }



      }

}
