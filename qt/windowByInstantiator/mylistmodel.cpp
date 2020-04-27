#include "mylistmodel.h"

MyListModel::MyListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int MyListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return mItems.size();
}

QVariant MyListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() )
        return QVariant();

    QString item = mItems.at(index.row());

    return QVariant(item);
}

QHash<int, QByteArray> MyListModel::roleNames() const {
    QHash<int, QByteArray> names;
    names[Qt::DisplayRole] = "name";

    return names;
}


Qt::ItemFlags MyListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QList<QString> MyListModel::items() const
{
    return mItems;
}

void MyListModel::setItems(const QList<QString> &items)
{
    beginResetModel();


    mItems = items;

    endResetModel();

}

