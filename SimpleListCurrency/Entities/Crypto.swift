//
//  Crypto.swift
//  SimpleListCurrency
//

import Foundation

struct Crypto: Codable {
    var icon: String
    var name: String
    var base: String
    var counter: String
    var buyPrice: String
    var sellPrice: String
    
    private enum CodingKeys: String, CodingKey {
        case icon
        case name
        case base
        case counter
        case buyPrice = "buy_price"
        case sellPrice = "sell_price"
    }

}
