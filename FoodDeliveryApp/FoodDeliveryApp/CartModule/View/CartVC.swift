//
//  CartVC.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var ibCartTableView : UITableView!
    @IBOutlet weak var ibViewTableHeader : UIView!
    @IBOutlet weak var ibViewTableFooter : UIView!
    @IBOutlet weak var ibLabelTotalCost : UILabel!
    
    var presenter: CartViewToPresenterProtocol?
    var delegate: CartVCToMenuVCProtocol?
    
    var arrCartItems : [MenuVCModel] = [] {
        didSet {
            print(arrCartItems.count)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.updateCartView()
        print("arrCartItems = \(arrCartItems)")
        self.navigationController?.navigationBar.isHidden = false

        self.ibViewTableHeader.backgroundColor = .systemTeal
        self.ibCartTableView.reloadData()
        
        let itemsCost = arrCartItems.map{ $0.price! }.reduce(0, +)
        ibLabelTotalCost.text = "Value: \(itemsCost) USD"

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(tappedBackNavBarButton))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func tappedBackNavBarButton() {
        delegate?.removeCartItems(items: arrCartItems)
        self.navigationController?.popViewController(animated: true)
    }
}

extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell") as! CartViewCell
        cell.menuItem = arrCartItems[indexPath.item]
        cell.delegate = self
        cell.ibButtonRemoveMenuItem.tag = indexPath.row
        cell.setUpCell()
        return cell
    }
}

extension CartVC : CartItemToCartVCProtocol {
    
    func removeMenuItemfromCart(menuItemIdx: Int) {
        arrCartItems.remove(at: menuItemIdx)
        ibCartTableView.reloadData()
        
        if arrCartItems.count == 0 {
            ibViewTableFooter.isHidden = true
        } else {
            ibViewTableFooter.isHidden = false
        }
        let itemsCost = arrCartItems.map{ $0.price! }.reduce(0, +)
        ibLabelTotalCost.text = "Value: \(itemsCost) USD"

    }
    
    
}
