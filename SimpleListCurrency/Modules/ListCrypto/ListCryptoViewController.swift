//
//  ListCryptoViewController.swift
//  SimpleListCurrency
//

import UIKit
import SwiftTheme
import DropDown
import RxSwift
import RxCocoa

class ListCryptoViewController: BaseViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectThemeButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var allCryptoView: UIView!
    @IBOutlet weak var favoriteCryptoView: FavoriteCryptoView!
    @IBOutlet weak var displayModeSegment: UISegmentedControl!
    
    var presenter: ListCryptoPresenterProtocol!

    var allCrypto: [CrytoModel] = []
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        selectThemeButton.setTitle(AppThemeManager.shared.currentTheme.rawValue, for: .normal)
        tableView.register(UINib(nibName: CryptoPriceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CryptoPriceTableViewCell.identifier)
        presenter.handle(event: .loadCryto)
        
        displayModeSegment.rx.value.subscribe(onNext:{ [weak self] value in
            self?.view.endEditing(true)
            self?.allCryptoView.isHidden = value == 1
            self?.favoriteCryptoView.isHidden = value == 0
        }).disposed(by: disposeBag)
        
        searchTextField.rx.text.throttle(RxTimeInterval.microseconds(250), scheduler: MainScheduler.instance).subscribe(onNext:{ [weak self] text in
            self?.presenter.handle(event: .searchCryptoName(searchText: text ?? ""))
        }).disposed(by: disposeBag)
        
        selectThemeButton.rx.controlEvent(UIControl.Event.touchUpInside).subscribe(onNext:{ [weak self] in
            guard let self = self else { return }
            let dropDown = DropDown()
            dropDown.direction = .bottom
            dropDown.anchorView = self.selectThemeButton
            dropDown.dataSource = SupportTheme.allCases.map({ $0.rawValue })
            dropDown.bottomOffset = CGPoint(x: 0, y: self.selectThemeButton.frame.size.height)
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                AppThemeManager.shared.currentTheme = SupportTheme.allCases[index]
                self?.selectThemeButton.setTitle(AppThemeManager.shared.currentTheme.rawValue, for: .normal)
                dropDown.hide()
            }
            dropDown.show()
        }).disposed(by: disposeBag)
        
        favoriteCryptoView.bindViewModel(viewModel: FavoriteCryptoViewModel())
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        view.theme_backgroundColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.screenBackgroundColor)
        searchTextField.theme_textColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
        displayModeSegment.theme_tintColor = ThemeColorPicker.init(keyPath: AppThemeDefine.global.textColor)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ListCryptoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCrypto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoPriceTableViewCell.identifier) as! CryptoPriceTableViewCell
        cell.indexPath = indexPath
        cell.likeButonAction = { [weak self] cellIndexPath in
            guard let self = self, let cellIndexPath = cellIndexPath else { return }
            self.presenter.handle(event: .addFavoriteCrypto(name: self.allCrypto[cellIndexPath.row].name))
        }
        let issue = allCrypto[indexPath.row]
        cell.configure(model: issue)
        return cell
    }
}

// MARK: - ListCryptoPresenterListenerProtocol
extension ListCryptoViewController: ListCryptoPresenterListenerProtocol {
    func handle(command: ListCryptoPresenterCommand) {
        switch command {
        case .showError(let title, let message):
            self.showAlert(title: title, message: message)
        case .populateList(let cryptos):
            DispatchQueue.main.async { [weak self] in
                self?.allCrypto = cryptos
                self?.tableView.reloadData()
            }
        default: break
        }
    }
}

// MARK: - ScenePresenter
extension ListCryptoViewController: ScenePresenter {
    func present(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - StoryboardInstantiable
extension ListCryptoViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return "Main"
    }
}
