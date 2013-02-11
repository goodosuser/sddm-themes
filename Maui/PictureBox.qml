/***************************************************************************
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.0

FocusScope {
    id: container

    width: 150; height: 180;
    clip: true

    property alias name: name.text
    property alias icon: icon.source
    property alias password: password.text

    signal login()

    states: [
        State {
            name: "focus"; when: container.activeFocus
            PropertyChanges { target: container; height: 225 }
        }
    ]

    Behavior on height { NumberAnimation { duration: 100 } }

    Rectangle {
        id: shadow
        anchors.fill: parent
        color: "#55000000"
    }

    Rectangle {
        id: canvas
        anchors.fill: shadow
        anchors.margins: 2
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: container.focus = true
        onExited: container.focus = false
    }

    Column {
        anchors.fill: canvas
        anchors.margins: 5
        spacing: 5

        clip: true

        Image {
            id: icon
            width: parent.width; height: 150
            fillMode: Image.PreserveAspectCrop
        }

        Text {
            id: name
            height: 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#666666"
            clip: true

            font.bold: true; font.capitalization: Font.AllUppercase
        }

        TextBox {
            id: password
            width: parent.width; height: 30
            font.pixelSize: 14

            echoMode: TextInput.Password
            focus: true

            Keys.onPressed: {
                if (event.key === Qt.Key_Return) {
                    container.login(password.text);
                    event.accepted = true
                }
            }
        }
    }
}
