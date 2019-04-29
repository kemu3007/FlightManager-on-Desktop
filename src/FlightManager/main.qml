import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtCharts 2.3
import QtLocation 5.6
import QtPositioning 5.6

Window {
    id: main
    visible: true
    width: 640
    height: 480
    property alias pitch_value: pitch_value
    property alias roll_value: roll_value
    property alias yaw_value: yaw_value
    property alias flightmap: flightmap
    property alias airspeed_value: airspeed_value
    property alias altimeter_value: altimeter_value
    property alias cadence_value: cadence_value
    property alias map: flightmap
    title: qsTr("FlightManagerMain")

    Grid {
        clip: false
        anchors.rightMargin: 400
        flow: Grid.LeftToRight
        anchors.fill: parent
        spacing: 33
        rows: 6
        columns: 2

        Text {
            id: airspeed
            text: qsTr("気速")
            font.pixelSize: 18
        }

        Text {
            id: airspeed_value
            text: qsTr("0.0")
            font.pixelSize: 18
        }


        Text {
            id: altimeter
            text: qsTr("高度")
            font.pixelSize: 18
        }

        Text {
            id: altimeter_value
            text: qsTr("0.0")
            font.pixelSize: 18
        }

        Text {
            id: cadence
            text: qsTr("回転数")
            font.pixelSize: 18
        }


        Text {
            id: cadence_value
            text: qsTr("0.0")
            font.pixelSize: 18
        }

        Text {
            id: pitch
            text: qsTr("pitch")
            font.pixelSize: 18
        }

        Text {
            id: pitch_value
            text: qsTr("0.0")
            font.pixelSize: 18
        }

        Text {
            id: roll
            text: qsTr("roll")
            font.pixelSize: 18
        }

        Text {
            id: roll_value
            text: qsTr("0.0")
            font.pixelSize: 18
        }

        Text {
            id: yaw
            text: qsTr("yaw")
            font.pixelSize: 18
        }

        Text {
            id: yaw_value
            text: qsTr("0.0")
            font.pixelSize: 18
        }

    }
    Plugin {
        name: "mapboxgl"
        PluginParameter {
            name: "mapbox.access_token"
            value: "pk.eyJ1IjoibXVyYWthd2EiLCJhIjoiY2pwdWt0bDdzMDYzeDN4bXRmano3ZnE3diJ9.MJevNgJU_ikV-ty4GTszTw"
        }
        PluginParameter {
            name: "mapboxgl.mapping.additional_style_urls"
            value: "mapbox://styles/murakawa/cjv1p9oyg0qez1fl8kzoldq1v"
        }
    }

    PositionSource{
        id: gps
        active: true
        updateInterval: 1000
        onPositionChanged: {
            flightmap.update()
            console.log(gps.position.coordinate)
        }
    }

    Rectangle {
        id: rectangle
        x: 136
        y: 0
        width: 504
        height: 480

        Map {
            id: flightmap
            x: 136
            anchors.fill: parent
            copyrightsVisible: false
            zoomLevel: 14
            center: gps.position.coordinate
            plugin: Plugin{name:"mapboxgl"}

            MapQuickItem {
                id: marker
                sourceItem: Image {
                    id: home_icon
                    width: 40
                    height: 60
                    rotation: 20
                    source: "map_icon.png"
                }
                visible: true
                anchorPoint.x: marker.width / 2
                anchorPoint.y: marker.height /2
                coordinate: gps.position.coordinate
            }
        }
    }
}





