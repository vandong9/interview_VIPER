//
//  FavoriteCryptoViewTest.swift
//  SimpleListCurrencyTests
//


import XCTest
import RxSwift
import RxCocoa
@testable import SimpleListCurrency

class FavoriteCryptoViewTest: XCTestCase {
    var view: FavoriteCryptoView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        AppDataManager.shared.favoriteCrypto.onNext([])
    }

    func testWhenLoad_ShowFavoriteCryptoFromAppDataManager() throws {
        // Prepare
        AppDataManager.shared.addFavoriteCrypto(Crypto(icon: "", name: "aaa", base: "", counter: "", buyPrice: "", sellPrice: ""))
        
        // Act
        view = FavoriteCryptoView()
        view.bindViewModel(viewModel: FavoriteCryptoViewModel())
        let promise = expectation(description: "Wait for response")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)

        // Assert
        XCTAssertTrue(view.tableView.visibleCells.count > 0)
    }
    
    func testWhenTouchRemoveFavorite_ShowFCallAppDataManagerRemove() throws {
        // Prepare
        AppDataManager.shared.addFavoriteCrypto(Crypto(icon: "", name: "aaa", base: "", counter: "", buyPrice: "", sellPrice: ""))
        
        // Act
        view = FavoriteCryptoView()
        view.bindViewModel(viewModel: FavoriteCryptoViewModel())
        var promise = expectation(description: "Wait for response")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)
        
        guard let cell = view.tableView.visibleCells.first as? CryptoPriceTableViewCell else {
            XCTFail()
            return
        }
        
        cell.likeButton.sendActions(for: .touchUpInside)
        promise = expectation(description: "Wait for response")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2)
        

        // Assert
        XCTAssertTrue(view.tableView.visibleCells.count == 0)
    }

}
