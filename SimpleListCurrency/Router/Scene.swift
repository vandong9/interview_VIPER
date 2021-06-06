//
//  Scene.swift
//  SimpleListCurrency
//

import Foundation
import UIKit

enum Scene {
    case favoriteCryo
    case allCryto
//    case issueDetail(id: String)

    func configure() -> UIViewController {
        switch self {
        case .allCryto:
            return allCryto()
        case .favoriteCryo:
            return favoriteCryo()
        }
    }

    func allCryto() -> UIViewController {
        let ListCryptoVC = ListCryptoViewController.storyboardInstance
        let interactor = ListCryptoInteractor()
        let presenter = ListCryptoPresenter(interactor: interactor)
        interactor.responseListener = presenter
        presenter.commandListener = ListCryptoVC
        ListCryptoVC.presenter = presenter
        return ListCryptoVC
    }

    func favoriteCryo() -> UIViewController {
        let ListCryptoVC = ListCryptoViewController.storyboardInstance
        let interactor = ListCryptoInteractor()
        let presenter = ListCryptoPresenter(interactor: interactor)
        interactor.responseListener = presenter
        presenter.commandListener = ListCryptoVC
        ListCryptoVC.presenter = presenter
        return ListCryptoVC
    }
    
//    func configureIssueDetail(issueId: String) -> UIViewController {
//        
//    }

//    func configureRestaurantList() -> UINavigationController {
//        let restaurantListVC = RestaurantListViewController.storyboardInstance
//        let interactor = RestaurantListInteractor()
//        let presenter = RestaurantListPresenter(interactor: interactor)
//        interactor.responseListener = presenter
//        presenter.scenePresenter = restaurantListVC
//        presenter.commandListener = restaurantListVC
//        restaurantListVC.presenter = presenter
//        let navigationController = UINavigationController(rootViewController: restaurantListVC)
//        return navigationController
//    }
//
//    func configureLogin(detailId: String) -> LoginViewController {
//        let LoginVC = LoginViewController.storyboardInstance
//        let interactor = LoginInteractor()
//        let presenter = LoginPresenter(detailId: detailId, interactor: interactor)
//        interactor.responseListener = presenter
//        presenter.commandListener = LoginVC
//        LoginVC.presenter = presenter
//        return LoginVC
//    }
}

