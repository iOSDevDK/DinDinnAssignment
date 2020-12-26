//
//  MenuVCCollectionViewCell.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import UIKit

protocol MenuDelegate {
    func displaySelectedMenuInfo(response: Any, idx : Int)
    func menuContentOffSet(yPos : CGFloat)
    func addItemToCart(selectedMenuItem : MenuVCModel)
    
}

extension MenuDelegate {
    
    func displaySelectedMenuInfo(response: Any, idx : Int) {
        
    }

}

class MenuVCCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupViews()
        }
        
        var menudelegate : MenuDelegate?
    
        var idxMainCell = 0 {
            didSet {
                arrItems = arrItems.filter{ $0.subCategory == arrTitle[idxMainCell] }
                menuItemCollectionView.reloadData()
            }
        }
    
    var yContentOffSet : CGFloat = 0
    
        var arrTitle = [String]()
        var arrItems : [MenuVCModel] = []
        
        let menuItemCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
            collectionView.backgroundColor = UIColor.clear
            collectionView.showsVerticalScrollIndicator = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false

            return collectionView
        }()
        
        
        func setupViews() {
            backgroundColor = UIColor.clear
            addSubview(menuItemCollectionView)

            let nibPrefCell = UINib(nibName: "MenuItemCell", bundle: nil)
            menuItemCollectionView.register(nibPrefCell, forCellWithReuseIdentifier: "MenuItemCell")

            menuItemCollectionView.dataSource = self
            menuItemCollectionView.delegate = self
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": menuItemCollectionView]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": menuItemCollectionView]))
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrItems.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! VerticalCell
            cell.delegate = self
            cell.menuItem = arrItems[indexPath.row]
            cell.setUpCell()
            
            return cell
        }
        
        func longPressedCell(_ sender: UILongPressGestureRecognizer) {
            if menudelegate != nil {
                let point = sender.location(in: self.menuItemCollectionView)
                let indexPath = self.menuItemCollectionView.indexPathForItem(at: point)
                
                if let index = indexPath {
                    _ = self.menuItemCollectionView.cellForItem(at: index)
                    // do stuff with your cell, for example print the indexPath
                    print(index.row)
                    
                } else {
                    print("Could not find index path")
                }
                
                
            }
        }
        
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (UIScreen.main.bounds.size.width), height: 426)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if menudelegate != nil {
                
            }
        }
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            //print("menuItemCollectionView.contentOffset.y = ",menuItemCollectionView.contentOffset.y)
            yContentOffSet = menuItemCollectionView.contentOffset.y
            menudelegate?.menuContentOffSet(yPos: menuItemCollectionView.contentOffset.y)
        }
    
}

extension MenuVCCollectionViewCell: MenuItemToMenuControllerProtocol {
    func menuItemAddtoCard(menuItem: MenuVCModel) {
        menudelegate?.addItemToCart(selectedMenuItem: menuItem)
    }
    
    
    
}
