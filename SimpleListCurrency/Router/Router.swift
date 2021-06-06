//
//  Router.swift
//  SimpleListCurrency
//

import Foundation
import UIKit

protocol ScenePresenter: class {
    func present(viewController: UIViewController)
}

class Router {
    static var shared = Router()

    private init() {}

    func launch(window: UIWindow, scene: Scene) {
        let viewController = scene.configure()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

