//
//  MenuVCPresenter.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import Foundation

final class MenuVCPresenter: ViewToPresenterProtocol {

    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchMenuItems()
    }
    
}

extension MenuVCPresenter: InteractorToPresenterProtocol {
    

    func fetchMenu(items: [MenuVCModel]) {
        view?.showMenu(items: items)
    }
    
    func fetchMenuItemsFailed() {
        view?.showError()
    }
    
    
}
