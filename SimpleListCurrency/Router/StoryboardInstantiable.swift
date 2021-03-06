//
//  StoryboardInstantiable.swift
//  SimpleListCurrency
//

import Foundation
import UIKit

protocol StoryboardInstantiable {
    static var storyboardId: String { get }
    static var storyboardName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static var storyboardInstance: Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
        return viewController as! Self
    }
    static var storyboardId: String {
        return NSStringFromClass(self).components(separatedBy:(".")).last!
    }
}
