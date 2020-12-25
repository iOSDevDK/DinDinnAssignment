//
//  ApiServices.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

enum ApiServices {
  
    case dindinnFoodDelivery
}

// 2:
extension ApiServices: TargetType {
    
    // 3:
    var baseURL: URL { return URL(string: "https://5319cb64-b939-4f9b-8836-136d105dacdf.mock.pstmn.io")! }
    
    // 4:
    var path: String {
        switch self {
        case .dindinnFoodDelivery:
            return "/dindinnFoodDelivery"
        }
    }
  
    // 5:
    var method: Moya.Method {
        switch self {
        case .dindinnFoodDelivery:
            return .get
        default:
            return .get
        }
    }
    
    // 6:
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
  
    // 7:
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    // 8:
    var sampleData: Data {
        return Data()
    }
    
    // 9:
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

      // 7
      var validationType: ValidationType {
        return .successCodes
      }
}
