//
//  PageMenuView.swift
//  PageMenu
//
//  Created by KentarOu on 2016/09/03.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class PageMenuTabView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var pageItemPressedBlock: (blockType)!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate   = self
            collectionView.dataSource = self
        }
    }
    var isInfinity        = false
    var selectIndex       = 0 
    var pageTabItemsCount = 0
    var pageTabItemsWidth: CGFloat = 0.0
    var tabItems: itemType = [] {
        didSet {
            pageTabItemsCount = tabItems.count
            collectionView.reloadData()
        }
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PageMenuTabCell
        let fixedIndex = isInfinity ? indexPath.item % pageTabItemsCount : indexPath.item
        cell.index = fixedIndex
        cell.selectIndex = selectIndex
        cell.tabItems = tabItems
        cell.tabItemButtonPressedBlock = { index, direction in
            self.pageItemPressedBlock(index: index, direction: direction)
        }
        cell.tabMenuLabel.textColor = indexPath.item == selectIndex ? UIColor.redColor() : UIColor.blackColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInfinity ? pageTabItemsCount * 3 : pageTabItemsCount
    }
    
    // Cell Size Change
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(150, 50)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard isInfinity else { return }
        
        // 無限ループの場合以下の処理を行う
        if pageTabItemsWidth == 0.0 {
            pageTabItemsWidth = floor(scrollView.contentSize.width / 3.0)
        }
        if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > pageTabItemsWidth * 2.0) {
            scrollView.contentOffset.x = pageTabItemsWidth
        }
    }
}


