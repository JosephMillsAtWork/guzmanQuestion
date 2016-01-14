#ifndef QMLFILE_H
#define QMLFILE_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QString>
#include <QStringList>

class QmlFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)
    Q_PROPERTY(QString outPut READ outPut)
    Q_PROPERTY(QString  errorString READ errorString)
    Q_PROPERTY(QString incoming READ incoming WRITE setIncoming NOTIFY incomingChanged)

    Q_PROPERTY(QmlFile::Type type READ type WRITE setType NOTIFY typeChanged)

    Q_ENUMS(Type)


public:
    explicit QmlFile(QObject *parent = 0);

    // enums
    enum Type{
        Read,
        Write
    };

    //    getters
    QString fileName();
    QString outPut();
    QString errorString();
    QString incoming();

    QmlFile::Type type();

    //    setters
    void setFileName(const QString &fileName);
    void setIncoming(const QString &incoming);

    void setType(const QmlFile::Type &type);
    //method
    Q_INVOKABLE void exec();

signals:
    void fileNameChanged();
    void outPutChanged(QString);
    void gotError(QString);
    void error();
    void textChanged();
    void typeChanged();
    void incomingChanged();

protected slots:
    void hannleOut(QString outPut);
    void handdleError(QString err);

private:
    QString m_fileName;
    QString m_outPut;
    QString m_errorString;
    QString m_incoming;
    Type m_type;

};

#endif // QMLFILE_H
