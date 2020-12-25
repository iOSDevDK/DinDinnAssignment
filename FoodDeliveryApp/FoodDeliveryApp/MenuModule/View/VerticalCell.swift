//
//  VerticalCell.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import UIKit

class VerticalCell: UICollectionViewCell {
    
    var lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var vwImgBgCell: UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        return imgVw
    }()
    
    var vwImgCellIcon: UIImageView = {
        let imgVw = UIImageView()
        imgVw.backgroundColor = .clear
        imgVw.contentMode = .scaleAspectFit
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        return imgVw
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(vwImgBgCell)
        addSubview(vwImgCellIcon)
        addSubview(lblTitle)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem:  vwImgBgCell, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem:  vwImgBgCell, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem:  vwImgBgCell, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem:  vwImgBgCell, attribute: .bottom, multiplier: 1, constant: 0))

        
        addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem:  lblTitle, attribute: .top, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem:  lblTitle, attribute: .leading, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem:  lblTitle, attribute: .trailing, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem:  lblTitle, attribute: .centerX, multiplier: 1, constant: 0))
        //addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem:  lblTitle, attribute: .centerY, multiplier: 1, constant: 0))
        

        addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem:  vwImgCellIcon, attribute: .centerX, multiplier: 1, constant: 0))
        if UIScreen.main.bounds.size.height <= 568 {
            addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem:  vwImgCellIcon, attribute: .width, multiplier: 2, constant: 0))
            addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem:  vwImgCellIcon, attribute: .height, multiplier: 2, constant: 0))
            addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem:  vwImgCellIcon, attribute: .bottom, multiplier: 1, constant: 10))
        } else {
            addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem:  vwImgCellIcon, attribute: .width, multiplier: 2, constant: 0))
            addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem:  vwImgCellIcon, attribute: .height, multiplier: 2, constant: 0))
            addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem:  vwImgCellIcon, attribute: .centerY, multiplier: 1, constant: -10))
        }



    
    }
}

