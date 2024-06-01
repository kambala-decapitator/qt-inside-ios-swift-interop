# qt-inside-ios-swift-interop
Embed Qt Widgets app inside native iOS Swift app without Objective-C++ wrapper using the Swift-C++ interop.

The example is based on the Objective-C++ example: https://github.com/kambala-decapitator/qt-inside-ios-native

## Building
The project has been tested with Xcode 15.2 / 15.4 and Qt 6.6.3.

First, make sure that Xcode command line tools are pointing to an Xcode installation, check with `xcode-select -p`. To change that, use either `sudo xcode-select -s /path/to/Xcode` or set `DEVELOPER_DIR` environment variable.

Call the following commands from the repo root directory. Building and launching on device (or simulator) is done from Xcode. Codesigning parameters (required to run on a device) for CMake are omitted, but can also be configured manually in Xcode.

```bash
# set the variable to your Qt 6 installation
QTDIR=~/dev/Qt-libs/6.6.3/ios

mkdir build
cd build

"$QTDIR/bin/qt-cmake" ..
open interop-qt.xcodeproj
```
