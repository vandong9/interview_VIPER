//
//  BaseViewControllerTest.swift
//  SimpleListCurrencyTests
//


import XCTest
import RxSwift
import RxCocoa
@testable import SimpleListCurrency

class BaseViewControllerTest: XCTestCase {
    var viewcontroller: BaseViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenShowAlert_ShouldPresentAler() throws {
        viewcontroller = BaseViewController()
        
        viewcontroller.showAlert(title: "", message: "")
    }


}
