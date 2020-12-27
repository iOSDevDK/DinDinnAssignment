//
//  CartVCProtocols.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 26/12/20.
//

import Foundation
import UIKit

protocol CartPresenterToViewProtocol: class {
    func showMenu(items: [MenuVCModel])
    func showError()
}

protocol CartInteractorToPresenterProtocol: class {
    func fetchMenu(items: [MenuVCModel])
    func fetchMenuItemsFailed()
}

protocol CartPresenterToInteractorProtocol: class {
    var presenter: CartInteractorToPresenterProtocol? { get set }
    func fetchMenuItems()
}

protocol CartViewToPresenterProtocol: class {
    var view: CartPresenterToViewProtocol? { get set }
    var interactor: CartPresenterToInteractorProtocol? { get set }
    var router: CartPresenterToRouterProtocol? { get set }
    func updateCartView()
}

protocol CartPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}

protocol CartItemToCartVCProtocol {
    func removeMenuItemfromCart(menuItemIdx: Int)
}

protocol CartVCToMenuVCProtocol {
    func removeCartItems(items: [MenuVCModel])
}
