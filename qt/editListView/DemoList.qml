import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.Models 2.1

ColumnLayout{

    RowLayout {

        //height: 400
        Layout.fillHeight: true

        Layout.leftMargin: 10
        Layout.rightMargin: 20
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop


        Component {
            id: delegateItem

            Rectangle {
                id: dragRect
                height: 50
                //width: 200
                width: parent.width
                //Layout.fillWidth: true


                Row {
                    width: parent.width
                    CheckBox{
                        //width: 45
                        id: chkbox
                        checked: model.done
                        onClicked:  model.done = checked
                    }

                    TextField {
                        Layout.fillWidth: true
                        width: parent.width - chkbox.width
                        //x: 50

                        onEditingFinished: model.description = text

                        text: model.description
                    }
                }
            }
        }

        DelegateModel {
            id: visualModel

            model: MyModel {}
            delegate: delegateItem
        }


        ListView{
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            model: visualModel
        }

    }

    RowLayout{
        Button {
            text: qsTr("Add New Item")
            Layout.fillWidth: true

            onClicked: {
                print("Board count: " + visualModel.model.rowCount())
                visualModel.model.append({  "description": "Buy a new book " + (visualModel.model.rowCount() +1) , "done": false})
            }
        }
    }


}
