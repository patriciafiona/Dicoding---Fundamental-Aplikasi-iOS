//
//  UITestingUITests.swift
//  UITestingUITests
//
//  Created by Patricia Fiona on 21/09/22.
//

import XCTest

final class UITestingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Hello, world!"].tap()
        app.alerts["Apa kabar?"].scrollViews.otherElements.buttons["Luar biasa!"].tap()
        
        //UI Testing Screenshot
        let screenshot = XCUIApplication().screenshot()
        let attachment = XCTAttachment(screenshot:screenshot)
        attachment.lifetime = .keepAlways
        attachment.name = "OpeningScreen"
        self.add(attachment)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
