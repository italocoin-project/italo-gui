#ifndef SUBADDRESSACCOUNT_H
#define SUBADDRESSACCOUNT_H

#include <wallet/api/wallet2_api.h>
#include <QObject>
#include <QList>
#include <QDateTime>

class SubaddressAccount : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QList<Italo::SubaddressAccountRow*> getAll(bool update = false) const;
    Q_INVOKABLE Italo::SubaddressAccountRow * getRow(int index) const;
    Q_INVOKABLE void addRow(const QString &label) const;
    Q_INVOKABLE void setLabel(quint32 accountIndex, const QString &label) const;
    Q_INVOKABLE void refresh() const;
    quint64 count() const;

signals:
    void refreshStarted() const;
    void refreshFinished() const;

public slots:

private:
    explicit SubaddressAccount(Italo::SubaddressAccount * subaddressAccountImpl, QObject *parent);
    friend class Wallet;
    Italo::SubaddressAccount * m_subaddressAccountImpl;
    mutable QList<Italo::SubaddressAccountRow*> m_rows;
};

#endif // SUBADDRESSACCOUNT_H
