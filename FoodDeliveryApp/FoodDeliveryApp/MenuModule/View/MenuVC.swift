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
    
    var swipeCollectionLeft : UISwipeGestureRecognizer!
    var swipeCollectionRight : UISwipeGestureRecognizer!
    
    var presenter: ViewToPresenterProtocol?
    var arrHeaderTitles : Set<String> = [] {
        didSet {
            print ("arrHeaderTitles = \(arrHeaderTitles)")
            print("number of pages = ",arrHeaderTitles.count)
            self.pageControl.numberOfPages = arrHeaderTitles.count
        }
    }
    
    var arrayMenuItems: [MenuVCModel] = [] {
      didSet {
//        print("arrayMenuItems => ",arrayMenuItems)
        
        arrHeaderTitles = Set(arrayMenuItems.map{ $0.subCategory! }.reversed())
        //ibcollectionViewMenu.reloadData()
      }
    }
    
    private let menuVCCollectionViewCellIdentifier = "menuVCCollectionViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.updateView()
        self.navigationController?.navigationBar.isHidden = true
        
        setUpMenuVCCollectinUI()
        
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

    
}

extension MenuVC: PresenterToViewProtocol {

    func showError() {
        print("error")
    }

    func showMenu(items: [MenuVCModel]) {
        self.arrayMenuItems = items
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuVCCollectionViewCellIdentifier", for: indexPath) as? MenuVCCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.idxMainCell = indexPath.row
        cell.menudelegate = self
        cell.arrTitle = Array(arrHeaderTitles)

        cell.appsCollectionView.reloadData()
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
    
}
