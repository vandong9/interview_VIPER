//
//  ListCryptoInteracterTest.swift
//  SimpleListCurrencyTests
//


import XCTest
import RxSwift
import RxCocoa
@testable import SimpleListCurrency

class ListCryptoInteracterTest: XCTestCase {
    var interacter: ListCryptoInteractor!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenReceiveCommandFetchCrypto_ShouldCallCryptoEndpointRequest() throws {
        // Prepare
        class MockListCryptoInteractorListener: ListCryptoInteractorListenerProtocol {
            var didReceiveResponse = false
            func handle(response: ListCryptoInteractorResponse) {
                switch response {
                case .didFetchCrypto(result: let result):
                    didReceiveResponse = true
                }
            }
        }
        interacter = ListCryptoInteractor()
        let mockListCryptoInteractorListener = MockListCryptoInteractorListener()
        interacter.responseListener = mockListCryptoInteractorListener


        // Act
        interacter.handle(request: .fetchCryto)
        let promise = expectation(description: "Wait for response")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)

        // Assert
        XCTAssertTrue(mockListCryptoInteractorListener.didReceiveResponse)
    }

}
