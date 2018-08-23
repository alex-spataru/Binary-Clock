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

.pragma library

function xComponent (angle, magnitude) {
    return magnitude * Math.cos (angle)
}

function yComponent (angle, magnitude) {
    return magnitude * Math.sin (angle)
}

function drawHandles (ctx) {
    /* Get canvas properties */
    var canvas = ctx.canvas

    /* Set handle sizes */
    var hrsHandleSize = canvas.width * 0.16
    var minHandleSize = canvas.width * 0.27
    var secHandleSize = canvas.width * 0.30

    /* Get origin point */
    var centerX = canvas.width / 2
    var centerY = canvas.height / 2

    /* Get current time */
    var date = new Date();
    var minutes = Qt.formatDateTime (date, "mm")
    var seconds = Qt.formatDateTime (date, "ss")
    var hours = Qt.formatDateTime (date, "hh")
    if (hours > 12)
        hours = Math.abs (12 - hours)

    /* Calculate angles */
    var hrsAngle = (Math.PI) * ((hours / 6) - 1/2)
    var minAngle = (Math.PI) * ((minutes / 30) - 1/2)
    var secAngle = (Math.PI) * ((seconds / 30) - 1/2)

    /* Clear previous drawing */
    ctx.reset()

    /* Set line properties */
    ctx.lineWidth = 3
    ctx.lineCap = "round"
    ctx.strokeStyle = Qt.rgba (1, 1, 1, 0.85)

    /* Draw hour handle */
    ctx.beginPath()
    ctx.moveTo (centerX - xComponent (hrsAngle, hrsHandleSize / 5),
                centerY - yComponent (hrsAngle, hrsHandleSize / 5))
    ctx.lineTo (centerX + xComponent (hrsAngle, hrsHandleSize),
                centerY + yComponent (hrsAngle, hrsHandleSize))
    ctx.stroke()

    /* Draw minute handle */
    ctx.beginPath()
    ctx.moveTo (centerX - xComponent (minAngle, minHandleSize / 5),
                centerY - yComponent (minAngle, minHandleSize / 5))
    ctx.lineTo (centerX + xComponent (minAngle, minHandleSize),
                centerY + yComponent (minAngle, minHandleSize))
    ctx.stroke()

    /* Draw seconds handle */
    ctx.beginPath()
    ctx.lineWidth = 2
    ctx.strokeStyle = Qt.rgba (1.00, 0.53, 0.26, 0.85)
    ctx.moveTo (centerX - xComponent (secAngle, secHandleSize / 5),
                centerY - yComponent (secAngle, secHandleSize / 5))
    ctx.lineTo (centerX + xComponent (secAngle, secHandleSize),
                centerY + yComponent (secAngle, secHandleSize))
    ctx.stroke()
}

function drawDate (ctx) {
    /* Get origint point */
    var centerX = ctx.canvas.width / 2
    var centerY = ctx.canvas.height / 2

    /* Clear previous drawing */
    ctx.reset()

    /* Set shadow properties */
    ctx.shadowBlur = 12
    ctx.shadowColor = Qt.rgba (0.04, 0.04, 0.04, 0.6)

    /* Draw date */
    ctx.beginPath()
    ctx.textAlign = "center"
    ctx.font = "bold 18px Roboto"
    ctx.fillStyle = Qt.rgba (1, 1, 1, 0.85)
    ctx.fillText (Qt.formatDate (new Date(), "ddd, MMM dd, yyyy").toUpperCase(), centerX, centerY)
}

function drawBackground (ctx) {
    /* Get canvas properties */
    var canvas = ctx.canvas
    var diameter = canvas.width * 0.8
    var radius = diameter / 2

    /* Get origin point */
    var centerX = canvas.width / 2
    var centerY = canvas.height / 2

    /* Clear previous drawing */
    ctx.reset()

    /* Set line properties */
    ctx.lineCap = "round"
    ctx.strokeStyle = Qt.rgba (1, 1, 1, 0.85)

    /* Set shadow properties */
    ctx.shadowBlur = 12
    ctx.shadowColor = Qt.rgba (0.04, 0.04, 0.04, 0.6)

    /* Draw circle background */
    ctx.beginPath()
    ctx.fillStyle = Qt.rgba (0.19, 0.19, 0.19, 0.4)
    ctx.arc (centerX, centerY, radius - 4, 0, 2 * Math.PI, true)
    ctx.fill()

    /* Draw circle foreground */
    ctx.beginPath()
    ctx.lineWidth = 4
    ctx.arc (centerX, centerY, radius - 4, 0, 2 * Math.PI, true)
    ctx.stroke()
}
