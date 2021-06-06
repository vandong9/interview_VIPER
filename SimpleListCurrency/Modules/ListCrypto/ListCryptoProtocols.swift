//
//  ListCryptoProtocols.swift
//  SimpleListCurrency
//

import Foundation

enum ShowingListMode {
    case listAll
    case listFavorite
}

enum ListCryptoViewEvent: ViewEvent {
    case loadCryto
    case searchCryptoName(searchText: String)
    case addFavoriteCrypto(name: String)
}

enum ListCryptoPresenterCommand: PresenterCommand {
    case showError(title: String, message: String)
    case populateList(cryptos: [CrytoModel])
    case fetchedToEnd
}

enum ListCryptotInteractorRequest: InteractorRequest {
    case fetchCryto
}

enum ListCryptoInteractorResponse: InteractorResponse {
    case didFetchCrypto(result: Result<[Crypto], Error>)
}

protocol ListCryptoInteractorListenerProtocol: class {
    func handle(response: ListCryptoInteractorResponse)
}

protocol ListCryptoInteractorProtocol: class {
    var responseListener: ListCryptoInteractorListenerProtocol? { get set }
    func handle(request: ListCryptotInteractorRequest)
}

protocol ListCryptoPresenterListenerProtocol: class {
    func handle(command: ListCryptoPresenterCommand)
}

protocol ListCryptoPresenterProtocol: class {
    var interactor: ListCryptoInteractorProtocol { get }
    var commandListener: ListCryptoPresenterListenerProtocol? { get set }
    func handle(event: ListCryptoViewEvent)
}
