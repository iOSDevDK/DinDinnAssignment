//
//  NetworkAdapter.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import Foundation
import Moya

struct NetworkAdapter {
    static let provider = MoyaProvider<ApiServices>()
    
    static func request(target: ApiServices, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                // 1:
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                   // 2:
                   let error = NSError(domain:"com.vsemenchenko.networkLayer", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                // 3:
                failureCallback(error)
            }
        }
    }
}
