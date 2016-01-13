#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths>
#include "qqml.h"

//local
#include "downloader.h"
#include "qfile.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // add the classes to the project
    qmlRegisterType<QmlFile>("MyApp",1,0,"QQmlFile");
    qmlRegisterType<Downloader>("MyApp",1,0,"Downloader");


    // get the users dopwnload folder
    QString downloadFolder = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).first();
    engine.rootContext()->setContextProperty("downladFolder",downloadFolder);


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

