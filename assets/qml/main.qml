/*
 * Copyright (c) 2018 Alex Spataru <https://github.com/alex-spataru>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0

ApplicationWindow {
    id: app

    //
    // Constants
    //
    readonly property int spacing: 8
    readonly property int smallLabel: 12
    readonly property int largeLabel: 22
    readonly property int mediumLabel: 18
    readonly property int normalLabel: 16
    readonly property int extraSmallLabel: 10
    readonly property int extraLargeLabel: 24
    readonly property string accentColor: "#c35057"
    readonly property string backgroundColor: "#202126"
    readonly property string secondaryAccentColor: "#f6a60f"
    readonly property string lightBackgroundColor: "#282830"
    readonly property bool isMobile: Qt.platform === "android"

    //
    // UI loading variables
    //
    property var ui: undefined
    property bool uiLoaded: false

    //
    // Window options
    //
    width: 320
    height: 480
    visible: true

    //
    // Theme options
    //
    color: backgroundColor
    Material.accent: accentColor
    Material.theme: Material.Dark
    Universal.theme: Universal.Light
    Material.background: backgroundColor
    Material.primary: lightBackgroundColor

    //
    // Decrease stack depth before closing the application.
    // This allows the Android user to use the back button to navigate the UI
    //
    onClosing: close.accepted = ui.checkStackDepth()

    //
    // Force use of roboto font
    //
    font.family: "Roboto"

    //
    // Load Roboto font
    //
    FontLoader {
        source: "qrc:/fonts/roboto/Roboto-Regular.ttf"
    }

    //
    // Main UI of the application
    //
    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        opacity: uiLoaded ? 1 : 0
        Behavior on opacity { NumberAnimation {} }

        //
        // UI loader
        //
        Loader {
            id: uiLoader
            asynchronous: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            onLoaded: app.uiLoaded = true

            sourceComponent: UI {
                anchors.fill: parent
                Component.onCompleted: app.ui = this
            }
        }

        //
        // Ad manager
        //
        Ads {
            id: adsManager
            enabled: uiLoaded
            Layout.fillWidth: true
            Layout.minimumHeight: uiLoaded ? adHeight : 0
            Layout.maximumHeight: uiLoaded ? adHeight : 0

            Behavior on Layout.maximumHeight { NumberAnimation {} }
            Behavior on Layout.minimumHeight { NumberAnimation {} }
        }
    }
}
