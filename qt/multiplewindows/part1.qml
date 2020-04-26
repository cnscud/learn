import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import MyList 1.0


Window {
    id: rectangle1
    visible: true
    width: 340
    height: 280
    objectName: "window"

    property string keyname: "whoknows"

    ListView{
        width: 100; height: 100

        id: listView
        objectName: "listView"

        Layout.fillWidth: true
        Layout.fillHeight: true

        //默认数据为空, 但是声明了类型
        model: MyListModel{}

        delegate: Rectangle {
            height: 25
            width: 100
            Text { text: "hello " + model.name }
        }

    }

}
