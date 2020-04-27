#include "mylistmodel.h"
#include "windowmodel.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlPropertyMap>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    MyListModel *model1 = new MyListModel();
    QList<QString> list1;
    list1 << "Item 1" << "Item b" << "Item c";
    model1->setItems(list1);

    MyListModel *model2 = new MyListModel();
    QList<QString> list2;
    list2 << "Wish 1" << "Wish b" << "Wish c";
    model2->setItems(list2);



    //用自己定义Model
    WindowModel *win1 = new WindowModel();
    win1->setTitle( "First");
    win1->setX(-100);
    win1->setListModel(model1);

    WindowModel *win2 = new WindowModel();
    win2->setTitle( "Second");
    win2->setX(300);
    win2->setListModel(model2);

    //QVariantList list;
    QList<WindowModel *> winlist;
    winlist << win1 << win2;


    //用类似Map结构的QQmlPropertyMap
    QQmlPropertyMap hash1;
    hash1.insert("title", "First");
    hash1.insert("x",  QVariant::fromValue(-100));
    hash1.insert("listModel", QVariant::fromValue(model1));

    QQmlPropertyMap hash2;
    hash2.insert("title", "Second");
    hash2.insert("x",  QVariant::fromValue(300));
    hash2.insert("listModel", QVariant::fromValue(model2));

    //QVariantList list;
    QList<QQmlPropertyMap*> list;
    list << &hash1 << &hash2;


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("rootModel", QVariant::fromValue(list));

    const QUrl url(QStringLiteral("qrc:/main.qml"));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
