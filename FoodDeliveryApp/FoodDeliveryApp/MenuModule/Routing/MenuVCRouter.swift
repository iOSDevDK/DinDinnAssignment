//
//  MenuVCRouter.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import Foundation
import UIKit

class MenuVCRouter: PresenterToRouterProtocol {
    var viewController: UIViewController?
    
    class func createModule() -> UIViewController {
        guard let view = mainStoryboard.instantiateViewController(identifier: "MenuVC") as? MenuVC else {
            return UIViewController()
        }
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MenuVCPresenter()
        let interactor: PresenterToInteractorProtocol = MenuVCInteractor()
        let router: PresenterToRouterProtocol = MenuVCRouter()
        
        view.presenter = presenter
        presenter.view = view as? PresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func displayCartView() {
        let cartVC = CartVCRouter.createModule()
          
          viewController?.navigationController?.pushViewController(cartVC, animated: true)
    }
}
