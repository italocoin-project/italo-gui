import QtQuick 2.9

import "." as ItaloComponents
import "effects/" as ItaloEffects

Rectangle {
    color: ItaloComponents.Style.appWindowBorderColor
    height: 1

    ItaloEffects.ColorTransition {
        targetObj: parent
        blackColor: ItaloComponents.Style._b_appWindowBorderColor
        whiteColor: ItaloComponents.Style._w_appWindowBorderColor
    }
}
