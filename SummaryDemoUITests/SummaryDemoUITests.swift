//
//  SummaryDemoUITests.swift
//  SummaryDemoUITests
//
//  Created by gwl-42 on 24/11/23.
//

import XCTest

final class SummaryDemoUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
               app = XCUIApplication()
               app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testLoginViewElementsExist() {
         let emailTextField = app.textFields["Email"]
         XCTAssertTrue(emailTextField.exists)

         let passwordTextField = app.secureTextFields["Password"]
         XCTAssertTrue(passwordTextField.exists)

         let loginButton = app.buttons["Login"]
         XCTAssertTrue(loginButton.exists)
     }

     func testLoginWithValidCredentials() {
         let emailTextField = app.textFields["Email"]
         emailTextField.tap()
         emailTextField.typeText("example@example.com")

         let passwordTextField = app.secureTextFields["Password"]
         passwordTextField.tap()
         passwordTextField.typeText("securepassword")

         let loginButton = app.buttons["Login"]
         loginButton.tap()

         // Add assertion for successful login scenario based on your app flow
     }

     func testLoginWithInvalidCredentials() {
         let emailTextField = app.textFields["Email"]
         emailTextField.tap()
         emailTextField.typeText("invalidemail")

         let passwordTextField = app.secureTextFields["Password"]
         passwordTextField.tap()
         passwordTextField.typeText("pass")

         let loginButton = app.buttons["Login"]
         loginButton.tap()

         // Add assertion for handling unsuccessful login scenario based on your app flow
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
