//
//  CartVCPresenter.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import Foundation

final class CartVCPresenter: CartViewToPresenterProtocol {
    
    var view: CartPresenterToViewProtocol?
    var interactor: CartPresenterToInteractorProtocol?
    var router: CartPresenterToRouterProtocol?
    
    func updateCartView() {
        interactor?.fetchMenuItems()
    }
    
}

extension CartVCPresenter: CartInteractorToPresenterProtocol {
    
    func fetchMenu(items: [MenuVCModel]) {
        view?.showMenu(items: items)
    }
    
    func fetchMenuItemsFailed() {
        view?.showError()
    }
}
