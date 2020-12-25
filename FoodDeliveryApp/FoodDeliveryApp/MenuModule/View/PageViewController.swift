//
//  PageViewController.swift
//  FoodDeliveryApp
//
//  Created by Dhaivat Vyas on 25/12/20.
//

import UIKit

class PageViewController: UIViewController {

    @IBOutlet weak var ibPageCollectionView: UICollectionView!
    @IBOutlet weak var childPageControl : UIPageControl!

    var swipeCollectionLeft : UISwipeGestureRecognizer!
    var swipeCollectionRight : UISwipeGestureRecognizer!
    
    var previousX : CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        childPageControl.numberOfPages = 3
        childPageControl.currentPage = 0
        
        childPageControl.addTarget(self, action: #selector(pageChanged(_ :)), for: .valueChanged)
        swipeCollectionLeft = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipedLeft(_:)))
        swipeCollectionLeft.delegate = self
        swipeCollectionLeft.direction = .left
        ibPageCollectionView.addGestureRecognizer(swipeCollectionLeft)
        
        swipeCollectionRight = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipedRight(_:)))
        swipeCollectionRight.delegate = self
        swipeCollectionRight.direction = .right
        ibPageCollectionView.addGestureRecognizer(swipeCollectionRight)
        
        ibPageCollectionView.showsHorizontalScrollIndicator = false
        ibPageCollectionView.isPagingEnabled = true
        ibPageCollectionView.delegate = self
        ibPageCollectionView.dataSource = self
        ibPageCollectionView.allowsMultipleSelection = false
        
    }

}

extension PageViewController : UIGestureRecognizerDelegate {
    
    @objc func pageChanged(_ sender: UIPageControl) {
        
        let pageWidth : CGFloat = ibPageCollectionView.frame.size.width
        let scrollTo : CGPoint = CGPoint(x: pageWidth * CGFloat(sender.currentPage), y: 0)
        ibPageCollectionView.setContentOffset(scrollTo, animated: true)
    }
    
    @objc func viewSwipedLeft(_ sender: UISwipeGestureRecognizer) {
        if childPageControl.currentPage == 3 {
            childPageControl.currentPage = 0
            let pageWidth : CGFloat = ibPageCollectionView.frame.size.width
            let scrollTo : CGPoint = CGPoint(x: pageWidth * CGFloat(childPageControl.currentPage), y: 0)
            ibPageCollectionView.setContentOffset(scrollTo, animated: false)
        }
    }
    
    @objc func viewSwipedRight(_ sender: UISwipeGestureRecognizer) {
        if childPageControl.currentPage == 0 {
            childPageControl.currentPage = 3
            let pageWidth : CGFloat = ibPageCollectionView.frame.size.width
            let scrollTo : CGPoint = CGPoint(x: pageWidth * CGFloat(childPageControl.currentPage), y: 0)
            ibPageCollectionView.setContentOffset(scrollTo, animated: false)
        }
    }
}

extension PageViewController: UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageVCCollectionViewCellIdentifier", for: indexPath)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        previousX = scrollView.contentOffset.x
        
        var visibleRect = CGRect()
        visibleRect.origin = ibPageCollectionView.contentOffset
        visibleRect.size = ibPageCollectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath? = ibPageCollectionView.indexPathForItem(at: visiblePoint)
        childPageControl.currentPage = visibleIndexPath!.item
                            
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //print("decelerate = ",decelerate)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
