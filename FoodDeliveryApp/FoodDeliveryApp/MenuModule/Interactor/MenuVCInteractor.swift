//
//  MenuVCInteractor.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import Foundation
import ObjectMapper

class MenuVCInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    func fetchMenuItems() {
        NetworkAdapter.request(target: .dindinnFoodDelivery) { responseData in
            do {
                //print(try responseData.mapJSON())
                let dataMenuItemResponse = try MenuItemResponse(JSON: responseData.mapJSON() as! [String : Any])

                if let menuItems = dataMenuItemResponse!.menuItems {
                    self.presenter?.fetchMenu(items: menuItems as [MenuVCModel])
                }
                
            } catch let error {
                // can't parse data, show error
                print("catch error -> ",error)
            }
        } error: { error in
            print("error -> ",error)
            self.presenter?.fetchMenuItemsFailed()
        } failure: { moyaError in
            print("moyaError -> ",moyaError)
        }

    }
    
    func addToCart(menu item: MenuVCModel) {
        
    }
    
    func displayCartView(menuItems: MenuVCModel) {
        
    }
}


