//
//  AppDataManager.swift
//  SimpleListCurrency
//


import Foundation
import RxSwift

class AppDataManager {
    static let shared = AppDataManager()
    
    let favoriteCrypto = BehaviorSubject<[Crypto]>(value: [])
    private let disposeBag = DisposeBag()
    private let kFavoriteCrypto = "kFavoriteCrypto"
    
    func addFavoriteCrypto(_ crypto: Crypto) {
        var cryptos = (try? favoriteCrypto.value()) ?? []
        cryptos.append(crypto)
        favoriteCrypto.onNext(cryptos)
    }

    func removeFavoriteCrypto(_ crypto: Crypto) {
        var cryptos = (try? favoriteCrypto.value()) ?? []
        cryptos.removeAll { $0.name == crypto.name }
        favoriteCrypto.onNext(cryptos)
    }
}
