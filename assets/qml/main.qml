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
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0

import "qrc:/js/Global.js" as Global

ApplicationWindow {
    id: app

    //
    // Window options
    //
    width: 320
    height: 480
    visible: false

    //
    // Theme options
    //
    color: Global.backgroundColor
    Material.theme: Material.Dark
    Universal.theme: Universal.Light
    Material.accent: Global.accentColor
    Material.background: Global.backgroundColor
    Material.primary: Global.lightBackgroundColor

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
    // All the UI controls
    //
    UI {
        id: ui
        onFinishedLoading: app.visible = true

        anchors {
            fill: parent
            bottomMargin: ads.height
        }
    }

    //
    // Ads (yay!)
    //
    Ads {
        id: ads

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
