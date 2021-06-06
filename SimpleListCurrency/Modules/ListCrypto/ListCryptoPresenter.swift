//
//  ListCryptoPresenter.swift
//  SimpleListCurrency
//

import Foundation

class ListCryptoPresenter {
    // MARK: - Properties
    let ListCryptoInteractor: ListCryptoInteractorProtocol
    weak var ListCryptoViewController: ListCryptoPresenterListenerProtocol? = nil
    weak var scenePresenter: ScenePresenter? = nil

    var allCrypto: [Crypto] = []
    
    // MARK: - LifeCycle
    init(interactor: ListCryptoInteractorProtocol) {
        self.ListCryptoInteractor = interactor
    }
}

// MARK: - LifeCycle
extension ListCryptoPresenter: ListCryptoPresenterProtocol {
    var interactor: ListCryptoInteractorProtocol {
        return self.ListCryptoInteractor
    }

    var commandListener: ListCryptoPresenterListenerProtocol? {
        get {
            return self.ListCryptoViewController
        }
        set {
            self.ListCryptoViewController = newValue
        }
    }

    func handle(event: ListCryptoViewEvent) {
        switch event {
        case .loadCryto: interactor.handle(request: .fetchCryto)
        case .searchCryptoName(searchText: let text):
            var result: [Crypto] = allCrypto
            if text.count > 0 {
                 result = allCrypto.filter { $0.name.contains(text) }
            }
            ListCryptoViewController?.handle(command: .populateList(cryptos: result.map{ return CrytoModel(cryto: $0)
            }))
        case .addFavoriteCrypto(name: let name):
            if let crypto = allCrypto.first(where: { $0.name == name }) {
                AppDataManager.shared.addFavoriteCrypto(crypto)
            }
        default: break
        }
    }
}

// MARK: - LifeCycle
extension ListCryptoPresenter: ListCryptoInteractorListenerProtocol {
    func handle(response: ListCryptoInteractorResponse) {
        switch response {
        case .didFetchCrypto(let result):
            self.handleViewerInfoReceived(result: result)
        }
    }
    
    private func handleViewerInfoReceived(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let criptos):
            self.allCrypto = criptos
            ListCryptoViewController?.handle(command: .populateList(cryptos: criptos.map{ return CrytoModel(cryto: $0)
            }))
        case .failure(let error):
            ListCryptoViewController?.handle(command: .showError(title: "Error", message: error.localizedDescription))
        }
    }
}

