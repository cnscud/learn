#ifndef WINDOWMODEL_H
#define WINDOWMODEL_H

#include "mylistmodel.h"

#include <QObject>

class WindowModel : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
  Q_PROPERTY(int x READ getX WRITE setX NOTIFY xChanged)
  Q_PROPERTY(MyListModel* listModel READ getListModel WRITE setListModel NOTIFY listModelChanged)


 public:
  explicit WindowModel(QObject *parent = nullptr);

  QString title() const;
  void setTitle(const QString &title);

  MyListModel *getListModel() const;
  void setListModel(MyListModel *value);

  int getX() const;
  void setX(int x);

 Q_SIGNALS:
  void titleChanged();
  void xChanged();
  void listModelChanged();


private:
  QString _title = "";

  int m_x = 0;
  MyListModel* m_listModel;
};

#endif // WINDOWMODEL_H
