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

import "Clocks" as Clocks
import "Gradients" as Gradients
import "qrc:/js/Global.js" as Global

Item {
    //
    // Used to show the UI when all is loaded
    //
    signal finishedLoading

    //
    // Tabs
    //
    TabBar {
        z: 1
        id: tabBar
        Material.elevation: 5

        anchors {
            leftMargin: -5
            rightMargin: -5
            top: parent.top
            left: parent.left
            right: parent.right
        }

        TabButton {
            Image {
                anchors.centerIn: parent
                sourceSize: Qt.size (24, 24)
                source: "qrc:/images/clock.svg"
            }
        }

        TabButton {
            Image {
                anchors.centerIn: parent
                sourceSize: Qt.size (24, 24)
                source: "qrc:/images/timer.svg"
            }
        }

        TabButton {
            Image {
                anchors.centerIn: parent
                sourceSize: Qt.size (24, 24)
                source: "qrc:/images/more.svg"
            }
        }
    }

    //
    // Random background gradients
    //
    Gradients.GradientGenerator {
        z: -1
        flat: true
        anchors {
            fill: parent
            topMargin: tabBar.height
        }
    }

    //
    // Pages
    //
    SwipeView {
        currentIndex: tabBar.currentIndex
        onCurrentIndexChanged: tabBar.currentIndex = currentIndex

        anchors {
            fill: parent
            margins: Global.spacing
            topMargin: tabBar.height
        }

        //
        // Clock viewer
        //
        Item {
            Clocks.AnalogClock {
                id: analogClock
                onDrawingFinished: finishedLoading()

                anchors {
                    fill: parent
                    topMargin: -tabBar.height - Global.spacing
                }
            }
        }

        //
        // Cronometer
        //
        Item {

        }

        //
        // Timer
        //
        Item {

        }
    }
}
