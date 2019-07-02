import QtQuick 2.9

import "../components" as ItaloComponents

TextEdit {
    color: ItaloComponents.Style.defaultFontColor
    font.family: ItaloComponents.Style.fontRegular.name
    selectionColor: ItaloComponents.Style.textSelectionColor
    wrapMode: Text.Wrap
    readOnly: true
    selectByMouse: true
    // Workaround for https://bugreports.qt.io/browse/QTBUG-50587
    onFocusChanged: {
        if(focus === false)
            deselect()
    }
}
