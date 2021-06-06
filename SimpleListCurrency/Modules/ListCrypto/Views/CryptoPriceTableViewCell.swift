//
//  CryptoPriceTableViewCell.swift
//  SimpleListCurrency
//

import UIKit
import SwiftTheme
import RxSwift
import RxCocoa

class CryptoPriceTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleBuyLabel: UILabel!
    @IBOutlet weak var titleSellLabel: UILabel!
    @IBOutlet weak var buyPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var horizolLineView: UIView!
    @IBOutlet weak var vertialLineView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    
    static let identifier = "CryptoPriceTableViewCell"
    let disposeBag = DisposeBag()
    var indexPath: IndexPath?
    
    var likeButonAction: ((IndexPath?)->Void)?
    
    // MARK: - LiceCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        theme_backgroundColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.tableCellBackgroundColor)
        horizolLineView.theme_backgroundColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        vertialLineView.theme_backgroundColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        baseLabel.theme_textColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        nameLabel.theme_textColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        buyPriceLabel.theme_textColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        sellPriceLabel.theme_textColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        titleBuyLabel.theme_textColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        titleSellLabel.theme_textColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        likeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.likeButonAction?(self.indexPath)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Functions
    func configure(model: CrytoModel) {
        iconImageView.setImage(url: model.icon)
        baseLabel.text = model.base
        nameLabel.text = model.name
        buyPriceLabel.text = model.buyPrice
        sellPriceLabel.text = model.sellPrice
    }
    
    func setLike(isLike: Bool) {
        likeButton.isSelected = isLike
    }
}
