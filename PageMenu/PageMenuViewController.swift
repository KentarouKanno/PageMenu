//
//  PageMenuViewController.swift
//  PageMenu
//
//  Created by KentarOu on 2016/09/03.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

typealias itemType = [(viewController: UIViewController, title: String)]
typealias blockType = ((index: Int, direction: UIPageViewControllerNavigationDirection) -> Void)

class PageMenuViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    @IBOutlet weak var pageMenuView: PageMenuTabView!
    @IBOutlet weak var baseViewTopConstraint: NSLayoutConstraint!
    var _baseViewTopConstraint: CGFloat = 0
    
    var isInfinity    = false
    var tabItemsCount = 0
    var selectIndex   = 0
    var setViewControllersAnimation = false
    var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.delegate   = self
            pageViewController.dataSource = self
        }
    }
    
    var tabItems: itemType = [] {
        didSet {
            tabItemsCount = tabItems.count
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = self.childViewControllers.first as! UIPageViewController
        setViewControllers(selectIndex, animation: setViewControllersAnimation)
        
        pageMenuView.pageItemPressedBlock = { index, direction in
            self.selectIndex = index
            self.setViewControllers(index, direction: direction)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        baseViewTopConstraint.constant = _baseViewTopConstraint
    }
    
    func setViewControllers(index: Int, direction: UIPageViewControllerNavigationDirection = .Forward, animation: Bool = true) {
        pageMenuView.selectIndex = selectIndex
        pageMenuView.tabItems    = tabItems
        pageMenuView.isInfinity  = isInfinity
        pageViewController.setViewControllers([tabItems[index].viewController], direction: direction, animated: animation, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UIPageViewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        selectIndex = tabItems.map{ $0.viewController }.indexOf(pageViewController.viewControllers!.first!)!
        pageMenuView.selectIndex = selectIndex
        pageMenuView.collectionView.reloadData()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = tabItems.map({$0.viewController}).indexOf(viewController) else {
            return nil
        }
        index = isAfter ? index + 1 : index - 1
        
        if isInfinity {
            if index < 0 {
                index = tabItems.count - 1
            } else if index == tabItems.count {
                index = 0
            }
        }
        return index >= 0 && index < tabItems.count ? tabItems[index].viewController : nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
}
