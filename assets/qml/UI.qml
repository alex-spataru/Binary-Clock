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

import "Sensors" as Sensors
import "Components" as Components

Page {
    id: ui

    //
    // Aliases
    //
    property bool toolbarShadow: true
    property alias toolbarTitle: toolbarText.text

    //
    // Loads the given page and changes the toolbar title
    //
    function loadPage (page, index) {
        if (drawer.currentItem !== index)
            drawer.currentItem = index

        else {
            stack.clear()
            toolbarTitle = drawer.items.get (index).pageTitle
            stack.push (page)
        }
    }

    //
    // Decreases the stack depth when running on Android,
    // this function is called when the user presses the back
    // button on his/her device.
    //
    function checkStackDepth() {
        if (Qt.platform.os === "android") {
            if (drawer.index !== 0) {
                drawer.index = 0
                return false;
            }
        }

        return true
    }

    //
    // Set background color
    //
    background: Rectangle {
        color: app.backgroundColor
    }

    //
    // Toolbar
    //
    ToolBar {
        id: toolbar

        z: 1
        height: 56
        Material.foreground: "#fff"
        Material.background: Material.primary

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: -2
            rightMargin: -2
        }

        RowLayout {
            spacing: 3/2 * app.spacing

            anchors {
                fill: parent
                margins: app.spacing
                leftMargin: 3/2 * app.spacing
                rightMargin: 3/2 * app.spacing
            }

            Image {
                sourceSize: Qt.size (24, 24)
                source: "qrc:/icons/menu.svg"

                MouseArea {
                    anchors.fill: parent
                    onClicked: drawer.open()
                }
            }

            Label {
                id: toolbarText
                font.weight: Font.Medium
                font.pixelSize: app.mediumLabel
            }

            Item {
                Layout.fillWidth: true
            }

            Image {
                sourceSize: Qt.size (24, 24)
                source: "qrc:/icons/more.svg"

                MouseArea {
                    anchors.fill: parent
                    onClicked: menu.open()
                }

                Menu {
                    id: menu
                    x: app.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: qsTr ("Rate")
                        onClicked: app.rateApplication()
                    }

                    MenuItem {
                        text: qsTr ("Report Bug")
                        onClicked: app.reportBug()
                    }

                    MenuItem {
                        text: qsTr ("GitHub Project")
                        onClicked: app.openGitHubProject()
                    }

                    MenuItem {
                        visible: enabled
                        enabled: AdsEnabled
                        text: qsTr ("Remove Ads")
                        onClicked: app.removeAds()
                        height: enabled ? implicitHeight : 0
                    }
                }
            }
        }
    }

    //
    // Drawer with application name and available pages
    //
    Components.PageDrawer {
        z: 0
        id: drawer
        iconTitle: AppName
        iconBgColorLeft: app.accentColor
        iconBgColorRight: app.secondaryAccentColor
        //Material.theme: Material.Light
        iconSource: "qrc:/icons/logo.svg"
        iconSubtitle: qsTr ("Version %1").arg (AppVersion)
        iconSubSubtitle: qsTr ("Developed by %1").arg (AppDeveloper)
        height: AdsEnabled ? app.height - app.bannerHeight - 1 : app.height

        //
        // Define the actions to take for each drawer item
        //
        actions: {
            0: function() { loadPage (accelerometer, 0) },
            1: function() { loadPage (altimeter, 1) },
            2: function() { loadPage (ambientLight, 2) },
            3: function() { loadPage (ambientTemperature, 3) },
            4: function() { loadPage (clock, 4) },
            5: function() { loadPage (compass, 5) },
            6: function() { loadPage (distanceSensor, 6) },
            7: function() { loadPage (gyroscope, 7) },
            8: function() { loadPage (infraredProximity, 8) },
            9: function() { loadPage (lightSensor, 9) },
            10: function() { loadPage (magnetometer, 10) },
            11: function() { loadPage (orientation, 11) },
            12: function() { loadPage (pressure, 12) },
            13: function() { loadPage (proximity, 13) },
            14: function() { loadPage (rotation, 14) },
            15: function() { loadPage (taps, 15) },
            16: function() { loadPage (tilt, 16) }
        }

        //
        // Define the drawer items
        //
        items: ListModel {
            id: pagesModel

            ListElement {
                pageTitle: qsTr ("Accelerometer")
                pageIcon: "qrc:/icons/sensors/accelerometer.svg"
            }

            ListElement {
                pageTitle: qsTr ("Altimeter")
                pageIcon: "qrc:/icons/sensors/altimeter.svg"
            }

            ListElement {
                pageTitle: qsTr ("Ambient Light")
                pageIcon: "qrc:/icons/sensors/ambient_light.svg"
            }

            ListElement {
                pageTitle: qsTr ("Ambient Temperature")
                pageIcon: "qrc:/icons/sensors/ambient_temperature.svg"
            }

            ListElement {
                pageTitle: qsTr ("Clock")
                pageIcon: "qrc:/icons/sensors/clock.svg"
            }

            ListElement {
                pageTitle: qsTr ("Compass")
                pageIcon: "qrc:/icons/sensors/compass.svg"
            }

            ListElement {
                pageTitle: qsTr ("Distance Sensor")
                pageIcon: "qrc:/icons/sensors/distance_sensor.svg"
            }

            ListElement {
                pageTitle: qsTr ("Gyroscope")
                pageIcon: "qrc:/icons/sensors/gyroscope.svg"
            }

            ListElement {
                pageTitle: qsTr ("IR Proximity")
                pageIcon: "qrc:/icons/sensors/ir_proximity.svg"
            }

            ListElement {
                pageTitle: qsTr ("Light Sensor")
                pageIcon: "qrc:/icons/sensors/light_sensor.svg"
            }

            ListElement {
                pageTitle: qsTr ("Magnetometer")
                pageIcon: "qrc:/icons/sensors/magnetometer.svg"
            }

            ListElement {
                pageTitle: qsTr ("Orientation")
                pageIcon: "qrc:/icons/sensors/orientation.svg"
            }

            ListElement {
                pageTitle: qsTr ("Pressure")
                pageIcon: "qrc:/icons/sensors/pressure.svg"
            }

            ListElement {
                pageTitle: qsTr ("Proximity")
                pageIcon: "qrc:/icons/sensors/proximity.svg"
            }

            ListElement {
                pageTitle: qsTr ("Rotation")
                pageIcon: "qrc:/icons/sensors/rotation.svg"
            }

            ListElement {
                pageTitle: qsTr ("Taps")
                pageIcon: "qrc:/icons/sensors/taps.svg"
            }

            ListElement {
                pageTitle: qsTr ("Tilt")
                pageIcon: "qrc:/icons/sensors/tilt.svg"
            }

            ListElement {
                separator: true
            }

            ListElement {
                link: true
                pageIcon: "qrc:/icons/love.svg"
                pageTitle: qsTr ("Rate This App")
            }
        }
    }

    //
    // Page loader
    //
    StackView {
        z: 2
        id: stack
        anchors.fill: parent
        initialItem: accelerometer

        anchors {
            fill: parent
            topMargin: toolbar.height - 2
        }

        popExit: Transition {}
        popEnter: Transition {}
        pushExit: Transition {}
        pushEnter: Transition {}

        Sensors.Accelerometer {
            id: accelerometer
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Altimeter {
            id: altimeter
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.AmbientLight {
            id: ambientLight
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.AmbientTemperature {
            id: ambientTemperature
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Clock {
            id: clock
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Compass {
            id: compass
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.DistanceSensor {
            id: distanceSensor
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Gyroscope {
            id: gyroscope
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.InfraredProximity {
            id: infraredProximity
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.LightSensor {
            id: lightSensor
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Magnetometer {
            id: magnetometer
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Orientation {
            id: orientation
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Pressure {
            id: pressure
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Proximity {
            id: proximity
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Rotation {
            id: rotation
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Taps {
            id: taps
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }

        Sensors.Tilt {
            id: tilt
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
        }
    }
}
