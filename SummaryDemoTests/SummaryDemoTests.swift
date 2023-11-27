//
//  SummaryDemoTests.swift
//  SummaryDemoTests
//
//  Created by gwl-42 on 24/11/23.
//

import XCTest
@testable import SummaryDemo

final class SummaryDemoTests: XCTestCase {
    
    var viewModel: LoginViewModel!

    override func setUpWithError() throws {
        viewModel = LoginViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidEmail() throws {
        viewModel.userLogin.email = "example@example.com"
        XCTAssertTrue(viewModel.validationManager.isValidEmail(email: viewModel.userLogin.email))
      }

      func testInvalidEmail() throws {
          viewModel.userLogin.email = "invalidemail"
          XCTAssertFalse(viewModel.validationManager.isValidEmail(email: viewModel.userLogin.email))
      }

      func testValidPassword() throws {
          viewModel.userLogin.password = "securepassword"
          XCTAssertTrue(viewModel.validationManager.isValidPassword(password: viewModel.userLogin.password))
      }

      func testInvalidPassword() throws {
          viewModel.userLogin.password = "pass"
          XCTAssertFalse(viewModel.validationManager.isValidPassword(password: viewModel.userLogin.password))
      }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
