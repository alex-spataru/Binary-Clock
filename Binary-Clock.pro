#
# Copyright (c) 2018 Alex Spataru <https://github.com/alex-spataru>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

#-------------------------------------------------------------------------------
# Project configuration
#-------------------------------------------------------------------------------

TEMPLATE = app
TARGET = QClock

CONFIG += qtc_runnable
CONFIG += resources_big

#-------------------------------------------------------------------------------
# Make options
#-------------------------------------------------------------------------------

UI_DIR = uic
MOC_DIR = moc
RCC_DIR = qrc
OBJECTS_DIR = obj

#-------------------------------------------------------------------------------
# Import Qt modules
#-------------------------------------------------------------------------------

QT += gui
QT += qml
QT += svg
QT += xml
QT += core
QT += quick
QT += multimedia
QT += quickcontrols2

#-------------------------------------------------------------------------------
# Include libraries
#-------------------------------------------------------------------------------

include ($$PWD/lib/QtAdMob/QtAdMob.pri)
include ($$PWD/lib/ShareUtils-QML/ShareUtils-QML.pri)

#-------------------------------------------------------------------------------
# Deploy configuration
#-------------------------------------------------------------------------------

linux:!android {
}

win32* {
}

macx* {
}

ios {
}

android {
    DISTFILES += \
        deploy/android/AndroidManifest.xml \
        deploy/android/gradle/wrapper/gradle-wrapper.jar \
        deploy/android/gradlew \
        deploy/android/res/values/libs.xml \
        deploy/android/build.gradle \
        deploy/android/gradle/wrapper/gradle-wrapper.properties \
        deploy/android/gradlew.bat \
        deploy/android/AndroidManifest.xml \
        deploy/android/gradle/wrapper/gradle-wrapper.jar \
        deploy/android/gradlew \
        deploy/android/res/values/libs.xml \
        deploy/android/build.gradle \
        deploy/android/gradle/wrapper/gradle-wrapper.properties \
        deploy/android/gradlew.bat \
        deploy/android/res/drawable/splash.xml \
        deploy/android/res/values/apptheme.xml

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/deploy/android
}

#-------------------------------------------------------------------------------
# Import resources
#-------------------------------------------------------------------------------

RESOURCES += \
    $$PWD/assets/js/js.qrc \
    $$PWD/assets/qml/qml.qrc \
    $$PWD/assets/fonts/fonts.qrc \
    $$PWD/assets/gradients/gradients.qrc \
    assets/images/images.qrc

#-------------------------------------------------------------------------------
# Import source code
#-------------------------------------------------------------------------------

SOURCES += \
    $$PWD/src/main.cpp \
    $$PWD/src/UiGradients.cpp

HEADERS += \
    $$PWD/src/UiGradients.h

DISTFILES += \
    $$PWD/assets/js/BcdClock.js \
    $$PWD/assets/js/BinaryClock.js \
    $$PWD/assets/js/Global.js \
    $$PWD/assets/qml/$$PWD/assets/Digit.qml \
    $$PWD/assets/qml/$$PWD/assets/Dot.qml \
    $$PWD/assets/qml/Clocks/BcdClock.qml \
    $$PWD/assets/qml/Clocks/BinaryClock.qml \
    $$PWD/assets/qml/Gradients/GradientGenerator.qml \
    $$PWD/assets/qml/Gradients/UiGradientStop.qml \
    $$PWD/assets/qml/Ads.qml \
    $$PWD/assets/qml/main.qml \
    $$PWD/assets/qml/UI.qml
