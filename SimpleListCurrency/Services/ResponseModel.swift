//
//  ResponseModel.swift
//  SimpleListCurrency
//

import Foundation
import UIKit

/***
    Response Model is evelop for reponse,  parse general reponse of RestAPI
    This should update base on rule of Backend API
 */
 
class ResponseModel<T: Any & Codable>: Codable {
    var data: T?
    var error: String?
    var errorMsg: String?
    var version: String?
    
    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        
         do {
           let d = try map.decode(T.self, forKey: .data)
            data = d
        } catch {
            debugPrint("Parse Codable error:")
            debugPrint(error)
        }
        
        self.error = try? map.decode(String.self, forKey: .error)
        self.errorMsg = try? map.decode(String.self, forKey: .errorMsg)
        self.version = try? map.decode(String.self, forKey: .version)
    }
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
        case error = "error"
        case errorMsg = "error_msg"
        case version = "version"
    }
}

