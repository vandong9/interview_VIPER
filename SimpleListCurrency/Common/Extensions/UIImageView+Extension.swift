//
//  UIImageView+Extension.swift
//  SimpleListCurrency
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(url: String) {
        self.sd_setImage(with: URL(string: url), completed: nil)
    }
}
