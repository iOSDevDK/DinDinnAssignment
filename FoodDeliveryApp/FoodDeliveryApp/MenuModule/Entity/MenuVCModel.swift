//
//  MenuVCModel.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import Foundation
import ObjectMapper

class MenuItemResponse: Mappable {
    
    var success: Bool?
    var menuItems: [MenuVCModel]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        success         <- map["success"]
        menuItems       <- map["data"]
    }
}


enum Category {
    case drinks
    case food
}

class MenuVCModel: Mappable {
    
    var name, category, subCategory: String?
    var price: Double?
    var imageURL: String?
    var description: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name            <- map["name"]
        category        <- map["Category"]
        subCategory     <- map["Sub-Category"]
        price           <- map["price"]
        imageURL        <- map["image-url"]
        description     <- map["description"]
        
    }
    
    
}
