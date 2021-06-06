//
//  BaseViewController.swift
//  SimpleListCurrency
//


import Foundation
import UIKit

class BaseViewController: UIViewController {
    func showAlert(title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }
}
