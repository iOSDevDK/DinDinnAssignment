//
//  CartVC.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import UIKit

class CartVC: UIViewController {

    var presenter: CartViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.updateView()
    }
    

}
