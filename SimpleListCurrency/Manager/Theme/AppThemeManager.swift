//
//  AppThemeManager.swift
//  SimpleListCurrency

import Foundation
import SwiftTheme

enum SupportTheme: String, CaseIterable {
    case black = "Black"
    case white = "White"
    
    var value: String {
        switch self {
        case .black: return "Black" //plist
        case .white: return "White"
        }
    }
}

class AppThemeManager {
    static let shared = AppThemeManager()
    
    var currentTheme: SupportTheme  = .white {
        didSet {
            UserDefaults.standard.setValue(currentTheme.rawValue, forKey: "currentTheme")
            ThemeManager.setTheme(plistName: currentTheme.value, path: ThemePath.mainBundle)
        }
    }
    
    init() {
        if let value = UserDefaults.standard.value(forKey: "currentTheme") as? String {
            switch value {
            case "Black": currentTheme = .black
            case "White": currentTheme = .white
            default: break
            }
        }
    }
}
