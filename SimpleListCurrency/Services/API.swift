//
//  API.swift
//  SimpleListCurrency
//

import Foundation
import Moya
import Alamofire

class CrytoEndPointPlugin: PluginType {
}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

let CrytoEndPointProvider = MoyaProvider<CrytoEndPoint>(plugins: [CrytoEndPointPlugin(), NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                                                             logOptions: .verbose))])

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum CrytoEndPoint {
    case crypto(unit: String)

}

extension CrytoEndPoint: TargetType {
    public var baseURL: URL { return URL(string: APPAgentEnpointHost)! }
    public var path: String {
        switch self {
        case .crypto(_): return "/v3/price/all_prices_for_mobile"                    
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .crypto(_): return .get
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .crypto(_): return ["Content-Type": "application/json"]
        }
    }
    public var task: Task {
        switch self {
        case .crypto(let unit):
            return .requestParameters(parameters: ["counter_currency": unit], encoding: URLEncoding.queryString)
        }
    }
    public var validationType: ValidationType {
        return .successCodes
    }
    public var sampleData: Data {
        switch self {
        case .crypto(_):
            return """
{
"data": [
{
"base": "LTC",
"counter": "USD",
"buy_price": "183.102",
"sell_price": "181.803",
"icon": "https://cdn.coinhako.com/assets/wallet-ltc-e4ce25a8fb34c45d40165b6f4eecfbca2729c40c20611acd45ea0dc3ab50f8a6.png",
"name": "Litecoin"
}]
}
""".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
