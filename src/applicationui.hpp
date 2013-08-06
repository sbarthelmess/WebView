#ifndef APP_HPP
#define APP_HPP

#include <bb/system/InvokeManager>
#include <bb/system/InvokeRequest>
#include <QtCore/QObject>

class App : public QObject
{
    Q_OBJECT

    // The textual representation of the startup mode of the application
    Q_PROPERTY(QString startupMode READ startupMode NOTIFY requestChanged)
    // The values of the incoming invocation request
    Q_PROPERTY(QString source READ source NOTIFY requestChanged)
    Q_PROPERTY(QString target READ target NOTIFY requestChanged)
    Q_PROPERTY(QString action READ action NOTIFY requestChanged)
    Q_PROPERTY(QString mimeType READ mimeType NOTIFY requestChanged)
    Q_PROPERTY(QString uri READ uri NOTIFY requestChanged)
    Q_PROPERTY(QString data READ data NOTIFY requestChanged)
    // The textual representation of the card status
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)
    // The title of the application
    Q_PROPERTY(QString title READ title NOTIFY requestChanged)

public:
    Q_INVOKABLE void showToast(QString message);
    App(QObject *parent = 0);

Q_SIGNALS:
    // The change notification signal of the properties
    void requestChanged();
    void statusChanged();

private Q_SLOTS:
    // This slot is called whenever an invocation request is received
    void handleInvoke(const bb::system::InvokeRequest&);


private:
    // The accessor methods of the properties
    QString startupMode() const;
    QString source() const;
    QString target() const;
    QString action() const;
    QString mimeType() const;
    QString uri() const;
    QString data() const;
    QString status() const;
    QString title() const;

    // The central class to manage invocations
    bb::system::InvokeManager *m_invokeManager;

    // The property values
    QString m_startupMode;
    QString m_source;
    QString m_target;
    QString m_action;
    QString m_mimeType;
    QString m_uri;
    QString m_data;
    QString m_status;
    QString m_title;
};


#endif /* ApplicationUI_HPP_ */
