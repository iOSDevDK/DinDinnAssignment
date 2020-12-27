//
//  CartViewCell.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 26/12/20.
//

import UIKit

class CartViewCell: UITableViewCell {

    @IBOutlet weak var ibImageViewMenuItem: UIImageView!
    @IBOutlet weak var ibLabelMenuItemName: UILabel!
    @IBOutlet weak var ibLabelMenuItemPrice: UILabel!
    @IBOutlet weak var ibButtonRemoveMenuItem: UIButton!
    
    var menuItem : MenuVCModel?
    var delegate: CartItemToCartVCProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell() {
        
        if let item = menuItem {
                self.ibLabelMenuItemName.text = item.name
                self.ibLabelMenuItemPrice.text = "\(String(describing: item.price!)) USD"
                self.ibImageViewMenuItem.sd_setImage(with: URL(string: item.imageURL!), completed: nil)
        }
    }

    @IBAction func btnRemoveMenuItemTapped(sender: UIButton) {
        
        delegate?.removeMenuItemfromCart(menuItemIdx: sender.tag)
    }
}
