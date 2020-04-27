#ifndef MYLISTMODEL_H
#define MYLISTMODEL_H

#include <QAbstractListModel>

class MyListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit MyListModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;


    Qt::ItemFlags flags(const QModelIndex& index) const override;

    QHash<int, QByteArray> roleNames() const override;

    QList<QString> items() const;
    void setItems(const QList<QString> &items);

private:
    QList<QString> mItems;

};

#endif // MYLISTMODEL_H
