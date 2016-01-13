#include "qfile.h"

QmlFile::QmlFile(QObject *parent) :
    QObject(parent),
    m_type(Read)
{

    connect(this,SIGNAL(gotError(QString)), this,SLOT(handdleError(QString)));
    connect(this,SIGNAL(outPutChanged(QString)), this,SLOT(hannleOut(QString)));
}

QString QmlFile::fileName()
{
    return m_fileName;
}

QString QmlFile::outPut()
{
    return m_outPut;
}

QString QmlFile::errorString()
{
    return m_errorString;
}

QString QmlFile::incoming()
{
    return m_incoming;
}

QmlFile::Type QmlFile::type()
{
    return m_type;
}

void QmlFile::setFileName(const QString &fileName)
{
   if( m_fileName == fileName )
      return;
   m_fileName = fileName;
   emit fileNameChanged();
}

void QmlFile::setIncoming(const QString &incoming)
{
    if (m_incoming == incoming )
        return;
    m_incoming = incoming;
    emit incomingChanged();

}

void QmlFile::setType(const QmlFile::Type &type)
{
    if (m_type == type){
        return;
    }else{
        switch (type) {
        case Read:
            m_type = Read;
            break;
        case Write:
            m_type = Write;
            break;
        }
        emit typeChanged();
    }
}

void QmlFile::exec()
{
     if (m_type == Read){
        qDebug() << "reading file " << m_fileName;
        QFile file(m_fileName);
        if ( !file.open(QIODevice::ReadOnly | QIODevice::Text) ){
            gotError("Could not open file for reading");
        }else{
            QTextStream in(&file);
            while ( !in.atEnd() ) {
                QString line = in.readAll();
                outPutChanged(line);
                file.close();
            }
        }
    }
    else if (m_type == Write){
        QFile file(m_fileName);
        if ( !file.open(QIODevice::WriteOnly | QIODevice::Text) ){
            gotError("Could not open file for reading");
        }else{
            QTextStream out(&file);
            out << m_incoming;
            file.close();
        }
    }
}
void QmlFile::hannleOut(QString outPut)
{
    if (m_outPut == outPut)
        return;
    m_outPut = outPut;
    emit textChanged();
}

void QmlFile::handdleError(QString err)
{
    if (m_errorString == err)
        return;
    m_errorString = err;
    emit error();
}



