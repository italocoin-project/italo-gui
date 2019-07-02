import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import "." as ItaloComponents

Rectangle {
    id: root
    property alias text: content.text
    property alias textColor: content.color
    property int fontSize: 15

    Layout.fillWidth: true
    Layout.preferredHeight: warningLayout.height

    color: ItaloComponents.Style.titleBarButtonHoverColor
    radius: 4
    border.color: ItaloComponents.Style.inputBorderColorInActive
    border.width: 1

    signal linkActivated;

    RowLayout {
        id: warningLayout
        spacing: 0
        anchors.left: parent.left
        anchors.right: parent.right

        Image {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: 33
            Layout.preferredWidth: 33
            Layout.rightMargin: 12
            Layout.leftMargin: 18
            Layout.topMargin: 12
            Layout.bottomMargin: 12
            source: "qrc:///images/warning.png"
        }

        TextArea {
            id: content
            Layout.fillWidth: true
            color: ItaloComponents.Style.defaultFontColor
            font.family: ItaloComponents.Style.fontRegular.name
            font.pixelSize: root.fontSize
            horizontalAlignment: TextInput.AlignLeft
            selectByMouse: true
            textFormat: Text.RichText
            wrapMode: Text.WordWrap
            textMargin: 0
            leftPadding: 4
            rightPadding: 18
            topPadding: 10
            bottomPadding: 10
            readOnly: true
            onLinkActivated: root.linkActivated();

            selectionColor: ItaloComponents.Style.textSelectionColor
            selectedTextColor: ItaloComponents.Style.textSelectedColor
        }
    }
}
