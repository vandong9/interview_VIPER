//
//  FavoriteCryptoView.swift
//  SimpleListCurrency
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SwiftTheme

class FavoriteCryptoView: UIView {
    // MARK: - Properties
    var tableView: UITableView!
    
    var allCrypto: [CrytoModel] = []
    var viewModel: FavoriteCryptoViewModel!
    private let disposeBag = DisposeBag()
    let removeFavoriteCryptoSubject = PublishSubject<IndexPath>()
    
    // MARK: - LifeCyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        theme_backgroundColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.screenBackgroundColor)

        tableView = UITableView()
        tableView.theme_backgroundColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.screenBackgroundColor)

        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.register(UINib(nibName: CryptoPriceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CryptoPriceTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
        
    func bindViewModel(viewModel: FavoriteCryptoViewModel) {
        self.viewModel = viewModel
        let loadTrigger = PublishSubject<Void>()
        let output = viewModel.tranform(input: FavoriteCryptoViewModel.Input(loadTrigger: loadTrigger, removeFavoriteCryptoTrigger: removeFavoriteCryptoSubject))
        
        output.populateList.subscribe(onNext:{ [weak self] value in
            DispatchQueue.main.async { [weak self] in
                self?.allCrypto = value
                self?.tableView.reloadData()

            }
        }).disposed(by: disposeBag)
        
        loadTrigger.onNext(Void())
    }
}

extension FavoriteCryptoView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCrypto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoPriceTableViewCell.identifier) as! CryptoPriceTableViewCell
        cell.indexPath = indexPath
        cell.likeButonAction = { [weak self] cellIndexPath in
            guard let cellIndexPath = cellIndexPath else { return }
            self?.removeFavoriteCryptoSubject.onNext(cellIndexPath)
        }

        let issue = allCrypto[indexPath.row]
        cell.configure(model: issue)
        cell.setLike(isLike: true)
        return cell
    }

}

