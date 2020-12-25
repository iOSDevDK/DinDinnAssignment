//
//  MenuVCCollectionViewCell.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import UIKit

protocol MenuDelegate {
    func displaySelectedMenuInfo(response: Any, idx : Int)
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
        var idxMainCell = 0
        var arrTitle = [String]()
        var arrImages = [#imageLiteral(resourceName: "img_Languages")]
        
        let appsCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical //.horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
            collectionView.backgroundColor = UIColor.clear
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            return collectionView
        }()
        
        
        func setupViews() {
            backgroundColor = UIColor.clear
            addSubview(appsCollectionView)
            
            appsCollectionView.dataSource = self
            appsCollectionView.delegate = self
            
            appsCollectionView.register(VerticalCell.self, forCellWithReuseIdentifier: "VerticalCell")
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrTitle.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell", for: indexPath) as! VerticalCell
            

            let dictCellData = arrTitle[indexPath.row]
            //cell.lblTitle.text = getValueFrmDict(dictReplace: dictCellData as! [String : AnyObject], key: "vSubject")
            //let urlString = getValueFrmDict(dictReplace: dictCellData as! [String : AnyObject], key: "vImage")
            
//            if let url = URL(string: urlString ) {
//                cell.vwImgCellIcon.contentMode = .scaleAspectFit
//                cell.vwImgCellIcon.sd_setImage(with: url) { (image, error, imageCacheType, imageUrl) in
//                    if image != nil {
//                        //print("image found")
//                    } else {
//                    }
//                }
//            } else {
//            }
            
            /*
            if getDefaults(strKey: kRegCategory) != kLongue {
                let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressedCell(_:)))
                longPress.view?.tag = Int(indexPath.item)
                longPress.minimumPressDuration = 1.0
                cell.addGestureRecognizer(longPress)
            }*/
            
            return cell
        }
        
        func longPressedCell(_ sender: UILongPressGestureRecognizer) {
            if menudelegate != nil {
                let point = sender.location(in: self.appsCollectionView)
                let indexPath = self.appsCollectionView.indexPathForItem(at: point)
                
                if let index = indexPath {
                    _ = self.appsCollectionView.cellForItem(at: index)
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
            return CGSize(width: (UIScreen.main.bounds.size.width/2.0 - 40), height: (UIScreen.main.bounds.size.width/2.0 - 40))
        }
        
        func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 20, left: UIScreen.main.bounds.size.width/2.0 - (UIScreen.main.bounds.size.width/2.0 - 20), bottom: 0, right: UIScreen.main.bounds.size.width/2.0 - (UIScreen.main.bounds.size.width/2.0 - 20))
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if menudelegate != nil {
                
            }
        }
    }
