//
//  CartVC.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import UIKit

class CartVC: UIViewController {

    var presenter: CartViewToPresenterProtocol?
    var arrCartItems : [MenuVCModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.updateCartView()
        print("arrCartItems = \(arrCartItems)")
        self.navigationController?.navigationBar.isHidden = false

    }
    

}
