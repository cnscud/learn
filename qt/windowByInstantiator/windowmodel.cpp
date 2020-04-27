#include "windowmodel.h"

WindowModel::WindowModel(QObject *parent) : QObject(parent)
{
}

QString WindowModel::title() const
{
  return _title;
}

void WindowModel::setTitle(const QString &title)
{
  _title = title;
}

int WindowModel::getX() const
{
  return m_x;
}

void WindowModel::setX(int value)
{
  m_x = value;
}

MyListModel *WindowModel::getListModel() const
{
  return m_listModel;
}

void WindowModel::setListModel(MyListModel *value)
{
  m_listModel = value;
}

