//
//  CartVCRouter.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 26/12/20.
//

import Foundation
import UIKit

class CartVCRouter: CartPresenterToRouterProtocol {
    
    class func createModule() -> UIViewController {
        guard let view = mainStoryboard.instantiateViewController(identifier: "CartVC") as? CartVC else {
            return UIViewController()
        }
        
        let presenter: CartViewToPresenterProtocol & CartInteractorToPresenterProtocol = CartVCPresenter()
        let interactor: CartPresenterToInteractorProtocol = CartVCInteractor()
        let router: CartPresenterToRouterProtocol = CartVCRouter()
        
        view.presenter = presenter
        presenter.view = view as? CartPresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
