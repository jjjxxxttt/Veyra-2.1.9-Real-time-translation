// Shared dialog presentation; extracted without changing geometry or motion.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    property string placeholder: ""
    property alias text: field.text
    signal edited(string text)
    // Every keystroke. editingFinished alone needs Enter or a focus change: typing a
    // value and clicking 连接 (which takes no focus) or closing the dialog lost it.
    signal typed(string text)
    implicitHeight: 30
    radius: 9
    color: Qt.rgba(1, 1, 1, 0.04)
    border.width: 1
    border.color: field.activeFocus ? Theme.accent : Theme.stroke
    // 长内容（API 密钥）横向滚动时若不裁剪，字形会画到圆角框以外，
    // 压到左侧的提示文字上。
    clip: true
    TextInput {
        id: field
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        verticalAlignment: TextInput.AlignVCenter
        color: Theme.t1
        font.family: Theme.fontUi
        font.pixelSize: Theme.fsBody
        selectByMouse: true
        onEditingFinished: parent.edited(text)
        onTextEdited: parent.typed(text)
    }
    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        visible: field.text.length === 0
        text: parent.placeholder
        color: Theme.t3
        font.family: Theme.fontUi
        font.pixelSize: Theme.fsBody
    }
}
