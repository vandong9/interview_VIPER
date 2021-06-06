//
//  FavoriteCryptoViewModel.swift
//  SimpleListCurrency
//


import UIKit
import RxSwift

class FavoriteCryptoViewModel {
    struct Input {
        var loadTrigger: PublishSubject<Void>
        var removeFavoriteCryptoTrigger: PublishSubject<IndexPath>
    }
    
    struct Output {
        let populateList: PublishSubject<[CrytoModel]>
    }
    
    private let disposeBag = DisposeBag()
    let favoriteCrypto = BehaviorSubject<[Crypto]>(value: [])

    func tranform(input: Input) -> Output{
        let listCrytoModel = PublishSubject<[CrytoModel]>()
        input.loadTrigger.subscribe(onNext:{ [weak self] in            
            self?.favoriteCrypto.onNext( (try? AppDataManager.shared.favoriteCrypto.value()) ?? [])
        }).disposed(by: disposeBag)
        
        input.removeFavoriteCryptoTrigger.subscribe(onNext:{ [weak self] indexPath in
            if let favoriteCryptos = try? self?.favoriteCrypto.value() {
                AppDataManager.shared.removeFavoriteCrypto(favoriteCryptos[indexPath.row])                
            }
        }).disposed(by: disposeBag)
        AppDataManager.shared.favoriteCrypto.subscribe(onNext:{ [weak self] value in
            self?.favoriteCrypto.onNext(value)
        }).disposed(by: disposeBag)
        favoriteCrypto.subscribe(onNext:{
            listCrytoModel.onNext($0.map({ CrytoModel(cryto: $0)}))
        }).disposed(by: disposeBag)
        
        return Output(populateList: listCrytoModel)
    }
    
}
