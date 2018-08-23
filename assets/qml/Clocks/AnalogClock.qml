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

import "qrc:/js/Global.js" as Global
import "qrc:/js/AnalogClock.js" as AnalogClock

Item {
    id: analogClock

    //
    // Used to hide everything until first paint is finished
    //
    signal drawingFinished
    readonly property real clockDiameter: Math.min (app.width, app.height) * 0.8

    //
    // Used to update the canvas only when the seconds change
    // and when the canvas has finished its painting process
    //
    property int day: -1
    property int seconds: -1

    //
    // Clock background
    //
    Canvas {
        width: clockDiameter
        height: clockDiameter
        anchors.centerIn: parent
        renderStrategy: Canvas.Threaded
        onPaint: AnalogClock.drawBackground (getContext("2d"))
        onPainted: drawingFinished()
    }

    //
    // Clock handles & date
    //
    Canvas {
        id: handles

        //
        // Canvas properties
        //
        width: clockDiameter
        height: clockDiameter
        anchors.centerIn: parent
        renderStrategy: Canvas.Threaded
        onPaint: AnalogClock.drawHandles (getContext("2d"))

        //
        // Update the clock when the seconds change
        // Update the date if the day changes
        // Do not use '!==', it will cause things to change
        // everytime that the timer expires
        //
        Timer {
            repeat: true
            interval: 100
            Component.onCompleted: start()
            onTriggered: {
                var date = new Date()
                var secs = date.getSeconds()
                if (secs != analogClock.seconds) {
                    analogClock.seconds = secs
                    handles.requestPaint()

                    // Update date
                    var dayNum = Qt.formatDate (date, "dd")
                    if (dayNum != analogClock.day) {
                        analogClock.day = dayNum
                        dateCanvas.requestPaint()
                    }
                }
            }
        }
    }

    //
    // Date draw
    //
    Canvas {
        id: dateCanvas

        height: 120
        width: parent.width
        anchors.centerIn: parent
        renderStrategy: Canvas.Threaded
        anchors.verticalCenterOffset: clockDiameter * 0.6
        onPaint: AnalogClock.drawDate (getContext("2d"))
    }
}
