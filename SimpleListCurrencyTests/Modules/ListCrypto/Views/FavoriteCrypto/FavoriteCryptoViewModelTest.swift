//
//  FavoriteCryptoViewModelTest.swift
//  SimpleListCurrencyTests
//


import XCTest
import RxSwift
import RxCocoa
@testable import SimpleListCurrency

class FavoriteCryptoViewModelTest: XCTestCase {
    var viewModel: FavoriteCryptoViewModel!
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        AppDataManager.shared.favoriteCrypto.onNext([])
    }

    func testWhenLoad_ShouldLoadFavoriteCryptoFromAppDataManager() {
        // Prepare
        viewModel = FavoriteCryptoViewModel()

        let loadTrigger = PublishSubject<Void>()
        let removeFavoriteCryptoTrigger = PublishSubject<IndexPath>()
        
        let output = viewModel.tranform(input: FavoriteCryptoViewModel.Input(loadTrigger: loadTrigger, removeFavoriteCryptoTrigger: removeFavoriteCryptoTrigger))
        var numOfCryptoModel: [CrytoModel] = []
        output.populateList.subscribe(onNext: { value in
            numOfCryptoModel = value
        }).disposed(by: disposeBag)
        
        AppDataManager.shared.addFavoriteCrypto(Crypto(icon: "", name: "aaaa", base: "", counter: "", buyPrice: "", sellPrice: ""))
        
        // Act
        loadTrigger.onNext(Void())
        
        // Assert
        XCTAssertTrue(numOfCryptoModel.count == 1)
        
    }

    func testWhenRemoveFavoriteCrypto_ShouldCallAppDataManagerToRemove() {
        // Prepare
        viewModel = FavoriteCryptoViewModel()

        let loadTrigger = PublishSubject<Void>()
        let removeFavoriteCryptoTrigger = PublishSubject<IndexPath>()
        
        let _ = viewModel.tranform(input: FavoriteCryptoViewModel.Input(loadTrigger: loadTrigger, removeFavoriteCryptoTrigger: removeFavoriteCryptoTrigger))

        AppDataManager.shared.addFavoriteCrypto(Crypto(icon: "", name: "aaaa", base: "", counter: "", buyPrice: "", sellPrice: ""))
        guard let currentfavoriteCryptoModels = try? AppDataManager.shared.favoriteCrypto.value() else {
            XCTFail()
            return
        }
        XCTAssertTrue(currentfavoriteCryptoModels.count == 1)
        
        // Act
        removeFavoriteCryptoTrigger.onNext(IndexPath(item: 0, section: 0))
        
        // Assert
        guard let favoriteCryptoModels = try? AppDataManager.shared.favoriteCrypto.value() else {
            XCTFail()
            return
        }
        XCTAssertTrue(favoriteCryptoModels.count == 0)
        
    }
}
