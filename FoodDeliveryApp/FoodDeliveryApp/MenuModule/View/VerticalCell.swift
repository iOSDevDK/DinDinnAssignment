//
//  VerticalCell.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import UIKit
import SDWebImage

class VerticalCell: UICollectionViewCell {
    
    @IBOutlet weak var ibViewBorderWithShadow: UIView!
    @IBOutlet weak var ibImageViewMenuItem: UIImageView!
    @IBOutlet weak var ibLabelMenuItemName: UILabel!
    @IBOutlet weak var ibTextViewMenuItemDescription: UITextView!
    @IBOutlet weak var ibLabelMenuItemWeightandSize: UILabel!
    @IBOutlet weak var ibButtonMenuItemPrice: UIButton!
    
    var menuItem : MenuVCModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        if let item = menuItem {
                self.ibLabelMenuItemName.text = item.name
                self.ibTextViewMenuItemDescription.text = item.description!
                self.ibButtonMenuItemPrice.setTitle("\(String(describing: item.price!)) USD", for: .normal)
                self.ibLabelMenuItemWeightandSize.text = "200 grams, 8 Slices"
                self.ibImageViewMenuItem.sd_setImage(with: URL(string: item.imageURL!), completed: nil)
            
        }
    }
}

