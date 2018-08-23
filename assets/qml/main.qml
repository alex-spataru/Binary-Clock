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
    visible: true

    //
    // Theme options
    //
    color: "#303030"
    Material.accent: "#f84"
    Material.primary: "#f84"
    Material.background: "#303030"
    Material.theme: Material.Dark
    Universal.theme: Universal.Dark

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
    // Loader for all the UI items
    //
    Loader {
        id: loader
        opacity: 0
        asynchronous: true
        anchors.fill: parent

        //
        // Fade-in animation to beautify our fucked up loading process
        //
        Behavior on opacity {
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutQuad
            }
        }

        //
        // UI items
        //
        sourceComponent: Item {
            anchors.fill: parent

            //
            // All the UI controls
            //
            UI {
                onFinishedLoading: loader.opacity = 1

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
    }
}
