//
//  MenuVC.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 24/12/20.
//

import UIKit
import RxSwift
import RxCocoa

class MenuVC: UIViewController {
    @IBOutlet weak var ibcollectionViewMenu : UICollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var ibScrollViewContainer : UIView!
    @IBOutlet weak var ibConstraintContainerHeight : NSLayoutConstraint!
    @IBOutlet weak var ibConstraintContainerTop : NSLayoutConstraint!
    @IBOutlet weak var ibScrollView : UIScrollView!
    @IBOutlet weak var ibHorizontalStackView : UIStackView!
    @IBOutlet weak var ibConstraintibHorizontalStackView : NSLayoutConstraint!
    @IBOutlet weak var ibViewCartItemsCounter : UIView!
    @IBOutlet weak var ibLabelCartItemsCount : UILabel!
    
    var swipeCollectionLeft : UISwipeGestureRecognizer!
    var swipeCollectionRight : UISwipeGestureRecognizer!
    
    var presenter: ViewToPresenterProtocol?
    var yContentOffSet : CGFloat = 0
    
    var arrHeaderTitles : Set<String> = [] {
        didSet {
            print ("arrHeaderTitles = \(arrHeaderTitles)")
            self.pageControl.numberOfPages = arrHeaderTitles.count
            setUpHorizontalButtons()
            ibcollectionViewMenu.reloadData()
        }
    }
    
    var arrayMenuItems: [MenuVCModel] = [] {
      didSet {
        arrHeaderTitles = Set(arrayMenuItems.map{ $0.subCategory! }.sorted(by: <))
      }
    }
    var arrCartItems: [MenuVCModel] = [] {
        willSet {
            if arrCartItems.count == 0 {
                ibViewCartItemsCounter.isHidden = true
            } else {
                ibViewCartItemsCounter.isHidden = false
                ibLabelCartItemsCount.text = "\(arrCartItems.count)"
            }
        }
        didSet {
            if arrCartItems.count == 0 {
                ibViewCartItemsCounter.isHidden = true
            } else {
                ibViewCartItemsCounter.isHidden = false
                ibLabelCartItemsCount.text = "\(arrCartItems.count)"
            }
        }
    }
    
    private let menuVCCollectionViewCellIdentifier = "menuVCCollectionViewCellIdentifier"
    private let segChildPageViewController = "segChildPageViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ibViewCartItemsCounter.isHidden = true
        presenter?.updateView()
    
        
        setUpMenuVCCollectinUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.navigationController?.navigationBar.isHidden = true
    }
   
    func setUpHorizontalButtons() {
        for title in arrHeaderTitles {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.masksToBounds = true
            button.setTitleColor(.systemBlue, for: .normal)
            ibHorizontalStackView.addArrangedSubview(button)
        
        }
        self.view.layoutIfNeeded()
    }
    
    
    func setUpMenuVCCollectinUI() {
        
        pageControl.numberOfPages = 1
        pageControl.isHidden = true
        
        pageControl.addTarget(self, action: #selector(pageChanged(_ :)), for: .valueChanged)
        swipeCollectionLeft = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipedLeft(_:)))
        swipeCollectionLeft.delegate = self
        swipeCollectionLeft.direction = .left
        ibcollectionViewMenu.addGestureRecognizer(swipeCollectionLeft)
        
        swipeCollectionRight = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipedRight(_:)))
        swipeCollectionRight.delegate = self
        swipeCollectionRight.direction = .right
        ibcollectionViewMenu.addGestureRecognizer(swipeCollectionRight)
    }

    @IBAction func buttonCartTapped(sender: UIButton) {
        if arrCartItems.count > 0 {
            self.performSegue(withIdentifier: "segCartVC", sender: arrCartItems)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segCartVC" {
            if let cartView = segue.destination as? CartVC {
                if let cartItems = sender as? [MenuVCModel] {
                    cartView.arrCartItems = cartItems
                }
                cartView.delegate = self
            }
        }
    }
}

extension MenuVC: CartVCToMenuVCProtocol {
    func removeCartItems(items: [MenuVCModel]) {
        if items.count == 0 {
            arrCartItems.removeAll()
        }
    }
}

extension MenuVC: PresenterToViewProtocol {

    func showError() {
        print("error")
    }

    func showMenu(items: [MenuVCModel]) {
        self.arrayMenuItems = items
    }

    func showCartItems(items: [MenuVCModel]) {
        self.arrCartItems = items
    }
}
  
extension MenuVC : UIGestureRecognizerDelegate {
    
    @objc func pageChanged(_ sender: UIPageControl) {
        
        let pageWidth : CGFloat = ibcollectionViewMenu.frame.size.width
        let scrollTo : CGPoint = CGPoint(x: pageWidth * CGFloat(sender.currentPage), y: 0)
        ibcollectionViewMenu.setContentOffset(scrollTo, animated: true)
    }
    
    @IBAction func viewSwipedLeft(_ sender: UISwipeGestureRecognizer) {
        if pageControl.currentPage == 4 {
            pageControl.currentPage = 0
            let pageWidth : CGFloat = ibcollectionViewMenu.frame.size.width
            let scrollTo : CGPoint = CGPoint(x: pageWidth * CGFloat(pageControl.currentPage), y: 0)
            ibcollectionViewMenu.setContentOffset(scrollTo, animated: false)
        }
    }
    
    @IBAction func viewSwipedRight(_ sender: UISwipeGestureRecognizer) {
        if pageControl.currentPage == 0 {
            pageControl.currentPage = 5
            let pageWidth : CGFloat = ibcollectionViewMenu.frame.size.width
            let scrollTo : CGPoint = CGPoint(x: pageWidth * CGFloat(pageControl.currentPage), y: 0)
            ibcollectionViewMenu.setContentOffset(scrollTo, animated: false)
        }
    }
}

extension MenuVC: UICollectionViewDataSource, UIScrollViewDelegate {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHeaderTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuVCCollectionViewCellIdentifier", for: indexPath) as! MenuVCCollectionViewCell
        
        cell.menudelegate = self
        cell.arrTitle = Array(arrHeaderTitles)
        cell.arrItems = arrayMenuItems
        cell.yContentOffSet = 0 //-ibConstraintContainerTop.constant
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if pageControl.isHidden == false {
            
            var visibleRect = CGRect()
            visibleRect.origin = ibcollectionViewMenu.contentOffset
            visibleRect.size = ibcollectionViewMenu.bounds.size
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            let visibleIndexPath: IndexPath? = ibcollectionViewMenu.indexPathForItem(at: visiblePoint)
            pageControl.currentPage = visibleIndexPath!.item
            
        }
        for cell in ibcollectionViewMenu.visibleCells {
            if let indexPath = ibcollectionViewMenu.indexPath(for: cell) {
                if let currentCell = cell as? MenuVCCollectionViewCell {
                    currentCell.idxMainCell = indexPath.item
                }
//                pageControl.currentPage = indexPath.item
//                ibcollectionViewMenu.reloadData()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //print("decelerate = ",decelerate)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        
    }
    
}

extension MenuVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ibcollectionViewMenu.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MenuVC: MenuDelegate {
    
    func displaySelectedMenuInfo(response: Any, idx : Int) {
                
    }
    
    func menuContentOffSet(yPos: CGFloat) {
        //print("ibConstraintContainerTop.constant = ",ibConstraintContainerHeight.constant)
        //print("yPos = ",yPos)
        if yPos <= 330 {
            ibConstraintContainerTop.constant = -yPos
            //print(ibcollectionViewMenu.frame.size.height)
            self.view.layoutIfNeeded()
        }
        ibcollectionViewMenu.reloadData()
        
    }
    
    func addItemToCart(selectedMenuItem: MenuVCModel) {
        arrCartItems.append(selectedMenuItem)
    }
}
