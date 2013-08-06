import bb.cascades 1.0

//=-=-=-=-=-=-=-=-=-=-=-=-=
// Set up your basic page
//=-=-=-=-=-=-=-=-=-=-=-=-=
Page {
    // Allow invokeSearch to be called and manipulated 
	property alias invokeSearch: searchField.text
    onInvokeSearchChanged: {
        //app.showToast("Invoke search changed!");
        myWebView.postMessage(searchField.text);
    }
    
    //=-=-=-=-=-=-=-=-=-=-=-=-=
    // Top menu
    //=-=-=-=-=-=-=-=-=-=-=-=-=
    Menu.definition: MenuDefinition {
        // Specify the actions that should be included in the menu
        // (make sure you've included the extra C++ code to enable toasts)
        actions: [
            ActionItem {
                title: qsTr("Debug")
                imageSource: "asset:///images/ic_edit.png"
                onTriggered: {
                    app.showToast("Calling postMessage...");
                    myWebView.postMessage(searchField.text);
                }
            },
            ActionItem {
                title: qsTr("Refresh...")
                imageSource: "asset:///images/ajax-loader.gif"
                onTriggered: {
                    slideOutAnimation.play();
                    app.showToast("Refreshing data..");
                    myWebView.reload();
                    slideInAnimation.play();
                }
            },
            ActionItem {
                title: qsTr("PIN msg")
                imageSource: "asset:///images/ic_open.png"
                onTriggered: {
                    app.pinMessage("Hey there dude!");
                    app.showToast("Pin messaged...");
                }
            },
            ActionItem {
                title: qsTr("Go Back")
                imageSource: "asset:///images/ic_previous.png"
                onTriggered: {
                    app.showToast("Going back...");
                    myWebView.goBack();
                }
            }
        ]
        helpAction: HelpActionItem {
            title: qsTr("Info")
            imageSource: "asset:///images/ic_info.png"
            onTriggered: {
                app.showToast("WebView Example version 1.0\nCreated by Sebastian Barthelmess\nCopyright 2013");
            }
        }
    }

    //=-=-=-=-=-=-=-=-=-=-=-=-=
    // Main page container
    //=-=-=-=-=-=-=-=-=-=-=-=-=
    Container {
        background: backgroundPaint.imagePaint

        // Let's set up a fancy header icon... with text and animations
        Container {
            // Define animations for header icon
            animations: [
                TranslateTransition {
                    id: translateAnimation
                    fromY: 300
                    toY: 0
                    fromX: -600
                    toX: 0
                    duration: 3000
                    easingCurve: StockCurve.QuadraticInOut
                },
                RotateTransition {
                    id: rotateAnimation
                    fromAngleZ: 90
                    toAngleZ: 0
                    duration: 3000
                }
            ]
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Center
            ImageView {
                imageSource: "asset:///images/webview.png"
            }
            Label {
                verticalAlignment: VerticalAlignment.Center
                textStyle {
                    color: Color.White
                    fontWeight: FontWeight.Bold
                    fontSize: FontSize.Large
                }
                text: app.title;
            }
        }

        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        // Our main content page sits in this scrollview
        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            ScrollView {
            animations: [
                TranslateTransition {
                    id: slideInAnimation
                    fromY: 1000
                    toY: 0
                    duration: 3000
                    easingCurve: StockCurve.QuadraticIn
                },
                TranslateTransition {
                    id: slideOutAnimation
                    fromY: 0
                    toY: 1000
                    duration: 3000
                    easingCurve: StockCurve.QuadraticIn
                }
            ]

            WebView {
                opacity: 0.5
                id: myWebView
                settings.background: Color.Transparent
                url: "local:///assets/simple.html"
            }
        }
    }

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }

            leftPadding: 20.0
            rightPadding: 20.0

            TextField {
                id: searchField
                objectName: "searchField"
                hintText: "Enter Search Criteria"
                textFormat: TextFormat.Plain
                inputMode: TextFieldInputMode.Text
                verticalAlignment: VerticalAlignment.Center
                text: app.uri;
            }

            Button {
                text: "Go!"
                verticalAlignment: VerticalAlignment.Bottom
                maxWidth: 150
                onClicked: {
                    myWebView.postMessage(searchField.text);
                }
            }
        }
    }

    // Set background image and font for main page
    attachedObjects: [
        TextStyleDefinition {
            id: stdTextStyle
            base: SystemDefaults.TextStyles.BigText
            fontWeight: FontWeight.Bold
            color: Color.create("#ff5D5D5D")
        },
        ImagePaintDefinition {
            id: backgroundPaint
            repeatPattern: RepeatPattern.Fill
            imageSource: "asset:///images/carbon.jpg"
        }
    ]
    
    // Run all our animations once the Cascades page has been initialized
    onCreationCompleted: {
        translateAnimation.play();
        rotateAnimation.play();
        slideInAnimation.play();
        
        // enable layout to adapt to the device rotation
        // don't forget to enable screen rotation in bar-bescriptor.xml (Application->Orientation->Auto-orient)
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
    }

}