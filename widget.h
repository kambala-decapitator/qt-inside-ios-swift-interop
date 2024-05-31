#pragma once

#include <QWidget>

class Widget : public QWidget
{
	Q_OBJECT

public:
	Widget(QString swiftText, QWidget* parent = nullptr);
};
