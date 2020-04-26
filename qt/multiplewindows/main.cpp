
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include "mylistmodel.h"


int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //准备数据
    MyListModel *model1 = new MyListModel();
    QList<QString> list1;
    list1 << "Item 1" << "Item b" << "Item c";
    model1->setItems(list1);

    MyListModel *model2 = new MyListModel();
    QList<QString> list2;
    list2 << "Wish 1" << "Wish b" << "Wish c";
    model2->setItems(list2);


    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    //注册类型: 让视图知道注入的是啥类型
    qmlRegisterType<MyListModel>("MyList", 1, 0, "MyListModel");


    const QUrl url(QStringLiteral("qrc:/part1.qml"));
    engine.load(url);


    QObject *rootObj1 = engine.rootObjects()[0];

    QQuickItem *listView1 = rootObj1->findChild<QQuickItem*>("listView");
    if (listView1){
        qDebug("find listview1");
        listView1->setProperty("model", QVariant::fromValue(model1));
        listView1->polish();
    }

    QQuickItem *rootWindow1 = (QQuickItem*)rootObj1;
    qDebug("window keyname value: %s" , qPrintable(rootWindow1->property("keyname").toString()));

    //设置属性, 方便区分: 后期找窗口的时候
    rootWindow1->setProperty("keyname", "index1");

    //看看变了吗?
    qDebug("window keyname value: %s" , qPrintable(rootWindow1->property("keyname").toString()));



    //开启第二个窗口
    const QUrl url2(QStringLiteral("qrc:/part1.qml"));
    engine.load(url2);


    QObject *rootObj2 = engine.rootObjects()[1];
    QQuickItem *listView2 = rootObj2->findChild<QQuickItem*>("listView");
    if (listView2){
        qDebug("find listview 2");
        listView2->setProperty("model", QVariant::fromValue(model2));
        listView2->polish();
    }


    /*
    //直接修改控件属性
    QQuickItem *textInput2 = rootObj->findChild<QQuickItem*>("textInput");
    if (textInput2){
        textInput2->setProperty("text", "I am second one");
        textInput2->setProperty("color", QColor(Qt::blue));
    }*/


    return app.exec();
}
