#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>

#include <bb/system/SystemToast>
#include <bb/system/SystemUiPosition>

using namespace bb::cascades;
using namespace bb::system;

App::App(QObject *parent) :
		QObject(parent), m_invokeManager(new InvokeManager(this)) {
	// Listen to incoming invocation requests
	connect(m_invokeManager, SIGNAL(invoked(const bb::system::InvokeRequest&)), this, SLOT(handleInvoke(const bb::system::InvokeRequest&)));

	// Initialize properties with default values
	switch (m_invokeManager->startupMode()) {
	case ApplicationStartupMode::LaunchApplication:
		m_startupMode = tr("Launch");
		break;
	case ApplicationStartupMode::InvokeApplication:
		m_startupMode = tr("Invoke");
		break;
	case ApplicationStartupMode::InvokeCard:
		m_startupMode = tr("Card");
		break;
	}
	// Define it here, let's you change it dynamically in C++...
	m_title = "HTML5 w/ Cascades";
	//m_uri = "Despicable";

	// Create the UI
	QmlDocument *qml = QmlDocument::create("asset:///main.qml");
	qml->setContextProperty("app", this);
	AbstractPane *root = qml->createRootObject<AbstractPane>();
	Application::instance()->setScene(root);
}

void App::showToast(QString message) {
	SystemToast *toast = new SystemToast(this);
	toast->setBody(message);
	toast->show();
}

void App::handleInvoke(const InvokeRequest& request) {
	// Copy data from incoming invocation request to properties
	//m_source = QString::fromLatin1("%1 (%2)").arg(request.source().installId()).arg(request.source().groupId());
	//m_target = request.target();
	//m_action = request.action();
	//m_mimeType = request.mimeType();
	//m_data = QString::fromUtf8(request.data());

	// Only interested in uri, but others left here for reference...
	m_uri = request.uri().toString().mid(10); // parse left 10 characters out of invocation "webview://"

	if (m_uri != "") {
		//m_title = tr("Data incoming!");
		emit requestChanged();
	}
}

QString App::startupMode() const {
	return m_startupMode;
}

QString App::source() const {
	return m_source;
}

QString App::target() const {
	return m_target;
}

QString App::action() const {
	return m_action;
}

QString App::mimeType() const {
	return m_mimeType;
}

QString App::uri() const {
	return m_uri;
}

QString App::data() const {
	return m_data;
}

QString App::status() const {
	return m_status;
}

QString App::title() const {
	return m_title;
}
