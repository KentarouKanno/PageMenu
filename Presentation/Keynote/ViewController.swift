//
//  ViewController.swift
//  Keynote
//
//  Created by Kentarou on 2016/09/10.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var tabTitleArray = ["Tab 1", "Tab 2", "Tab 3"]
    var tab1ViewControllers: [UIViewController] = []
    var tab2ViewControllers: [UIViewController] = []
    var tab3ViewControllers: [UIViewController] = []
    var tabViewControllers: [[UIViewController]] = []
    
    var selectViewControllers: [UIViewController] = []
    var selectIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tab1ViewControllers = [(storyboard?.instantiateViewControllerWithIdentifier("tab1-1"))!,
                               (storyboard?.instantiateViewControllerWithIdentifier("tab1-2"))!,
                               (storyboard?.instantiateViewControllerWithIdentifier("tab1-3"))!]
    
        
        tab2ViewControllers = [(storyboard?.instantiateViewControllerWithIdentifier("tab2-1"))!,
                               (storyboard?.instantiateViewControllerWithIdentifier("tab2-2"))!]
        
        tab3ViewControllers = [(storyboard?.instantiateViewControllerWithIdentifier("tab3-1"))!,
                               (storyboard?.instantiateViewControllerWithIdentifier("tab3-2"))!,
                               (storyboard?.instantiateViewControllerWithIdentifier("tab3-3"))!]
        
        tabViewControllers = [tab1ViewControllers, tab2ViewControllers, tab3ViewControllers]
        selectViewControllers = tab1ViewControllers
        
        pageViewController = self.childViewControllers.first as! UIPageViewController
        setViewControllers()
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        cell.tabLabel.text = tabTitleArray[indexPath.row]
        cell.tabLabel.textColor = selectIndex == indexPath.row ? UIColor.redColor() : UIColor.blackColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabTitleArray.count
    }
    
    // Cell Size Change
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.width
        return CGSizeMake(width / CGFloat(tabTitleArray.count), 50)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectIndex = indexPath.row
        selectViewControllers = tabViewControllers[indexPath.row]
        setViewControllers()
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.delegate   = self
            pageViewController.dataSource = self
        }
    }
    
    func setViewControllers() {
        pageViewController.setViewControllers([selectViewControllers[0]], direction: .Forward, animated: false, completion: nil)
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        
        guard var index = selectViewControllers.map({$0}).indexOf(viewController) else {
            return nil
        }
        
        index = isAfter ? index + 1 : index - 1
        return index >= 0 && index < selectViewControllers.count ? selectViewControllers[index] : nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
}

// Custom Cell Class
import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var tabLabel: UILabel!
}