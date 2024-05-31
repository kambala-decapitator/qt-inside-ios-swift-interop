#include "showQt.h"
#include "widget.h"

#include <CppQt/CppQt-Swift.h>

#include <QApplication>
#include <QWindow>

#include <array>

namespace QtHelper
{
void showWidget(const char* executablePath, const std::string& swiftString)
{
//    std::array<char*, 0> argv{};
    std::array argv{const_cast<char*>(executablePath)};
    int argc = argv.size();
    QApplication app{argc, argv.data()};

    Widget w{QString::fromStdString(swiftString)};
    w.show();

    // Qt view is invisible when Qt app is embedded in the native one
    auto qtWindow = app.topLevelWindows()[0];
    auto qtWindowUIView = reinterpret_cast<const void*>(qtWindow->winId());
    CppQt::addQtWindowToNativeWindow(qtWindowUIView);

    app.exec();
}
}
