//
//  MenuVCProtocols.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import Foundation
import UIKit

protocol PresenterToViewProtocol: class {
    func showMenu(items: [MenuVCModel])
    func showError()
}

protocol InteractorToPresenterProtocol: class {
    func fetchMenu(items: [MenuVCModel])
    func fetchMenuItemsFailed()
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetchMenuItems()

}

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    
    func updateView()
}

protocol PresenterToRouterProtocol: class {

    static func createModule() -> UIViewController
}

protocol MenuItemToMenuControllerProtocol {
    func menuItemAddtoCard(menuItem: MenuVCModel)
}
