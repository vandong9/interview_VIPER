//
//  ListCryptoInteracter.swift
//  SimpleListCurrency
//

import Foundation

class ListCryptoInteractor {
    private var baseApiClient = CrytoEndPointProvider
    private weak var listener: ListCryptoInteractorListenerProtocol?
}

extension ListCryptoInteractor: ListCryptoInteractorProtocol {
    var responseListener: ListCryptoInteractorListenerProtocol? {
        get {
            return listener
        }
        set {
            listener = newValue
        }
    }
    
    func handle(request: ListCryptotInteractorRequest) {
        switch request {
        case .fetchCryto:
            CrytoEndPointProvider.request(.crypto(unit: "USD")) { [weak self] result in
                switch result {
                case .success(let res):
                    let decode = try? JSONDecoder().decode(ResponseModel<[Crypto]>.self, from: res.data)
                    let crytos = decode?.data
                    self?.listener?.handle(response: .didFetchCrypto(result: .success(crytos ?? [])))
                case .failure(let error):
                    self?.listener?.handle(response: .didFetchCrypto(result: .failure(error)))
                }
            }
        }
    }
}
