// Copyright (c) 2014-2019, The Italo Project
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.0
import FontAwesome 1.0

import "../components" as ItaloComponents

Item {
    id: root
    visible: false
    z: parent.z + 2

    property bool isHidden: true
    property alias passphrase: passphaseInput1.text
    property string walletName
    property string errorText

    // same signals as Dialog has
    signal accepted()
    signal rejected()
    signal closeCallback()

    function open(walletName, errorText) {
        isHidden = true
        passphaseInput1.echoMode = TextInput.Password;
        passphaseInput2.echoMode = TextInput.Password;

        inactiveOverlay.visible = true

        root.walletName = walletName ? walletName : ""
        root.errorText = errorText ? errorText : "";

        leftPanel.enabled = false
        middlePanel.enabled = false
        titleBar.state = "essentials"

        root.visible = true;
        passphaseInput1.text = "";
        passphaseInput2.text = "";
        passphaseInput1.focus = true
    }

    function close() {
        inactiveOverlay.visible = false
        leftPanel.enabled = true
        middlePanel.enabled = true
        titleBar.state = "default"
        root.visible = false;
        closeCallback();
    }
    
    function toggleIsHidden() {
        passphaseInput1.echoMode = isHidden ? TextInput.Normal : TextInput.Password;
        passphaseInput2.echoMode = isHidden ? TextInput.Normal : TextInput.Password;
        isHidden = !isHidden;
    }

    function showError(errorText) {
        open(root.walletName, errorText);
    }

    // TODO: implement without hardcoding sizes
    width: 480
    height: 360

    ColumnLayout {
        z: inactiveOverlay.z + 1
        id: mainLayout
        spacing: 10
        anchors { fill: parent; margins: 35 }

        ColumnLayout {
            id: column

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: 400

            Label {
                text: (root.walletName.length > 0 ? qsTr("Please enter wallet device passphrase for: ") + root.walletName : qsTr("Please enter wallet device passphrase")) + translationManager.emptyString
                Layout.fillWidth: true

                font.pixelSize: 16
                font.family: ItaloComponents.Style.fontLight.name

                color: ItaloComponents.Style.defaultFontColor
            }

            Label {
                text: qsTr("Warning: passphrase entry on host is a security risk as it can be captured by malware. It is advised to prefer device-based passphrase entry.") + translationManager.emptyString
                Layout.fillWidth: true
                wrapMode: Text.Wrap

                font.pixelSize: 14
                font.family: ItaloComponents.Style.fontLight.name

                color: ItaloComponents.Style.warningColor
            }

            Label {
                text: root.errorText
                visible: root.errorText

                color: ItaloComponents.Style.errorColor
                font.pixelSize: 16
                font.family: ItaloComponents.Style.fontLight.name
                Layout.fillWidth: true
                wrapMode: Text.Wrap
            }

            TextField {
                id : passphaseInput1
                Layout.topMargin: 6
                Layout.fillWidth: true
                horizontalAlignment: TextInput.AlignLeft
                verticalAlignment: TextInput.AlignVCenter
                font.family: ItaloComponents.Style.fontLight.name
                font.pixelSize: 24
                echoMode: TextInput.Password
                bottomPadding: 10
                leftPadding: 10
                topPadding: 10
                color: ItaloComponents.Style.defaultFontColor
                selectionColor: ItaloComponents.Style.textSelectionColor
                selectedTextColor: ItaloComponents.Style.textSelectedColor
                KeyNavigation.tab: passphaseInput2

                background: Rectangle {
                    radius: 2
                    border.color: ItaloComponents.Style.inputBorderColorInActive
                    border.width: 1
                    color: ItaloComponents.Style.blackTheme ? "black" : "#A9FFFFFF"

                    ItaloComponents.Label {
                        fontSize: 20
                        text: isHidden ? FontAwesome.eye : FontAwesome.eyeSlash
                        opacity: 0.7
                        fontFamily: FontAwesome.fontFamily
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 1

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onClicked: {
                                toggleIsHidden()
                            }
                            onEntered: {
                                parent.opacity = 0.9
                                parent.fontSize = 24
                            }
                            onExited: {
                                parent.opacity = 0.7
                                parent.fontSize = 20
                            }
                        }
                    }
                }

                Keys.onEscapePressed: {
                    root.close()
                    root.rejected()
                }
            }

            // padding
            Rectangle {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                height: 10
                opacity: 0
                color: "transparent"
            }

            Label {
                text: qsTr("Please re-enter") + translationManager.emptyString
                Layout.fillWidth: true

                font.pixelSize: 16
                font.family: ItaloComponents.Style.fontLight.name

                color: ItaloComponents.Style.defaultFontColor
            }

            TextField {
                id : passphaseInput2
                Layout.topMargin: 6
                Layout.fillWidth: true
                horizontalAlignment: TextInput.AlignLeft
                verticalAlignment: TextInput.AlignVCenter
                font.family: ItaloComponents.Style.fontLight.name
                font.pixelSize: 24
                echoMode: TextInput.Password
                KeyNavigation.tab: okButton
                bottomPadding: 10
                leftPadding: 10
                topPadding: 10
                color: ItaloComponents.Style.defaultFontColor
                selectionColor: ItaloComponents.Style.dimmedFontColor
                selectedTextColor: ItaloComponents.Style.defaultFontColor

                background: Rectangle {
                    radius: 2
                    border.color: ItaloComponents.Style.inputBorderColorInActive
                    border.width: 1
                    color: ItaloComponents.Style.blackTheme ? "black" : "#A9FFFFFF"

                    ItaloComponents.Label {
                        fontSize: 20
                        text: isHidden ? FontAwesome.eye : FontAwesome.eyeSlash
                        opacity: 0.7
                        fontFamily: FontAwesome.fontFamily
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 1

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onClicked: {
                                toggleIsHidden()
                            }
                            onEntered: {
                                parent.opacity = 0.9
                                parent.fontSize = 24
                            }
                            onExited: {
                                parent.opacity = 0.7
                                parent.fontSize = 20
                            }
                        }
                    }
                }

                Keys.onReturnPressed: {
                    if (passphaseInput1.text === passphaseInput2.text) {
                        root.close()
                        root.accepted()
                    }
                }
                Keys.onEscapePressed: {
                    root.close()
                    root.rejected()
                }
            }

            // padding
            Rectangle {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                height: 10
                opacity: 0
                color: "black"
            }

            // Ok/Cancel buttons
            RowLayout {
                id: buttons
                spacing: 16
                Layout.topMargin: 16
                Layout.alignment: Qt.AlignRight

                ItaloComponents.StandardButton {
                    id: cancelButton
                    text: qsTr("Cancel") + translationManager.emptyString
                    KeyNavigation.tab: passphaseInput1
                    onClicked: {
                        root.close()
                        root.rejected()
                    }
                }
                ItaloComponents.StandardButton {
                    id: okButton
                    text: qsTr("Continue") + translationManager.emptyString
                    KeyNavigation.tab: cancelButton
                    enabled: passphaseInput1.text === passphaseInput2.text
                    onClicked: {
                        root.close()
                        root.accepted()
                    }
                }
            }
        }
    }
}
