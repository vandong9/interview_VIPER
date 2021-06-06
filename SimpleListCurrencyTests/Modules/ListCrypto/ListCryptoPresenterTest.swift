//
//  ListCryptoPresenterTest.swift
//  SimpleListCurrencyTests
//

import XCTest
import RxSwift
import RxCocoa
@testable import SimpleListCurrency

class ListCryptoPresenterTest: XCTestCase {
    var presenter: ListCryptoPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenReceiveViewCommnadLoadCrypto_ShouldCallInteracterFetchCrypto() throws {
        // Prepare

        class MockListCryptoInteractorListener: ListCryptoInteractorListenerProtocol {
            func handle(response: ListCryptoInteractorResponse) {
                
            }
        }
        
        class MockIntecter: ListCryptoInteractorProtocol {
            var isCalledFetchCrypto = false
            var responseListener: ListCryptoInteractorListenerProtocol?
            func handle(request: ListCryptotInteractorRequest) {
                switch request {
                case .fetchCryto:
                    isCalledFetchCrypto = true
                }
            }            
        }
        
        let mockIntecter = MockIntecter()
        presenter = ListCryptoPresenter(interactor: mockIntecter)

        // Act
        presenter.handle(event: .loadCryto)
        
        // Assert
        XCTAssertTrue(mockIntecter.isCalledFetchCrypto)
    }
    
    func testWhenReceiveViewCommnadSearchCryptoName_ShouldReturnArrayCryptoWithNameContainSearchText() throws {
        // Prepare
        class MockListCryptoPresenterListener: ListCryptoPresenterListenerProtocol {
            var searchResultCrytos: [CrytoModel] = []
            func handle(command: ListCryptoPresenterCommand) {
                switch command {
                case .populateList(cryptos: let cryptos):
                    self.searchResultCrytos = cryptos
                default: break
                }
            }
        }

        class MockIntecter: ListCryptoInteractorProtocol {
            var isCalledFetchCrypto = false
            var responseListener: ListCryptoInteractorListenerProtocol?
            func handle(request: ListCryptotInteractorRequest) {
                switch request {
                case .fetchCryto:
                    isCalledFetchCrypto = true
                }
            }
            
        }
        
        let mockIntecter = MockIntecter()
        let mockListCryptoPresenterListener = MockListCryptoPresenterListener()
        presenter = ListCryptoPresenter(interactor: mockIntecter)
        presenter.ListCryptoViewController = mockListCryptoPresenterListener
        presenter.allCrypto = [Crypto(icon: "", name: "aaa", base: "", counter: "", buyPrice: "", sellPrice: ""), Crypto(icon: "", name: "", base: "", counter: "", buyPrice: "", sellPrice: "")]

        // Act
        presenter.handle(event: .searchCryptoName(searchText: "a"))
        
        // Assert
        XCTAssertTrue(mockListCryptoPresenterListener.searchResultCrytos.count == 1)
    }
    
    func testWhenReceiveViewCommnadAddCrypto_ShouldAppaDataManagerFavoriteContainAddedCrypto() throws {
        // Prepare
        class MockListCryptoPresenterListener: ListCryptoPresenterListenerProtocol {
            var searchResultCrytos: [CrytoModel] = []
            func handle(command: ListCryptoPresenterCommand) {
                switch command {
                case .populateList(cryptos: let cryptos):
                    self.searchResultCrytos = cryptos
                default: break
                }
            }
        }

        class MockIntecter: ListCryptoInteractorProtocol {
            var isCalledFetchCrypto = false
            var responseListener: ListCryptoInteractorListenerProtocol?
            func handle(request: ListCryptotInteractorRequest) {
                switch request {
                case .fetchCryto:
                    isCalledFetchCrypto = true
                }
            }
            
        }
        
        let mockIntecter = MockIntecter()
        let mockListCryptoPresenterListener = MockListCryptoPresenterListener()
        presenter = ListCryptoPresenter(interactor: mockIntecter)
        presenter.ListCryptoViewController = mockListCryptoPresenterListener
        presenter.allCrypto = [Crypto(icon: "", name: "aaa", base: "", counter: "", buyPrice: "", sellPrice: ""), Crypto(icon: "", name: "", base: "", counter: "", buyPrice: "", sellPrice: "")]

        // Act
        presenter.handle(event: .addFavoriteCrypto(name: "aaa"))
        
        // Assert
        guard let favoriteCrypto = try? AppDataManager.shared.favoriteCrypto.value() else {
            XCTFail()
            return
        }
                
        XCTAssertNotNil(favoriteCrypto.first(where: { $0.name == "aaa"}))
    }
}
