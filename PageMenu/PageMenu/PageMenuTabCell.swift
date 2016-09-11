//
//  PageMenuTabCell.swift
//  PageMenu
//
//  Created by KentarOu on 2016/09/03.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class PageMenuTabCell: UICollectionViewCell {
    
    var tabItemButtonPressedBlock: (blockType)!
    @IBOutlet weak var tabMenuLabel: UILabel!
    var index: Int    = 0
    var selectIndex   = 0
    var tabItems: itemType = [] {
        didSet {
            tabMenuLabel.text = tabItems[index].title
        }
    }
    
    @IBAction func tapTabMenu(sender: UIButton) {
        if index == selectIndex {
            return
        }
        tabItemButtonPressedBlock(index: index,direction: index > selectIndex ? .Forward : .Reverse)
    }
}
