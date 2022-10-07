/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2015 Teo Mrnjavac <teo@kde.org>
 *   SPDX-FileCopyrightText: 2018 Adriaan de Groot <groot@kde.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    function nextSlide() {
        console.log("QML Component (default slideshow) Next slide");
        presentation.goToNextSlide();
    }

    Timer {
        id: advanceTimer
        interval: 5000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {
        anchors.fill: parent

        Image {
            id: background1
            source: "slides/1.png"
            anchors.fill: parent
        }
    }

    Slide {
        anchors.fill: parent

        Image {
            id: background2
            source: "slides/2.png"
            anchors.fill: parent
        }
    }

    Slide {
        anchors.fill: parent

        Image {
            id: background3
            source: "slides/3.png"
            anchors.fill: parent
        }
    }
    
    Slide {
        anchors.fill: parent

        Image {
            id: background4
            source: "slides/4.png"
            anchors.fill: parent
        }
    }
    
    function onActivate() {
        console.log("QML Component (default slideshow) activated");
        presentation.currentSlide = 0;
    }

    function onLeave() {
        console.log("QML Component (default slideshow) deactivated");
    }

}
