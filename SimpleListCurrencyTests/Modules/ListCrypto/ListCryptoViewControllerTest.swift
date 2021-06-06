//
//  ListCryptoViewControllerTest.swift
//  SimpleListCurrencyTests
//

import XCTest
import RxSwift
import RxCocoa
@testable import SimpleListCurrency

class ListCryptoViewControllerTest: XCTestCase {
    var viewController: ListCryptoViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWhenLoadView_ShouldShowListCrypto() throws {
        // Prepare
        class MockListCryptoInteractor: ListCryptoInteractorProtocol {
            var responseListener: ListCryptoInteractorListenerProtocol?
            
            func handle(request: ListCryptotInteractorRequest) {
                
            }
        }
        class MockListCryptoPresenter: ListCryptoPresenterProtocol {
            var interactor: ListCryptoInteractorProtocol
            
            var commandListener: ListCryptoPresenterListenerProtocol?
            
            func handle(event: ListCryptoViewEvent) {
                switch event {
                case .loadCryto:
                    commandListener?.handle(command: .populateList(cryptos: [Crypto(icon: "", name: "aaa", base: "", counter: "", buyPrice: "", sellPrice: ""), Crypto(icon: "", name: "", base: "", counter: "", buyPrice: "", sellPrice: "")].map({ CrytoModel(cryto: $0)
                    })))
                default:
                    break
                }
            }
            
            init(interactor: ListCryptoInteractorProtocol) {
                self.interactor = interactor
            }
        }
        viewController = ListCryptoViewController.storyboardInstance
        let mockListCryptoPresenter = MockListCryptoPresenter(interactor: MockListCryptoInteractor())
        viewController.presenter = mockListCryptoPresenter
        mockListCryptoPresenter.commandListener = viewController
        
        // Act
        viewController.viewDidLoad()
        let promise = expectation(description: "Wait for response")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)

        // Assert
        XCTAssertTrue(viewController.tableView.visibleCells.count == 2)
    }
    
    func testWhenSelectCrytoToAddToFavorite_ShouldShowListCrypto() throws {
        /// Prepare
        class MockListCryptoInteractor: ListCryptoInteractorProtocol {
            var responseListener: ListCryptoInteractorListenerProtocol?
            
            func handle(request: ListCryptotInteractorRequest) {
                
            }
        }
        
        class MockListCryptoPresenter: ListCryptoPresenterProtocol {
            var isAddedFavorite = false
            var interactor: ListCryptoInteractorProtocol
            
            var commandListener: ListCryptoPresenterListenerProtocol?
            
            func handle(event: ListCryptoViewEvent) {
                switch event {
                case .loadCryto:
                    commandListener?.handle(command: .populateList(cryptos: [Crypto(icon: "", name: "aaa", base: "", counter: "", buyPrice: "", sellPrice: ""), Crypto(icon: "", name: "", base: "", counter: "", buyPrice: "", sellPrice: "")].map({ CrytoModel(cryto: $0)
                    })))
                case .addFavoriteCrypto(name: _):
                    isAddedFavorite = true
                default:
                    break
                }
            }
            
            init(interactor: ListCryptoInteractorProtocol) {
                self.interactor = interactor
            }
        }
        viewController = ListCryptoViewController.storyboardInstance
        let mockListCryptoPresenter = MockListCryptoPresenter(interactor: MockListCryptoInteractor())
        viewController.presenter = mockListCryptoPresenter
        mockListCryptoPresenter.commandListener = viewController
        // load view
        viewController.viewDidLoad()
        let promise = expectation(description: "Wait for response")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)

        
        /// Act
        guard let cell = viewController.tableView.visibleCells.first as? CryptoPriceTableViewCell else {
            XCTFail("Fail testWhenSelectCrytoToAddToFavorite_ShouldShowListCrypto")
            return
        }
        
        cell.likeButton.sendActions(for: .touchUpInside)
        
        /// Assert
        XCTAssertTrue(mockListCryptoPresenter.isAddedFavorite)
    }
    
    
    
    func testWhenSwichToShowFavorite_ShouldShowListFavorite() throws {
        /// Prepare
        class MockListCryptoInteractor: ListCryptoInteractorProtocol {
            var responseListener: ListCryptoInteractorListenerProtocol?

            func handle(request: ListCryptotInteractorRequest) {

            }
        }

        class MockListCryptoPresenter: ListCryptoPresenterProtocol {
            var isAddedFavorite = false
            var interactor: ListCryptoInteractorProtocol

            var commandListener: ListCryptoPresenterListenerProtocol?

            func handle(event: ListCryptoViewEvent) {
                switch event {
                case .loadCryto:
                    commandListener?.handle(command: .populateList(cryptos: [Crypto(icon: "", name: "aaa", base: "", counter: "", buyPrice: "", sellPrice: ""), Crypto(icon: "", name: "", base: "", counter: "", buyPrice: "", sellPrice: "")].map({ CrytoModel(cryto: $0)
                    })))
                case .addFavoriteCrypto(name: _):
                    isAddedFavorite = true
                default:
                    break
                }
            }

            init(interactor: ListCryptoInteractorProtocol) {
                self.interactor = interactor
            }
        }
        viewController = ListCryptoViewController.storyboardInstance
        let mockListCryptoPresenter = MockListCryptoPresenter(interactor: MockListCryptoInteractor())
        viewController.presenter = mockListCryptoPresenter
//        mockListCryptoPresenter.commandListener = viewController
        // load view
        viewController.viewDidLoad()
        let promise = expectation(description: "Wait for response")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)

        
        /// Act
        viewController.displayModeSegment.selectedSegmentIndex = 1
        viewController.displayModeSegment.sendActions(for: .valueChanged)
        
        /// Assert
        XCTAssertTrue(viewController.favoriteCryptoView.isHidden == false)
    }

}
