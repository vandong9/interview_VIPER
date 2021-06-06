//
//  CrytoModel.swift
//  SimpleListCurrency
//

import Foundation

struct CrytoModel {
    let number: String
    let state: String
    let title: String
    let totalComments: Int
    let authorName: String
    let createdAt: String
    
    
    let icon: String
    let base: String
    let name: String
    let buyPrice: String
    let sellPrice: String
    
    init(cryto: Crypto) {
        number = "cryto.number"
        state = "cryto.state"
        title = "cryto.title"
        totalComments = 12345
        authorName = "cryto.author.login"
        createdAt = "cryto.createdAt?.timeAgoStringFromDate"
        
        icon = cryto.icon
        base = cryto.base
        name = cryto.name
        buyPrice =  String.init(format: "%@ %@",  cryto.buyPrice, cryto.counter)
        sellPrice =  String.init(format: "%@ %@",  cryto.sellPrice, cryto.counter)
    }
}
