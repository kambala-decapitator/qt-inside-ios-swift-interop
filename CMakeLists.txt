cmake_minimum_required(VERSION 3.19)

project(interop-qt
	VERSION 1.0
	LANGUAGES CXX Swift
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_Swift_LANGUAGE_VERSION "5.0")

# Xcode project-level settings
## common sensible defaults
set(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=Debug] "dwarf")
set(CMAKE_XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.kambala.$(PRODUCT_NAME)")
set(CMAKE_XCODE_ATTRIBUTE_MARKETING_VERSION "${PROJECT_VERSION}")
set(CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2")
## enable C++ interop
set(CMAKE_XCODE_ATTRIBUTE_CLANG_ENABLE_MODULES "YES")
set(CMAKE_XCODE_ATTRIBUTE_SWIFT_OBJC_INTEROP_MODE "objcxx")

find_package(QT NAMES Qt6 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

set(publicHeaders
	CppQt.h
	showQt.h
)
qt_add_library(CppQt
	showQt.cpp
	widget.h
	widget.cpp
	${publicHeaders}

	iosUtils.swift
)
set_target_properties(CppQt PROPERTIES
	# framework settings
	FRAMEWORK ON
	PUBLIC_HEADER "${publicHeaders}"
	XCODE_ATTRIBUTE_GENERATE_INFOPLIST_FILE "YES"

	# enable C++ interop for C++ framework target
	XCODE_ATTRIBUTE_DEFINES_MODULE "YES"
	XCODE_ATTRIBUTE_ENABLE_MODULE_VERIFIER "YES"
	XCODE_ATTRIBUTE_MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS "c++17"
	XCODE_ATTRIBUTE_MODULE_VERIFIER_SUPPORTED_LANGUAGES "objective-c++"

	# Qt settings
	AUTOMOC ON
	AUTORCC ON
	AUTOUIC ON
)
target_link_libraries(CppQt PRIVATE
	Qt${QT_VERSION_MAJOR}::Widgets
)

add_executable(interop-qt
	AppDelegate.swift
	ViewController.swift
)
set_target_properties(interop-qt PROPERTIES
	# create app bundle
	MACOSX_BUNDLE ON
	MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_LIST_DIR}/Info.plist"

	# Qt mustn't call UIApplicationMain() itself
	qt_no_entrypoint ON
)
target_link_libraries(interop-qt PRIVATE
	CppQt
)

target_sources(interop-qt PRIVATE LaunchScreen.storyboard)
set_source_files_properties(LaunchScreen.storyboard PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
